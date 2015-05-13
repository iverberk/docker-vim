FROM debian:jessie

MAINTAINER Ivo Verberk

# Use bash when building the image
RUN mv /bin/sh /bin/sh.orig && ln -s /bin/bash /bin/sh

# Install vim and build tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y vim-nox git binutils bison gcc make curl ctags silversearcher-ag python tmux

# Install Golang version manager
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer > /root/gvm-installer && \
    bash < /root/gvm-installer && \
    source /root/.gvm/scripts/gvm && \
    gvm install go1.4 && \
    gvm use go1.4 --default

# Install Ruby version manager
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    #\curl -sSL https://get.rvm.io > /root/rvm-installer && \
    #bash /root/rvm-installer stable && \
    #echo '[[ -s "/usr/local/rvm/scripts/rvm" ]] && source /usr/local/rvm/scripts/rvm' >> ~/.bashrc

RUN \curl -L https://get.rvm.io | bash -s stable

RUN /bin/bash -l -c "rvm requirements && rvm install 1.9.3 && rvm use 1.9.3 --default"

RUN echo '[[ -s "/usr/local/rvm/scripts/rvm" ]] && source /usr/local/rvm/scripts/rvm' >> ~/.bashrc

# Install Node version manager

RUN git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`

RUN echo 'source ~/.nvm/nvm.sh && nvm use 0.12 &> /dev/null' >> ~/.bashrc

RUN /bin/bash -l -c "nvm install stable && nvm use stable"

# Install Vim plugin manager
RUN git clone --depth=1 https://github.com/gmarik/Vundle.vim.git /root/.vim/bundle/Vundle.vim

# Install Vim color scheme
ADD https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Eighties.vim /root/.vim/colors/Tomorrow-Night-Eighties.vim

# Copy default vimrc
COPY vimrc /root/.vimrc

# Install Vim plugins
RUN vim +PluginInstall +qall

# Install Golang binaries
RUN source /root/.gvm/scripts/gvm && gvm use go1.4 && vim +GoInstallBinaries +qall

# Install godoc tool
RUN source /root/.gvm/scripts/gvm && gvm use go1.4 && go get golang.org/x/tools/cmd/godoc

# Set default timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

RUN /bin/bash -l -c "gem install puppet-lint puppet --no-rdoc --no-ri"

RUN /bin/bash -l -c "npm install -g js-yaml"

# Copy user specific Vim settings
COPY vimrc.user.vim /root/.vimrc.user.vim

# Copy the Vim start script
COPY start.sh /start.sh

# Copy NERDtree bookmarks
COPY NERDTreeBookmarks /root/.NERDTreeBookmarks

# Make the start script executable
RUN chmod +x /start.sh

# Start Vim by default
ENTRYPOINT ["/start.sh"]

# Restore default shell
RUN rm /bin/sh && mv /bin/sh.orig /bin/sh
