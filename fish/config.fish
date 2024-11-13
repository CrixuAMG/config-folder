alias vim nvim
alias lg lazygit
alias lq lazysql
alias ls "eza --long --git --header --icons=always"
alias z zellij
alias dbh "harlequin -a mysql -u root --password password"
alias db "rainfrog --driver=mysql --username=root --password=password --host=localhost --port=3306"
alias sf create_branch_and_commit_template

fish_add_path ~/.config/composer/vendor/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    zoxide init fish --cmd=cd | source
    thefuck --alias | source
    fzf --fish | source
    atuin init fish | source

    # symfony-autocomplete --shell=fish composer >~/.config/fish/completions/composer.fish

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

function create_branch_and_commit_template
    set -l input_string $argv[1]

    # Check if the input string starts with SF- and ends with one or more numbers
    if string match -r '^[0-9]+$' $input_string
        # Create the branch name
        set branch_name "feature/SF-$input_string"

        rm -rf ~/.gitmessage
        # Create the commit message template
        echo "SF-$input_string " >>~/.gitmessage

        git config --global commit.template ~/.gitmessage

        # Create the new branch
        git checkout -b $branch_name
    else
        echo "Invalid input."
    end
end
