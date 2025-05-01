function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience

zoxide init fish | source
thefuck --alias | source
tailscale completion fish | source

source "$HOME/.cargo/env.fish"

fish_vi_key_bindings
