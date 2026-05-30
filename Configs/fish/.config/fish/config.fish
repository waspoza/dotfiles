source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BAT_PAGER "less -RF"
set -gx MANPAGER "sh -c 'col -bx | bat -l man --paging=always -p'"
#set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
#set -gx SSH_AUTH_SOCK ~/.bitwarden-ssh-agent.sock
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"

# Skip starship entirely in MC
if set -q MC_SID
    function fish_prompt
        set -l normal (set_color normal)
        set -l color_cwd $fish_color_cwd
        set -l suffix '$'
        if functions -q fish_is_root_user; and fish_is_root_user
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            end
            set suffix '#'
        end
        echo -n -s [ (prompt_login) : (set_color $color_cwd) (prompt_pwd) $normal ] (fish_vcs_prompt) $normal $suffix " "
    end
else
    starship init fish | source
    # without it transient prompt is not working
    function starship_transient_prompt_func
        starship module custom.transient
        starship module character
    end
    enable_transience
end

alias less="TERM=xterm-256color command less"
set -gx PAGER "TERM=xterm-256color less"

alias vim="nvim"
alias vi="nvim"

# enable zoxide
#zoxide init --cmd cd fish | source
# enable fzf
fzf --fish | source
