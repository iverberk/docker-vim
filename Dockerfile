FROM debian:jessie

MAINTAINER Ivo Verberk

# Use bash when building the image
RUN mv /bin/sh /bin/sh.orig && ln -s /bin/bash /bin/sh

# Install vim and build tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y vim-nox git binutils bison gcc make curl tmux

# Install Golang version manager
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer > /root/gvm-installer && \
    bash < /root/gvm-installer && \
    source /root/.gvm/scripts/gvm && \
    gvm install go1.4 && \
    gvm use go1.4 --default

# Install FZF fuzzy finder
RUN git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Install Vim plugin manager
RUN git clone --depth=1 https://github.com/gmarik/Vundle.vim.git /root/.vim/bundle/Vundle.vim

# Install Vim color scheme
ADD https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Eighties.vim /root/.vim/colors/Tomorrow-Night-Eighties.vim

# Copy personal vimrc
COPY vimrc /root/.vimrc

# Install vim plugins
RUN vim +PluginInstall +qall

# Install Golang binaries
RUN source /root/.gvm/scripts/gvm && gvm use go1.4 && vim +GoInstallBinaries +qall

# Install godoc tool
RUN source /root/.gvm/scripts/gvm && gvm use go1.4 && go get golang.org/x/tools/cmd/godoc

# Restore default shell
RUN rm /bin/sh && mv /bin/sh.orig /bin/sh

# Set default timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

COPY start.sh /start.sh

ENTRYPOINT ["/bin/bash", "/start.sh"]
