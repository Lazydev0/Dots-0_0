# Enable Powerlevel10k instant prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enva
export PATH="$HOME/.cargo/bin:$PATH"
export GTK_THEME="LAVA-Cyan"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export PATH=$PATH:/home/nyx/.spicetify
export FZF_DEFAULT_OPTS="--color=16 --layout=reverse --border=sharp --prompt='FZF> '"

# No errors
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copyfile
zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit 
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# Custom aliases 
alias pacman_clean='sudo rm /var/lib/pacman/db.lck'
alias grep='ugrep --color=auto'
alias ip='ip -color'
alias cat='bat'
alias ls='eza -al --color=always --group-directories-first --icons'
alias anime='~/Assets/ani-cli/ani-cli'
alias tree='~/Assets/tree/gt'
alias convert='~/Scripts/img_converter.sh'
alias cp='cp -rv'
alias mv='mv -v'
alias nvim='setsid neovide'
alias rm='rm -riv'
alias vpn='protonvpn-cli c'
alias dvpn='protonvpn-cli d'
alias matrix='neo-matrix'
alias bonsai='cbonsai'
alias help='tldr'
alias btop='btop --utf-force'
alias ping='ping -c 5'
alias deploy='mimeopen'
alias clock='tty-clock'
alias fetch='fm6000 -r -c yellow -n -g 12 -l 16'
alias pipes='pipes-rs'
alias gg='git-graph --model simple'
alias ggi='git-igitt --model simple'
alias ll='npx live-server'
alias token='cat ~/Documents/Notes/Github/Lazy.txt'
# Custom Functions

function src() {
    source ~/.zshrc
    echo "Zsh configuration reloaded!"
}


function cleanup() {
    while pacman -Qdtq > /dev/null; do
        sudo pacman -R $(pacman -Qdtq)
    done
}


function backupd() {
    if [[ -z $1 ]]; then
        echo "Usage: backupd <filename>"
        return 1
    fi
    mv "$1" "$1.bak"
}


function backup() {
    if [[ -z $1 ]]; then
        echo "Usage: backup <filename>"
        return 1
    fi
    cp "$1" "$1.bak"
}


function unbak() {
    if [[ -z $1 ]]; then
        echo "Usage: unbak <filename.bak>"
        return 1
    fi
    new_filename="${1%.bak}"
    mv "$1" "$new_filename"
}

function jrun() {
    if [[ -z $1 ]]; then
        echo "Usage: jrun <filename.java>"
        return 1
    fi
    java_file="$1"
    class_name=$(basename -s .java "$java_file")
    javac -d ~/Documents/Test/assignment_4/classes "$java_file"
    if [[ $? -eq 0 ]]; then
        java -cp ~/Documents/Test/assignment_4/classes "$class_name"
    else
        echo "Compilation failed"
    fi
}



function crun() {
    if [[ -z $1 ]]; then
        echo "Usage: crun <filename.cpp>"
        return 1
    fi

    cpp_file="$1"
    executable="$HOME/Documents/Programming/Cpp/Executables/$(basename -s .cpp "$cpp_file")"

    if [[ ! -f $executable || $cpp_file -nt $executable ]]; then
        g++ -std=c++20 -o "$executable" "$cpp_file"
        if [[ $? -ne 0 ]]; then
            echo "Compilation failed"
            return 1
        fi
    fi

    if [[ -f $executable ]]; then
        "$executable"
    else
        echo "Executable not found"
        return 1
    fi
}



