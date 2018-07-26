XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

export ZSH="$XDG_DATA_HOME/oh-my-zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/compdump"
ZSH_DISABLE_COMPFIX=true
ZSH_THEME="risto"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"

export LESSHISTFILE="-"
if type lesspipe &> /dev/null; then
  LESSPIPE="$(which lesspipe)"
elif [ -x lesspipe.sh ]; then
  LESSPIPE="$(which lesspipe.sh)"
fi
if [ -n "$LESSPIPE" ]; then
  if type ifne &> /dev/null; then
    IFNE="$(which ifne)"
    if type src-hilite-lesspipe.sh &> /dev/null; then
      HILITEPIPE="$(which src-hilite-lesspipe.sh)"
    elif [ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
      HILITEPIPE='/usr/share/source-highlight/src-hilite-lesspipe.sh'
    fi
    if [ -n "$HILITEPIPE" ]; then
      export LESSOPEN="|f=%s; $LESSPIPE "\$f" | $IFNE -n $HILITEPIPE -i "\$f" -o STDOUT 2>/dev/null"
    fi
  fi
  if [ -z "$HILITEPIPE" ]; then
    export LESSOPEN="| $LESSPIPE %s"
  fi
fi

if [ -x /usr/libexec/java_home ]; then
  JAVA_HOME="$(/usr/libexec/java_home)"
else
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi
if [ -d "$JAVA_HOME" ]; then
  export JAVA_HOME
fi

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"

plugins=(
  adb
  command-not-found
  cp
  docker
  docker-compose
  pip
  python
  rsync
)

source $ZSH/oh-my-zsh.sh
autoload -U zmv

if [ -n "$SSH_CONNECTION" ] && [[ "$OSTYPE" == "darwin"* ]]; then
  security unlock-keychain "$HOME/Library/Keychains/login.keychain"
fi
if type pew &> /dev/null; then
  source "$(pew shell_config)"
fi
if type pipenv &> /dev/null; then
  source <(pipenv --completion)
fi
if type xclip &> /dev/null; then
  alias xclip='xclip -selection clipboard'
fi
if type scp &> /dev/null; then
  alias scp='scp -r'
fi
if [ -n "$TILIX_ID" ]; then
  source /etc/profile.d/vte-2.91.sh
fi
