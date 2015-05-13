" Disable vi-compatibility
set nocompatible

" Disable for Vundle initialisation
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" General
Plugin 'gmarik/Vundle.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'majutsushi/tagbar'
Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'airblade/vim-gitgutter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'Osse/double-tap'

" Languages
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'honza/vim-snippets'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'
Plugin 'rodjek/vim-puppet'

call vundle#end()

" **** Source user config ****

if filereadable("/root/.vimrc.user.vim")
       execute "source /root/.vimrc.user.vim"
endif
