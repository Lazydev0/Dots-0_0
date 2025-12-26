# Lock with fscrypt
lock() {
    local dir="$1"

    if [[ -z "$dir" ]]; then
        echo "Usage: lock <directory>"
        return 1
    fi

    fscrypt lock "$dir"
}

