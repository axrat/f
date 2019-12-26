#!/bin/bash

sudo ln -s $PWD/docs/f.sh /f.sh
sudo ln -s $PWD /f

FILE="$HOME/.bashrc"
LINE="[ -e /f.sh ] && source /f.sh"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
