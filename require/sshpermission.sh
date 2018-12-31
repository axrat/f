#!/bin/bash
sshpermission(){
  sudo find ~/.ssh/ -type d -exec sudo chmod 755 {} +
  sudo find ~/.ssh/ -type f -exec sudo chmod 600 {} +
}
