FROM ubuntu:focal

# step: raw image is minimized
RUN yes | unminimize

# step: install basic packages
RUN apt update && apt upgrade -y && apt update && \
  apt install -y software-properties-common \
   man less curl sudo git \
   vim neovim 

# step: add user
RUN useradd -ms /bin/bash guest
USER guest

WORKDIR /home/guest
