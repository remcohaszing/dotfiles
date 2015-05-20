# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=
HISTFILESIZE=
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Disable less history
export LESSHISTFILE="-"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
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

# Used by tools that use select-editor
export SELECTED_EDITOR=vim

# Python
export PYTHONSTARTUP=$HOME/.config/python/pythonrc.py
export PYTHONPATH=$PYTHONPATH:$HOME/.config/python/path
venv () {
  VENV=/tmp/$RANDOM
  virtualenv --prompt="(venv)" --extra-search-dir="$HOME/.cache/wheelhouse" "$@" $VENV
  source $VENV/bin/activate
  unset VENV
  PYLIBS="cython flake8 nose wheel yanc"
  echo -n Installing "${PYLIBS// /, }"...
  # shellcheck disable=SC2086
  pip install $PYLIBS --quiet --no-index
  unset PYLIBS
  . <(pip completion --bash)
  echo done.
}
dvenv () {
  VENV=$VIRTUAL_ENV
  deactivate
  rm -rf "$VENV"
  unset VENV
}

# Some manual completion
. <(npm completion)
source /usr/lib/node_modules/cordova/scripts/cordova.completion

# Android
ANDROID_SDK=$HOME/.local/share/android-sdk-linux
export PATH=$PATH:$ANDROID_SDK/tools
export PATH=$PATH:$ANDROID_SDK/platform-tools
for f in $ANDROID_SDK/build-tools/*; do
  export PATH=$PATH:$f
done
unset f
unset ANDROID_SDK
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# GCloud
source /home/remco/.local/share/google-cloud-sdk/path.bash.inc
source /home/remco/.local/share/google-cloud-sdk/completion.bash.inc
export MANPATH=$MANPATH:$HOME/.local/share/google-cloud-sdk/help/man
