alias vim nvim
alias ls "eza --long --git --header --icons=always"

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    zoxide init fish --cmd=cd | source
    thefuck --alias | source
    fzf --fish | source
    atuin init fish | source

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
