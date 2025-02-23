#!/bin/bash

echo "Installing trp..."

# Ensure Python is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python is not installed. Install Python and rerun this script."
    exit 1
fi

# Move trp.py to /usr/local/bin/trp
chmod +x trp.py
sudo mv trp.py /usr/local/bin/trp

# Add auto-run to Zsh
echo "Adding auto-run to ~/.zshrc..."
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.zshrc
echo 'autoload -Uz add-zsh-hook' >> ~/.zshrc
echo 'add-zsh-hook precmd trp' >> ~/.zshrc

# Add tab completion for nvim
echo "Adding tab completion for nvim..."
cat << 'EOF' >> ~/.zshrc

_trp_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ -f /tmp/.trp_errors ]]; then
        local error_paths=()
        while IFS= read -r line; do
            error_paths+=("$line")
        done < /tmp/.trp_errors
    else
        local error_paths=()
    fi
    local files=($(compgen -f -- "$cur"))
    COMPREPLY=("${error_paths[@]}" "${files[@]}")
}
complete -o nospace -F _trp_complete nvim

EOF

echo "Installation complete! Restart your terminal and try 'nvim <TAB>'!"

