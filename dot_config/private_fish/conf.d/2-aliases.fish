alias yay="yay --color=always"
alias grep="rg"
alias find="fd"

alias b="btm -C ~/.config/bottom/minimal.toml"
alias bf="btm"

alias wfpass="nmcli device wifi show-password"

alias ping="gping"
alias pport="ss -tulnp | grep LISTEN"
alias ip="ip -c -br"
alias h="history"
alias date="LC_TIME=en_GB /bin/date"

alias ff="fastfetch"
alias fff="fastfetch --config ~/.config/fastfetch/config-f.jsonc"

alias lg="lazygit"
alias ld="lazydocker"

alias l="eza --color=always --all --group-directories-first"
alias ls="eza --color=always --icons=always --all --long --git --group-directories-first --no-filesize --no-time --no-user"

alias rm="trash -v"

alias tree="erd --hidden --no-git --no-ignore --prune --human --icons --disk-usage physical --dir-order first"
alias bench="hyperfine"

alias tdu="transmission-daemon"
alias tdd="transmission-remote --exit"
alias tdl="transmission-remote --list"

alias tsu="sudo tailscale up"
alias tsd="sudo tailscale down"
alias tss="tailscale status"

# Golang
alias gomi="go mod init"
alias gomt="go mod tidy"
alias gowi="go work init"
alias gowu="go work use"
alias gor="go run"
alias gob="go build"
alias gog="go get"

# Docker
alias dps="docker ps -a --format \"table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.Status}}\""
alias d="docker"
alias dc="docker compose"

function c
    if test (count $argv) -eq 0
        zi
        l
    else
        z $argv || return
        l
    end
end

#alias cat="bat --style=plain"
function cat
    if test (count $argv) -eq 0
        set file (fzf)
        bat --style=plain $file
    else
        bat --style=plain $argv
    end
end

function cg
    set git_root (git rev-parse --show-toplevel)
    if test $status ~= 0 then
        echo "Not in git repository"
    else
        c $git_root
    end
end

function mkcd
    mkdir -p $argv || return
    c $argv
end

#alias ssh="kitty +kitten ssh"
function s
    if test (count $argv) -eq 0
        sshs
    else
        kitty +kitten ssh $argv
    end
end

# Disable kitty padding when using neovim
if test -x (command -v nvim)
    function v
        set curr (pwd)
        set hash (openssl rand -hex 16)
        mkdir -p $HOME/.cache/nvim/last_dir

        NVIM_LAST_FILENAME=$hash nvim $argv

        set last_dir_file "$HOME/.cache/nvim/last_dir/$hash"
        if test -f $last_dir_file
            set last_dir (cat $last_dir_file)

            if [ "$last_dir" = "$curr" ]
                return
            end

            c $last_dir
        end
        trash-put $last_dir_file
    end
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    trash-put -f -- "$tmp"
end

function wlppr
    hyprctl hyprpaper preload "$argv" || return

    set monitors (hyprctl monitors -j | jq -r '.[].name')
    for monitor in $monitors
        hyprctl hyprpaper wallpaper "$monitor,$argv"
    end
end
