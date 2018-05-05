#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

[[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color ]] && TERM=xterm-256color
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTFILE=$HOME/.cache/bash/history
HISTSIZE=
HISTFILESIZE=
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Disable less history
export LESSHISTFILE="-"
export LESSOPEN='|file=%s; /usr/bin/lesspipe "$file" | /usr/bin/ifne -n /usr/share/source-highlight/src-hilite-lesspipe.sh -i "$file" -o STDOUT 2>/dev/null'
export LESS=' -R '

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " %s")\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

include() {
  if hash "$1" 2> /dev/null; then
    source <("$@")
  fi
}

# enable color support of ls and also add handy aliases
if [ "$(uname)" == 'Darwin' ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias tree='tree -C'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


if [ -d "$HOME/.local/etc/bash_completion.d" ]; then
  for f in $HOME/.local/etc/bash_completion.d/*; do
    source "$f"
  done
fi

# Aliases for convenience
# Reset the terminal scrollback and follow the contents of a file
alias follow='reset; tail -f -n +0'
# Make scp always recursive
alias scp='scp -r'

# Used by tools that use select-editor
export SELECTED_EDITOR=vim

# Python
export PYTHONSTARTUP=$HOME/.config/python/pythonrc.py
export PYTEST_ADDOPTS='--cov --no-cov-on-fail'

include thefuck --alias

# Some manual completion
source /usr/share/doc/tmux/examples/bash_completion_tmux.sh 2> /dev/null
#source <(pip completion --bash) 2> /dev/null
include pip --disable-pip-version-check completion --bash
include pipenv --completion
include npm completion
if hash find_pycompletion.sh 2> /dev/null; then
  source "$(find_pycompletion.sh)"
fi
source "$(dirname "$(dirname "$(which cordova)")")"/lib/node_modules/cordova/scripts/cordova.completion 2> /dev/null
source "$(dirname "$(dirname "$(which gulp)")")"/lib/node_modules/gulp/completion/bash 2> /dev/null
source "$(dirname "$(dirname "$(which grunt)")")"/lib/node_modules/grunt-cli/completion/bash 2> /dev/null

# Npm tool aliases
alias node-debug='node --inspect --inspect-brk "$(readlink -f "$(which appsemble-build)")"'

# Ruby gems
if [ -d "$HOME/.gem/ruby" ]; then
  for f in $HOME/.gem/ruby/**; do
    export PATH=$f/bin:$PATH
  done
fi
# Android
if [ -d "$ANDROID_HOME/build-tools" ]; then
  for f in $ANDROID_HOME/build-tools/*; do
    export PATH=$f:$PATH
  done
fi
if [ -x /usr/libexec/java_home ]; then
  JAVA_HOME="$(/usr/libexec/java_home)"
else
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi
export JAVA_HOME

# GCloud
#export CLOUDSDK_PYTHON=python2.7

# OSX specific configx
if hash brew 2>/dev/null; then
  source "$(brew --prefix)/etc/bash_completion"
fi

unset include

if [ -f "$HOME/.travis/travis.sh" ]; then
  source "$HOME/.travis/travis.sh"
fi

# added by travis gem
[ -f /home/remco/.travis/travis.sh ] && source /home/remco/.travis/travis.sh
#PATH="$HOME/.local/share/google-cloud-sdk/bin:$PATH"
