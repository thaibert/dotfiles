export ZSH="$HOME"/.zsh
export ZSH_CUSTOM="$ZSH"/setup

source $ZSH/.antigenrc

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

for file ("$ZSH_CUSTOM"/*.zsh); do
  source "$file"
done
unset file

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

