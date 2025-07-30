# bitwarden CLI support
if ping -c 1 -t 1 rxml.xyz &>/dev/null
then
    eval "$(bw completion --shell zsh); compdef _bw bw;"
fi
