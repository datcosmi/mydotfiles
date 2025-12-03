if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    # Neofetch on startup
    neofetch

    # Disable welcome
    set fish_greeting ""

    # Set up fzf key bindings
    fzf --fish | source
end
