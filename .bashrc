# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# added by Anaconda3 4.3.0 installer
export PATH="/home/ashukla/anaconda3/bin:$PATH"
export BROWSER="/usr/bin/firefox"

alias sbrc='source ~/.bashrc'
alias vbrc='vim ~/.bashrc'
alias onyx='ssh arjunshukla@onyx.boisestate.edu'
alias pa3='cd /home/ashukla/backpack/backpack/CS450-1-s19/PA3'

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xf $1      ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know '$1'..." ;;
      esac
  else
	echo "'$1' is not a valid file!"
fi
}

alias ij='~/idea-IC-183.5912.21/bin/idea.sh & > /dev/null'

CS450_EX_DIR="/home/ashukla/ArjunShukla@u.boisestate.edu/backpack/CS450-1-s19/PA2/lib"

#MeggyJava Compile
function mjc()  { java -jar /home/ashukla/ArjunShukla@u.boisestate.edu/backpack/CS450-1-s19/PA2/lib/MJ.jar --usage $1 ; }

#MeggyJava Simulator Execute
function mjse() { java -jar /home/ashukla/ArjunShukla@u.boisestate.edu/backpack/CS450-1-s19/PA2/lib/MJSIM.jar -b -f $1 ; }

#MeggyJava arg_opts
function mjao() 
{
    cp $1 $CS450_EX_DIR/MeggyBuildandRun/meggy/arg_opts ;
    chmod +x $CS450_EX_DIR/MeggyBuildandRun/meggy/arg_opts ;
}

function mjcp()
{
    cp $1 $2
    sed -i "s/`basename $1 .java`/`basename $2 .java`/g" $2
}

alias rmmj='rm *.java.ast.dot *.java.ST.dot *.java.s '


. ~/.git_prompt.sh
export HADOOP_HOME=~/hadoop-install/hadoop-2.9.2
export JAVA_HOME=/usr/lib/jvm/java-1.8.0
export ANT_HOME="~/apache-ant-1.9.14"
export ECLIPSE_HOME="/home/ashukla/eclipse/java-2019-06/eclipse"
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$ANT_HOME/bin:$ECLIPSE_HOME:$PATH
