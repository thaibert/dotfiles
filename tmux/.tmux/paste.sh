#!/bin/bash

os="$(uname -s)" # -s is --kernel-name
case "${os}" in
  Linux*)   machine="linux";
            if (grep --quiet --ignore-case "microsoft" /proc/version); then
              machine="wsl";
            fi ;;
  Darwin*)  machine="mac";;
  *)        machine="UNKNOWN:${os}";;
esac

case "${machine}" in
  wsl*) "/mnt/c/Program Files/Git/usr/bin/cat.exe" /dev/clipboard;;
  linux*) echo "TODO: linux clipboard integration missing";;
  mac*) pbpaste;;
  *) echo "Could not get clipboard: OS unknown: ${machine}"
esac

