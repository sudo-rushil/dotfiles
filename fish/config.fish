/opt/homebrew/bin/brew shellenv | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr --add l "ls -lah"
    abbr --add c "clear"

    oh-my-posh init fish --config ~/.dotfiles/rushilma.omp.toml | source
end


