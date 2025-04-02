alias k="kubectl"

if [ -f "$(which kubectl)" ]; then
  source <(kubectl completion zsh)
fi


