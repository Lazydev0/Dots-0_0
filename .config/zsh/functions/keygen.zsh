keygen() {
	if [[ -z "$1" || -z "$2" ]]; then
		echo "Usage: keygen <mail> <keyname>"
		return 1
	fi
	ssh-keygen -t ed25519 -C "$1" -f "$HOME/.ssh/$2" 
}
