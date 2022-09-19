FROM ubuntu:focal

# step: raw image is minimized
RUN yes | unminimize

# note: disable apt interaction
# If not disabled, apt may require input
# e.g.
# 	Please select the geographic area in which you live. Subsequent configuration questions will narrow this down by presenting a list of cities, representing
# 	the time zones in which they are located.
# 	1. Africa   3. Antarctica  5. Arctic  7. Atlantic  9. Indian    11. SystemV  13. Etc
# 	2. America  4. Australia   6. Asia    8. Europe    10. Pacific  12. US
# Ref: https://stackoverflow.com/questions/59692797/how-to-fill-user-input-for-interactive-command-for-run-command
ENV DEBIAN_FRONTEND noninteractive

# step: install basic packages
RUN apt update && apt upgrade -y && apt update && \
  apt install -y software-properties-common \
   man less sudo rsync curl iptables iproute2 \
	 python3-dev cmake git vim neovim \
	 tmux iftop htop

# step: add user
RUN useradd -ms /bin/bash guest
# sudoer
RUN usermod -aG sudo guest
# set password "guest"
# RUN echo "guest:guest" | chpasswd
# no password (for sudo)
RUN passwd --delete guest

USER guest

WORKDIR /home/guest
