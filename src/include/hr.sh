#!/bin/bash
hr(){
  CHAR=${1:-"-"}
  for i in `seq 1 $(tput cols)`
  do
    printf "${CHAR}";
  done
}
