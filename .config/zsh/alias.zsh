# Essentials
alias ip='ip -color'
alias neofetch='catnap'
alias ping='ping -c 5'
alias cp='cp -rv'
alias mv='mv -v'
alias ll='live-server'
alias deploy='mimeopen'
alias matrix='cmatrix -c -r -u 5'
alias bonsai='cbonsai'
alias clock='tty-clock -c -C 4 -B'
alias tsrc='source $HOME/.config/tmux/tmux.conf'
alias grep='rg'
alias io='caligula'
alias img='kitty +kitten icat'
alias fetch='fm6000 -wally -c yellow -n -g 12 -l 16 --not-de'

# User Aliases
alias paclock='sudo fuser -v /var/lib/pacman/db.lck || sudo rm -f /var/lib/pacman/db.lck'
alias kill_orphans='sudo pacman -Rns $(pacman -Qdtq || true)'
alias kill_pkgcache='sudo paccache -r -k 2'
alias kill_aurcache='yay -Sc --noconfirm'
alias kill_journal='sudo journalctl --vacuum-size=100M'
alias kill_tmp='sudo systemd-tmpfiles --clean'
alias kill_wallcache='rm -rf ~/.cache/wall_cache/wallselect_icons/'
alias kill_screenshots='rm -rf "$HOME/Pictures/Screenshots/"*'
alias gg='git-graph --model simple'
alias blud='figlet -f Bloody'
alias fig='figlet -f "ANSI Shadow"'
alias src='source ~/.zshrc && echo "Zsh configuration reloaded!"'
alias user_services='systemctl --user list-unit-files --type=service'
alias system_services='systemctl list-unit-files --type=service'
alias wifi_list='nmcli device wifi list'
alias wifi_connect='nmcli device wifi connect'
alias sync_notes="rsync -rv --delete --exclude='.git/' $HOME/Documents/Notes/ phone:/storage/emulated/0/Documents/Notes/"



