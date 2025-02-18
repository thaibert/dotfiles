setopt globdots  # Enable tab-completion of files starting with "."

# Hide "." and ".." in tab-completion (unless actively referring to them)
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
