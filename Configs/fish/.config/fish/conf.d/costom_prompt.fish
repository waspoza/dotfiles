# name: mc's prompt
# author: Hans Geel
# installation
#   for single user: ~/.config/fish/conf.d/mc_fish_prompt.fish
#   for all users: /etc/fish/conf.d/mc_fish_prompt.fish

function mc_git_prompt
    set gitbranch (git branch --show-current 2> /dev/null)
    if test $status -eq 0
        set gitchanges (git status -s)

        set_color normal

        if test (count $gitchanges) -eq 0
            set gitcolor normal
        else
            set gitcolor yellow
        end

        echo -s (set_color $gitcolor) "[" $gitbranch "] "
    end
end

function mc_pwd_prompt

    set mcpwd (string replace $HOME "~" $PWD)
    set splitpwd (string split -n / $mcpwd)
    set pwdcount (count $splitpwd)

    if test $pwdcount -eq 0
        echo /
    else
        # echo $splitpwd[$pwdcount]
        prompt_pwd --full-length-dirs 2
    end

end

function fish_prompt --description 'Write out the prompt'

    set laststatus $pipestatus

    if test $USER = root -o $USER = toor
        set prompttrail "# "
        set usercolor red
    else
        set prompttrail "\$ "
        set usercolor cyan
    end

    set exitstatus (__fish_print_pipestatus "(" ") " "|" (set_color red) (set_color --bold red) $laststatus)
    echo -s (set_color $usercolor) $USER " " (set_color --bold brgreen) (mc_pwd_prompt) " " (mc_git_prompt) $exitstatus (set_color normal) $prompttrail

end
