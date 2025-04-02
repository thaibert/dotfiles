git_root="$HOME/dotfiles"

export PATH="${git_root}/scripts/bin:$PATH"

mkdir -p "${git_root}/scripts/bin"
ln --symbolic --force "${git_root}/scripts/git-bin.zsh" "${git_root}/scripts/bin/git"

