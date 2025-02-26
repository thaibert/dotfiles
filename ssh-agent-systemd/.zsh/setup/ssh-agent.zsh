export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
systemctl --user start ssh-agent
systemctl --user enable ssh-agent
