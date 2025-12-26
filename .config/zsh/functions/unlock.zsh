# Undo fscrypt lock
unlock() {
    local dir="$1"

    if [[ -z "$dir" ]]; then
        echo "Usage: unlock <directory>"
        return 1
    fi

    fscrypt unlock "$dir"
}

