#!/usr/bin/env zsh
LOCAL_PREFIX="$HOME/.local"
XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$LOCAL_PREFIX/share"

ZSH="$XDG_DATA_HOME/oh-my-zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/compdump"
ZSH_DISABLE_COMPFIX=true
ZSH_THEME="risto"
CASE_SENSITIVE="true"
PROMPT_EOL_MARK='🚫'
export LESS='-FR -x2'
export GOPATH="$LOCAL_PREFIX"
export NODE_EXTRA_CA_CERTS="$XDG_DATA_HOME/mkcert/rootCA.pem"

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

zstyle ':omz:update' mode disabled

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"
fpath+="$ZSH/plugins/adb"
fpath+="$ZSH/plugins/docker"
fpath+="$ZSH/plugins/pip"
fpath+="$ZSH/plugins/yarn"

plugins=(
  colored-man-pages
  command-not-found
  git
  history-substring-search
  node-bin
  poetry
  zsh-autosuggestions
)

alias strip-colors="sed 's/\\x1b\\[[0-9;]*m//g'"
setopt histignorespace
source "$ZSH/oh-my-zsh.sh"
autoload -U zmv
PROMPT='%{$fg[green]%}%n@%m:%{$fg_bold[blue]%}%~ $(git_prompt_info)%{$reset_color%}%(!.#.$) '
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey '^H' backward-kill-word
tabs 2

if [[ -d "$ANDROID_SDK_ROOT/build-tools" ]]; then
  ANDROID_BUILD_TOOLS="$ANDROID_SDK_ROOT/build-tools/$(ls "$ANDROID_SDK_ROOT/build-tools" | head -1)"
  if [[ -d "$ANDROID_BUILD_TOOLS" ]]; then
    path+="$ANDROID_BUILD_TOOLS"
  fi
  unset ANDROID_BUILD_TOOLS
fi

function chpwd() {
  if [ -d .git ]; then
    git status --short
  fi
}

function _print_status() {
  local code=$?
  if [ $code -ne 0 ] && [ $code -ne 130 ] && [ $code -ne 141 ]; then
    echo "Exit code: \u001b[31m$code\u001b[0m"
  fi
}

precmd_functions+=(_print_status)

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
if (( $+commands[code] )); then
  alias code='code --goto'
fi
if (( $+commands[doctl] )); then
  source <(doctl completion zsh)
fi
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi
if (( $+commands[helm] )); then
  source <(helm completion zsh)
fi
if (( $+commands[ip] )); then
  alias ip='ip -c'
fi
if (( $+commands[npm] )); then
  source <(npm completion)
fi
if (( $+commands[pew] )); then
  source "$(pew shell_config)"
fi
if (( $+commands[thefuck] )); then
  source <(thefuck --alias)
fi
if (( $+commands[xclip] )); then
  alias xclip='xclip -selection clipboard'
fi
if (( $+commands[scp] )); then
  alias scp='scp -r'
fi
if (( $+commands[xdg-open] )); then
  alias open='xdg-open'
fi
if [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ]; then
  source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
if [[ -f "$XDG_CONFIG_HOME/tabtab/zsh/__tabtab.zsh" ]]; then
  source "$XDG_CONFIG_HOME/tabtab/zsh/__tabtab.zsh"
fi
if (( $+TILIX_ID )) && [ -f /etc/profile.d/vte-2.91.sh ]; then
  source /etc/profile.d/vte-2.91.sh
fi
if [ -f "$XDG_DATA_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$XDG_DATA_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
if [ -d "$XDG_DATA_HOME/completion" ]; then
  for file in "$XDG_DATA_HOME/completion/"*; do
    source "$file"
  done
fi
