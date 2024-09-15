alias vim nvim
alias lg lazygit
alias lq lazysql
alias ls "eza --long --git --header --icons=always"
alias z zellij
alias db "harlequin -a mysql -u root --password password"

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    zoxide init fish --cmd=cd | source
    thefuck --alias | source
    fzf --fish | source
    atuin init fish | source
    chezmoi completion fish --output=~/.config/fish/completions/chezmoi.fish

    function bind_bang
        switch (commandline -t)[-1]
            case "!"
                commandline -t -- $history[1]
                commandline -f repaint
            case "*"
                commandline -i !
        end
    end

    function bind_dollar
        switch (commandline -t)[-1]
            case "!"
                commandline -f backward-delete-char history-token-search-backward
            case "*"
                commandline -i '$'
        end
    end

    function fish_user_key_bindings
        bind ! bind_bang
        bind '$' bind_dollar
    end
end
