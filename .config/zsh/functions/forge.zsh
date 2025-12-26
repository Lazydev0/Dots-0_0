# Run rust programs efficiently
forge() {
    if [[ -z "$1" ]]; then
        echo "Usage: forge [args...] <project_name>"
        return 1
    fi

    local bin_name="$1"
    shift
    cargo run --quiet --bin "$bin_name" -- "$@"
}

