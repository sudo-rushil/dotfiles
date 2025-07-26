HISTFILE=$HOME/.local/share/zsh/history

#zstyle :compinstall filename "${ZDOTDIR:-$HOME}/.zshrc"
#autoload -Uz compinit && compinit

export XDG_CONFIG_HOME=~/.config

# Lazy load Zsh function files from directory
ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)

setopt autocd extendedglob notify
autoload zmv

export EDITOR=nvim

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Activate homebrew
# (( $+commands[brew] )) || return 1
eval $(/opt/homebrew/bin/brew shellenv)

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

# magic enter
zstyle :zshzoo:magic-enter command 'l .'
zstyle :zshzoo:magic-enter git-command 'git status -sb .'

# GPG
unset SSH_AGENT_PID
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent



export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/24.0.1"
