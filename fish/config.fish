/opt/homebrew/bin/brew shellenv | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr --add l "ls -lah"
    abbr --add c "clear"
    abbr --add cat "bat"

    oh-my-posh init fish --config ~/.config/rushilma.omp.toml | source
end


