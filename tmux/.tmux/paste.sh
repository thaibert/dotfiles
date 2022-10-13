#!/bin/bash

os="$(uname --kernel-name)"
case "${os}" in
	Linux*)		machine="linux";
			if (grep --quiet --ignore-case "microsoft" /proc/version); then
				machine="wsl";
			fi ;;
	Darwin*)	machine="mac";;
	*)		machine="UNKNOWN:${os}"
esac

case "${machine}" in
	wsl*)	"/mnt/c/Program Files/Git/usr/bin/cat.exe" /dev/clipboard;;
	linux*)	echo "TODO: linux clipboard integration missing";;
	mac*)	echo "TODO: macOS clipboard integration missing";;
	*)	echo "Could not get clipboard: OS unknown: ${machine}"
esac

