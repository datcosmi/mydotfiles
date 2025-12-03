function inv --wraps="nvim $(fzf -m --preview='bat --color=always {}')" --description "alias inv=nvim /home/ivan/.config/fish/functions/ls.fish"
    nvim $(fzf -m --preview="bat --color=always {}") $argv
end
