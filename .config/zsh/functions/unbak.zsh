# Unback backed up files
unbak() {
    if [[ -z "$1" ]]; then
        echo "Usage: unbak <filename.bak>"
        return 1
    fi

    local new_filename="${1%.bak}"
    mv "$1" "$new_filename"
}

