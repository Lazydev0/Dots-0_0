# Better cat
cat() {
    if [[ "$1" == "--plain" ]]; then
        shift
        bat --plain "$@"
        return
    fi

    bat "$@"
}

