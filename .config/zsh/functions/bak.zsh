# Backup files
bak() {
    if [[ -z "$1" ]]; then
        echo "Usage: bak <filename>"
        return 1
    fi
    mv "$1" "$1.bak"
}

