# Better ls
ls() {
    if [[ "$1" == "--plain" ]]; then
        shift
        eza "$@"
        return
    fi

    eza -al --group-directories-first --icons "$@"
}

