#!/bin/bash
function pkg(){
  PKG1=("nano" "make" "gcc" "expect")
  PKG2=("curl" "wget" "git" "tree" "jq" "nginx")
  PKG3=("zip" "python" "python-dev" "python3" "python3-dev" "ncurses-dev")
  MERGED=(${PKG1[*]} ${PKG2[*]} ${PKG3[*]})
  echo "${MERGED[@]}"
}
