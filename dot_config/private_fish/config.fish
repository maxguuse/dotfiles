if status is-interactive
    # Commands to run in interactive sessions can go here
end

set newPath "$HOME/.cargo/bin:$HOME/.local/bin:/snap/bin:$HOME/node_modules/.bin/:$HOME/go/bin/:/usr/local/go/bin"
if not contains -- "$newPath" $PATH
    set -gx PATH $PATH $newPath
end

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

set -U fish_greeting ""
