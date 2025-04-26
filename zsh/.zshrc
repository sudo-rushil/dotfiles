HISTFILE=$HOME/.local/share/zsh/history
#HISTSIZE=1000000
#SAVEHIST=1000000

# setopt appendhistory autocd extendedglob notify nomatch globdots
# unsetopt beep

#zstyle :compinstall filename "${ZDOTDIR:-$HOME}/.zshrc"
#autoload -Uz compinit && compinit

# Lazy load Zsh function files from directory
#ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
#fpath=($ZFUNCDIR $fpath)
#autoload -Uz $ZFUNCDIR/*(.:t)

setopt autocd extendedglob notify

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Run antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

# Source things in .zshrc.d
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

# prompt
autoload -Uz promptinit && promptinit && prompt pure
PURE_PROMPT_SYMBOL="-"
zstyle :prompt:pure:success white
zstyle :prompt:pure:continuation magenta
