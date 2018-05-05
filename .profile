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

GRADLE_HOME="$HOME/.local/share/gradle"
if [ -d "$GRADLE_HOME" ]; then
  PATH="$GRADLE_HOME/bin:$PATH"
fi

ANDROID_HOME="$HOME/.local/share/android-sdk"
if [ -d "$ANDROID_HOME" ]; then
  export ANDROID_HOME
  PATH="$ANDROID_HOME/platform-tools:$PATH"
  PATH="$ANDROID_HOME/tools:$PATH"
  PATH="$ANDROID_HOME/tools/bin:$PATH"
fi

export PATH
export MOZ_USE_OMTC=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export QT_QPA_PLATFORMTHEME=qt5ct
