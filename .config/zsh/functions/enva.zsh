# Create python3.11 virtual enva
enva() {
    local env_name="${1:-venv}"

    if [[ -d "$env_name" ]]; then
        echo "Virtual environment '$env_name' already exists. Activating it..."
    else
        echo "Creating virtual environment '$env_name'..."
        python3.11 -m venv "$env_name"
    fi

    source "$env_name/bin/activate"
}

