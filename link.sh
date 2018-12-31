#!/bin/bash
unlink(){
  sudo rm -f /f.sh
  sudo rm -f /f
}
link(){
  sudo ln -s $PWD/source.sh /f.sh
  sudo ln -s $PWD /f
}
unlink
link

FILE="$HOME/.bashrc"
LINE="[ -e /f.sh ] && source /f.sh"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
