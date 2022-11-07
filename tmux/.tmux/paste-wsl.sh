#!/bin/bash
_cat="/mnt/c/Program Files/Git/usr/bin/cat.exe"
_dos2unix="/mnt/c/Program Files/Git/usr/bin/dos2unix.exe"

"$_cat" /dev/clipboard | "$_dos2unix"

