#!/usr/bin/env zsh
XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

ZSH="$XDG_DATA_HOME/oh-my-zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/compdump"
ZSH_DISABLE_COMPFIX=true
ZSH_THEME="risto"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"



export LESSHISTFILE="-"
if (( $+commands[lesspipe] )); then
  LESSPIPE="lesspipe"
elif (( $+commands[lesspipe.sh] )); then
  LESSPIPE="lesspipe.sh"
fi
if (( $+LESSPIPE )); then
  export LESSOPEN="|f=%s; $LESSPIPE \$f"
  if (( $+commands[ifne] )); then
    IFNE="ifne"
    if (( $+commands[src-hilite-lesspipe.sh] )); then
      HILITEPIPE="src-hilite-lesspipe.sh"
    elif [ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
      HILITEPIPE='/usr/share/source-highlight/src-hilite-lesspipe.sh'
    fi
    if (( $+HILITEPIPE )); then
      export LESSOPEN="$LESSOPEN | $IFNE -n $HILITEPIPE -i \"\$f\" -o STDOUT 2>/dev/null"
    fi
  fi
fi

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"
fpath+="$ZSH/plugins/adb"
fpath+="$ZSH/plugins/docker"
fpath+="$ZSH/plugins/docker-compose"
fpath+="$ZSH/plugins/pip"
fpath+="$ZSH/plugins/yarn"

plugins=(
  command-not-found
)

setopt histignorespace
source "$ZSH/oh-my-zsh.sh"
autoload -U zmv
PROMPT='%{$fg[green]%}%n@%m:%{$fg_bold[blue]%}%~ $(git_prompt_info)%{$reset_color%}%(!.#.$) '

if (( $+SSH_CONNECTION )); then
  export LANG=en_US.UTF-8
  export LC_ADDRESS="$LANG"
  export LC_ALL="$LANG"
  export LC_CTYPE="$LANG"
  export LC_IDENTIFICATION="$LANG"
  export LC_MEASUREMENT="$LANG"
  export LC_MONETARY="$LANG"
  export LC_NAME="$LANG"
  export LC_NUMERIC="$LANG"
  export LC_PAPER="$LANG"
  export LC_TELEPHONE="$LANG"
  export LC_TIME="$LANG"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    security unlock-keychain "$HOME/Library/Keychains/login.keychain"
  fi
fi
if [[ -d "$ANDROID_SDK_ROOT/build-tools" ]]; then
  ANDROID_BUILD_TOOLS="$ANDROID_SDK_ROOT/build-tools/$(ls "$ANDROID_SDK_ROOT/build-tools" | head -1)"
  if [[ -d "$ANDROID_BUILD_TOOLS" ]]; then
    export PATH="$ANDROID_BUILD_TOOLS:$PATH"
  fi
  unset ANDROID_BUILD_TOOLS
fi
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi
if (( $+commands[npm] )); then
  source <(npm completion)
fi
if (( $+commands[pew] )); then
  source "$(pew shell_config)"
fi
if (( $+commands[pipenv] )); then
  source <(pipenv --completion)
fi
if (( $+commands[xclip] )); then
  alias xclip='xclip -selection clipboard'
fi
if (( $+commands[scp] )); then
  alias scp='scp -r'
fi
if [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ]; then
  source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
if (( $+TILIX_ID )) && [ -f /etc/profile.d/vte-2.91.sh ]; then
  source /etc/profile.d/vte-2.91.sh
fi
if [ -f "$XDG_DATA_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$XDG_DATA_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
