#!/bin/bash
set -eu -o pipefail

cd .yui_tools
bash ./setup.sh

read -n 1 -s -r -p 'Testing neovim.'
nvim
# nvim -c PlugInstall
read -n 1 -s -r -p 'Testing vim.'
vim

read -n 1 -s -r -p 'Test htop. Is Battery visible?'
mkdir -p ~/.config/htop
cp templates/htop/htoprc ~/.config/htop/htoprc
htop

read -n 1 -s -r -p 'Test iftop'
cp templates/iftop/iftoprc ~/.iftoprc
sudo iftop

read -n 1 -s -r -p 'Test tmux. exit tmux when done'
tmux
