# Essentials
alias sudo='doas'
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
alias img='kitty +kitten icat'
alias fetch='fm6000 -wally -c yellow -n -g 12 -l 16 --not-de'

# User Aliases
alias paclock='sudo rm /var/lib/pacman/db.lck'
alias kill_orphans='sudo pacman -Rns $(pacman -Qdtq)'
alias kill_journal='sudo journalctl --vacuum-size=100M'
alias kill_pkgcache="sudo paccache -r"
alias kill_usrcache="rm -rf ~/.cache/*"
alias kill_wallcache='rm -rf ~/.cache/wall_cache'
alias kill_tmp="sudo rm -rf /tmp/* /var/tmp/*"
alias kill_parucache="sudo rm -rf $HOME/.cache/paru/clone/*"
alias kill_logs="sudo find /var/log -type f -name '*.log' ! -name 'pacman.log' -delete"
alias kill_screenshots="rm -rf $HOME/Pictures/Screenshots/*"
alias gg='git-graph --model simple'
alias blud='figlet -f Bloody'
alias fig='figlet -f "ANSI Shadow"'
alias src='source ~/.zshrc && echo "Zsh configuration reloaded!"'
alias user_services='systemctl --user list-unit-files --type=service'
alias system_services='systemctl list-unit-files --type=service'
alias wifi_list='nmcli device wifi list'
alias wifi_connect='nmcli device wifi connect'
alias sync_obsidian="rsync -rv --delete --exclude='.git/' --exclude='.obsidian/' $HOME/Documents/Notes/ phone:/storage/emulated/0/Documents/Notes/"



