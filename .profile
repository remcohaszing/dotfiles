#!/bin/sh
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -x /usr/libexec/java_home ]; then
  JAVA_HOME="$(/usr/libexec/java_home)"
else
  JAVA_HOME=/usr/lib/jvm/default-java
fi
if [ -d "$JAVA_HOME" ]; then
  export JAVA_HOME
fi

export PATH
export QT_QPA_PLATFORMTHEME=qt5ct
