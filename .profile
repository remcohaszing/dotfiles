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

if [ -x /usr/libexec/java_home ]; then
  JAVA_HOME="$(/usr/libexec/java_home)"
else
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi
if [ -d "$JAVA_HOME" ]; then
  export JAVA_HOME
fi

export PATH
export QT_QPA_PLATFORMTHEME=qt5ct
