source /usr/share/cachyos-fish-config/cachyos-config.fish

starship init fish | source

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

alias cat="bat"
alias hx="helix"
alias sync_configs="/usr/share/scripts/autoupdate/sync_configs.sh"
