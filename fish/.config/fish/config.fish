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

function starship_transient_prompt_func
    starship module character
end
starship init fish | source
# without it transient prompt is not working
function starship_transient_prompt_func
    starship module custom.transient
    starship module character
end
enable_transience

alias less="TERM=xterm-256color command less"
set -gx PAGER "TERM=xterm-256color less"

alias vim="nvim"
alias vi="nvim"

# enable zoxide
#zoxide init --cmd cd fish | source
# enable fzf
fzf --fish | source
