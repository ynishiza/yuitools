# Initial setup
Copy configs
```
mkdir -p ~/.gnupg
cp ~/.yui_tools/gnupg/*.confg ~/.gnupg/
```


# SSH with gnupg

Step 1) Install `pinentry`
```
$ brew install pinentry-mac pinentry pinentry-curses
```


Step 2) Check `gpg-agent` settings\
Make sure `enable-ssh-support` is set
```
# Check `gpg-agent.conf`
$ cat ~/.gnupg/gpg-agent.conf
log-file /Users/yuinishizawa/logs/gpg-agent.log
debug-level expert
debug-pinentry
# pinentry
pinentry-program /usr/local/bin/pinentry-curses

# ssh with gpg
enable-ssh-support
```


Step 3) configure `ssh` to use `gnupg`\
step 3a: setup shell environent
```
# e.g. .bashrc
$ cat ~/.bashrc
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)     # tell ssh and ssh-dd to use gpg-agent
gpgconf --launch gpg-agent    # start gpg-agent if not started

# If using pinentry-curses
export GPG_TTY=$(tty)
echo “UPDATESTARTUPTTY” | gpg-connect-agent > /dev/null 2>&1
```

step 3b) set ssh config
```
$ cat ~/.ssh/config
# UPDATESTARTUPTTY: tell ssh which tty to use
# See 'man gpg-agent'
# Ref: https://unix.stackexchange.com/questions/280879/how-to-get-pinentry-curses-to-start-on-the-correct-tty
Match host * exec "echo 'UPDATESTARTUPTTY' | gpg-connect-agent > /dev/null 2>&1"
```


step 3c) Set keygrip
```
$ gpg -K --with-keygrip

# add to ~/.gnupg/sshcontrol
$ cat ~/.gnupg/sshcontrol
# Keygrip
E78ED33035A8CB6ECF933BE28247BE807C1AE907
```

Step 4) Restart
```
$ gpgconf --kill all
```
