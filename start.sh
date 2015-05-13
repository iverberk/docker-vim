#!/bin/bash

. /root/.bashrc

GOPATH=/Users/Ivo/Projects/Go tmux -2 -u new -s vim  "vim --cmd \"cd $1\" $2"
