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
autoload -Uz compinit
compinit

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
zstyle :prompt:pure:path:separator dim yes
zstyle :prompt:pure:git show no

my_jj_state=
my_precmd() {
  my_jj_state=$(jj log -r@ --no-graph --no-pager -T 'separate(" ", change_id.shortest(),          
  bookmarks.join(", "), if(conflict, "x"), if(empty, "", "*"), surround("\"", "\"", description.first_line()))')
}
add-zsh-hook precmd my_precmd

prompt_pure_precustom() {
  psvar[23]="$my_jj_state"
}

# magic enter
zstyle :zshzoo:magic-enter command 'l .'
zstyle :zshzoo:magic-enter git-command 'jj'

# GPG
unset SSH_AGENT_PID
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# LLVM support
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
export PATH="$PATH:$(brew --prefix)/opt/riscv-gnu-toolchain/bin"

# Zig
export PATH="/Users/rushilma/.zig:$PATH"

# Keys
source $ZDOTDIR/.env

# bun completions
[ -s "/Users/rushilma/.bun/_bun" ] && source "/Users/rushilma/.bun/_bun"
export PATH="/Users/rushilma/.bun/bin:$PATH"
