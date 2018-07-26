#!/bin/sh
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

GRADLE_HOME="$HOME/.local/share/gradle"
if [ -d "$GRADLE_HOME" ]; then
  PATH="$GRADLE_HOME/bin:$PATH"
fi

ANDROID_SDK_ROOT="$HOME/.local/share/android-sdk"
if [ -d "$ANDROID_SDK_ROOT" ]; then
  export ANDROID_SDK_ROOT
  PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
  PATH="$ANDROID_SDK_ROOT/tools:$PATH"
  PATH="$ANDROID_SDK_ROOT/tools/bin:$PATH"
fi

if [ -d "$HOME/.gem/ruby" ]; then
  for f in $HOME/.gem/ruby/**; do
    PATH=$f/bin:$PATH
  done
fi

export PATH
export MOZ_USE_OMTC=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export QT_QPA_PLATFORMTHEME=qt5ct
