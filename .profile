#!/bin/sh

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
ANDROID_HOME="$HOME/.local/share/android-sdk-linux"
if [ -d "$ANDROID_HOME" ]; then
  export ANDROID_HOME
  PATH="$ANDROID_HOME/platform-tools:$PATH"
  PATH="$ANDROID_HOME/tools:$PATH"
fi

export PATH
export MOZ_USE_OMTC=1
export WORKON_HOME=$HOME/.local/share/virtualenvs
