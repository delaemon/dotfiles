# .bashrc

# User specific aliases and functions

alias v='vim'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

exec fortune | cowsay
figlet -f slant Welcome to the `hostname`
export PS1='\u:\h:\w@\t $ '
