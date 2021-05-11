#!/bin/bash
fast(){
  if ! type "unzip" > /dev/null 2>&1
  then
    echo "[unzip] Command Not Found"
  else
    if [ $# -ne 2 ]; then
      echo "Require Bitbucket [repouser],[reponame]"
    else
      USERNAME=$1
      REPONAME=$2
      wget --user=$USERNAME --ask-password https://bitbucket.org/$USERNAME/$REPONAME/get/master.zip -O master.zip
      DIRNAME=$(unzip -qql master.zip | head -n1 | tr -s ' ' | cut -d' ' -f5- | rev | cut -c 2- | rev)
      unzip master.zip
      mv $DIRNAME $REPONAME
      rm -f master.zip
    fi
  fi
}

#!/bin/bash
gitconfig(){
  if [ $# -ne 2 ]; then
    echo "Require [name],[email]"
  else
    git config --local user.name $1
    git config --local user.email $2
    git config --local push.default current
  fi
}
#!/bin/bash
gitinitialize(){
  if [ $# -ne 6 ]; then
    echo "Require [host],[user],[repo],[branch],[name],[email]"
  else
    BASE=$(cd $(dirname $0); pwd)
    cd $BASE
    rm -rf .git
    git init
    git remote add origin git@$1:$2/$3.git
    git fetch origin $4 -f
    git reset --hard origin/$4
    git config --local user.name $5
    git config --local user.email $6
    git config --local push.default current
  fi
}
#!/bin/bash
sshpermission(){
  sudo find ~/.ssh/ -type d -exec sudo chmod 755 {} +
  sudo find ~/.ssh/ -type f -exec sudo chmod 600 {} +
}
#!/bin/bash
wgetbitbucket(){
  if [ $# -ne 3 ]; then
    echo "Require bitbucket [username],[repouser],[reponame]"
  else
    #--password=password
    wget --user=$1 --ask-password https://bitbucket.org/$2/$3/get/master.zip -O master.zip
  fi
}
#!/bin/bash
wgetgithub(){
  if [ $# -ne 2 ]; then
    echo "Require bitbucket [repouser],[reponame]"
  else
    wget --no-check-certificate https://github.com/$1/$2/archive/master.zip -O master.zip
  fi
}
#!/bin/bash
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -cf'
alias watch='watch -d=permanent -n 5'
alias ps="ps --sort=start_time"
alias v="vim"
alias e="emacs -nw"
alias s='git status'
alias d='git diff'
alias sall='git status --untracked-files=all'
ks(){
  echo "Oops!"
}
mike(){
  echo "Nyan!"
}
#!/bin/bash
call(){
  if [ $# -ne 1 ]; then
    echo "Require [function]"
  else
    $1
  fi
}
#!/bin/bash
helloworld(){
  echo "Hello,World!"
}
#!/bin/bash
hr(){
  CHAR=${1:-"-"}
  for i in `seq 1 $(tput cols)`
  do
    printf "${CHAR}";
  done
}
#!/bin/bash
function listdirpath(){
 if [ $# -ne 1 ]; then
    echo "Require [Path]"
  else
    DLIST=();
  for dir in `\find $1 -mindepth 1 -maxdepth 1 -not -name ".*" -type d`; do
      DLIST+=("$dir")
    done
  fi
  for path in ${DLIST[@]}; do
    echo "${path##*/}"
    #echo $path
  done
}
#!/bin/bash
function listfilepath(){
 if [ $# -ne 1 ]; then
    echo "Require [Path]"
  else
    FLIST=();
  for file in `\find $1 -maxdepth 1 -not -name '.*' -type f`; do
      FLIST+=("$file")
    done
  fi
  for path in ${FLIST[@]}; do
    #echo "${path##*/}"
    echo $path
  done
}
#!/bin/bash
function load(){
  if [ $# -ne 1 ]; then
    echo "Require [path]"
  else
    if [ -f $1 ]; then source $1; fi
  fi
}
#!/bin/bash
function pkg(){
  PKG1=("nano" "make" "gcc" "expect")
  PKG2=("curl" "wget" "git" "tree" "jq" "nginx")
  PKG3=("zip" "python" "python-dev" "python3" "python3-dev" "ncurses-dev")
  MERGED=(${PKG1[*]} ${PKG2[*]} ${PKG3[*]})
  echo "${MERGED[@]}"
}
#!/bin/bash
export LC_MESSAGES="en_US.UTF-8"
LINES=$(tput lines)
COLUMNS=$(tput cols)
PRESS_KEY=" echo 'Press any key to continue...'; read -k1 -s"
GIT_USER_NAME=onoie
GIT_USER_EMAIL=onoie3@gmail.com
declare -a LOADED=()
#!/bin/bash
createsshkeyauto(){
expect -c "
set timeout 10
spawn ssh-keygen -t rsa -C \"\"
expect -re \"Enter file in which to save the key\ (.\*\):\"
send \"\n\"
expect \"Enter passphrase \(empty for no passphrase\):\"
send \"\n\"
expect \"Enter same passphrase again:\"
send \"\n\"
expect eof exit 0
"
}
exp-ssh(){
if [ $# -ne 4 ]; then
  echo "require host/port/user/pass"
else
  HOST=$1
  PORT=$2
  USER=$3
  PASS=$4
  expect -c "
#log_file sshexp.log
set timeout -1
spawn ssh -l $USER $HOST -p $PORT
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send \"yes\n\"
    expect \"$USER@$HOST's password:\"
    send \"$PASS\n\"
} \"$USER@$HOST's password:\" {
    send \"$PASS\n\"
} \"Permission denied (publickey,gssapi-keyex,gssapi-with-mic).\" {
    exit
}
interact
"
fi
}
exp-sshi(){
if [ $# -ne 5 ]; then
  echo "require host/port/user/pass/identify"
else
  HOST=$1
  PORT=$2
  USER=$3
  PASS=$4
  IDENTIFY=$5
  expect -c "
#log_file sshexp.log
set timeout -1
spawn ssh -l $USER $HOST -p $PORT -i $IDENTIFY
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send \"yes\n\"
    expect \"$USER@$HOST's password:\"
    send \"$PASS\n\"
} \"$USER@$HOST's password:\" {
    send \"$PASS\n\"
} \"Permission denied (publickey,gssapi-keyex,gssapi-with-mic).\" {
    exit
}
interact
"
fi
}

exp-sudo(){
if [ $# -ne 2 ]; then
  echo "Require [command],[password]"
else
  CMD=$1
  PASS=$2
  expect -c "
    set timeout -1
    spawn sudo $CMD
    expect \"assword\" {
      send \"$PASS\n\"
    }
    interact
  "
fi
}
requireSudo(){
  if [[ "$(id -u)" != "0" ]]; then
    PASS=$(zenity --entry --text="input:")
    CMD=$0
    expect -c "
      set timeout -1
      spawn sudo $CMD
      expect \"assword\" {
        send \"$PASS\n\"
      }
      interact
    "
    exit
  fi
}

#!/bin/bash
fupdate(){
  curl https://axrat.github.io/f/f.sh -o f.sh && chmod +x f.sh
}
fadd(){
  git add .
}
fcommit(){
  MSG=${@:-"fast commit"}
  git commit --allow-empty -m "$MSG"
  git push --set-upstream origin master
}
facommit(){
  fadd
  fcommit
}
fconfig(){
  git config --local user.name ${1:-"onoie"}
  git config --local user.email ${2:-"onoie3@gmail.com"}
}
fcount(){
  git shortlog -s -n
}
fclone(){
  if [ $# -ne 3 ]; then
    echo "Require[domain],[repouser],[reponame]"
  else
    git clone git@$1:$2/$3.git
  fi
}
fmerge(){
  git merge --allow-unrelated-histories origin/master
}
finitshare(){
  git init --bare --shared
}
fremote(){
  if [ $# -ne 3 ]; then
    echo "Require[domain],[repouser],[reponame]"
  else
    git remote add origin git@$1:$2/$3.git
  fi
}
fresethard(){
  git reset --hard origin/master
}
fresetsoft(){
  git reset --soft HEAD^
}
frelease(){
  if [ $# -ne 1 ]; then
    echo "Require [tag]"
  else
    git tag -d $1
    git push origin :$1
    git commit --allow-empty -m "Release $1"
    git tag $1
    git push --set-upstream origin $1
  fi
}
fpush(){
  git push --set-upstream origin master
}
fpull(){
  git pull --tags
  git pull origin master --depth=1
}
ffetch(){
  git fetch origin
}
frsync(){
  if [ $# -ne 5 ]; then
    echo "Require [port],[from_dir],[to_user],[to_host],[to_dir]"
    echo "e.g. frsync 22 /root/target/ ubuntu aws /home/ubuntu/target/"
  else
    rsync -avh  --exclude='ok' --exclude='.*' \
      -e "ssh -p$1" \
      $2 \
      $3@$4://$5 \
      --bwlimit=1024 #1Mb
  fi
}
fssh(){
  if [ $# -ne 4 ]; then
    echo "Require [user],[host],[port],[identify_file]"
  else
    USER=$1
    HOST=$2
    PORT=$3
    IDENTITY_FILE=$4
    ssh $USER@$HOST -p $PORT -i $IDENTITY_FILE
  fi
}
fless(){
  if [ $# -ne 1 ]; then
    echo "Require [filepath]"
  else
    less $1 | grep -v "^\s*$" | grep -v "^\s*#"
  fi
}


#!/bin/bash
fixadd(){
  if [ $# -ne 2 ]; then
    echo "require [FILE],\"[LINE]\"" 1>&2
  else
    FILE=$1
    LINE=$2
    grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
  fi
}
disablealert(){
  touch ~/.inputrc
  fixadd ~/.inputrc "set bell-style none"
  touch ~/.vimrc
	fixadd ~/.vimrc "set visualbell t_vb="
}
#!/bin/bash
gitremoteadd(){
  if [ $# -ne 3 ]; then
    echo "require [host],[repo_user],[repo_name]" 1>&2
  else
    git remote add origin https://$1/$2/$3.git
  fi
}
ssh-github(){
  ssh -T git@github.com
}
ssh-bitbucket(){
  ssh -T git@bitbucket.org
}
gitcommitcount(){
  git log --oneline | wc -l
}
gitrowcount(){
  git ls-files | xargs -n1 git --no-pager blame -w | wc -l
}
githideandseek(){
  echo -n "Are you sure? [y]: "
  read ans
  case $ans in
  '' | y* | Y* )
    git filter-branch -f --index-filter '
    git rm -rf --cached --ignore-unmatch * 
    ' HEAD
    git filter-branch -f --index-filter '
    touch .hidden | git add .hidden 
    ' HEAD
    git reflog expire --expire=now --all
    git gc --aggressive --prune=now
    ;;
  * )
    ;;
  esac
}
gitoverride(){
  git checkout --orphan tmp
  git commit -m "override"
  git checkout -B master
  git branch -d tmp
  git push -f --set-upstream origin master
}
seturl(){
  git remote add     origin $1
  git remote set-url origin $1
}
gitshallow(){
  git clone --depth 1 $1
}
gitunshallow(){
  git fetch --unshallow
}
gitchangecommiter(){
  USERNAME=onoie
  USEREMAIL=onoie3@gmail.com
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='${USERNAME}'; GIT_AUTHOR_EMAIL='${USEREMAIL}'; GIT_COMMITTER_NAME='${USERNAME}'; GIT_COMMITTER_EMAIL='${USEREMAIL}';" HEAD
}
gitrepositorymerge(){
if [ $# -ne 1 ]; then
  echo "require local target repository path" 1>&2
  echo "Ex) [~/repos/repo]" 1>&2
else
  REPO_URL=$1
  SUBDIR=$(basename $REPO_URL)
  git fetch $REPO_URL/.git refs/heads/master:refs/heads/$SUBDIR
  git filter-branch -f --tree-filter '
  [ -d ${SUBDIR} ] || mkdir -p ${SUBDIR};
  find . -mindepth 1 -maxdepth 1 ! -path ./${SUBDIR} | xargs -i{} mv -f {} ${SUBDIR}
  ' $SUBDIR
  git merge --allow-unrelated-histories --no-ff $SUBDIR
fi
}
gitchangecommitmessage(){
  MSG=${@:-"### private commit message ###"}
  git filter-branch --msg-filter "echo '${MSG}';" -f
}
creategithubgrasssvg(){
curl https://github.com/$1 | awk '/<svg.+class="js-calendar-graph-svg"/,/svg>/' | sed -e 's/<svg/<svg xmlns="http:\/\/www.w3.org\/2000\/svg"/' > $1.svg
}
clone(){
  if [ $# -ne 5 ]; then
    echo "Require [RepositoryHost]:[Username]/[RepositoryName].git"
    echo "git local [GitUsername] [GitEmail]"
  else
    git clone git@$1:$2/$3.git
    cd $3
    git config --local user.name "$4"
    git config --local user.email "$5"
  fi
}
getLastCommitMessage(){
  if [ $# -ne 3 ]; then
    echo "require [host],[user],[repository]"
  else
  HOST=$1
  USER=$2
  REPO=$3
  curl https://$HOST/$USER/$REPO \
   | sed -n -e "/<div class=\"commit-tease js-details-container Details\">/,/<\/div>/p" \
   | grep title \
   | awk '{print substr($0, index($0, ">"))}' \
   | awk '{sub("<.*", "");print $0;}' \
   | cut -c 2-
  fi
}
gitrmremotebranch(){
  if [ $# -ne 1 ]; then
    echo "Require [branch]"
  else
    git push --delete origin $1
  fi
}
getGithubPublicRepositoryViaAPI(){
  curl https://api.github.com/users/onoie/repos
}
getGithubPrivateRepositoryViaAPI(){
  ACCESS_TOKEN=$1
  ORG=$2
  curl -u :${ACCESS_TOKEN} https://api.github.com/orgs/$ORG{}/repos
  curl -H 'Authorization: token ${ACCESS_TOKEN}' https://api.github.com/orgs/$ORG/repos
  curl 'https://api.github.com/orgs/${ORG}/repos?access_token=${ACCESS_TOKEN}'
}
gitcreateremotebranch(){
  if [ $# -ne 1 ]; then
    echo "Require [branch]"
  else
    git branch $1
    git checkout $1
    git branch --all
    git push origin master:$1
  fi
}
gitdeleteremotebranch(){
  if [ $# -ne 1 ]; then
    echo "Require [branch]"
  else
    git branch -d $1
	git push --delete origin $1
  fi
}
gitskip(){
  if [ $# -ne 1 ]; then
    echo "Require [filepath]"
  else
    git update-index --skip-worktree $1
  fi
}
gitskiprevert(){
  if [ $# -ne 1 ]; then
    echo "Require [filepath]"
  else
    git update-index --no-skip-worktree $1
  fi
}
gitskipcheck(){
  git ls-files -v | grep ^S
}
gitresethard(){
  git reset --hard origin/master
}
gitsubmoduleadd(){
  if [ $# -ne 3 ]; then
    echo "Require [RepoHost],[RepoUser],[RepoName]"
  else
    git submodule add https://$1/$2/$3.git $3
  fi
}
gitsubmoduleinit(){
  git submodule update --init --recursive
}
gitsubmoduleupdate(){
  git submodule foreach 'git pull origin master --allow-unrelated-histories'
}

#!/bin/bash
herokupush(){
  git push heroku master
}
herokuremoteadd(){
  if [ $# -ne 1 ]; then
    echo "Require [app].herokuapp.com "
  else
    git remote add heroku https://git.heroku.com/$1.git
  fi
}
herokubuildpack(){
  if [ $# -ne 2 ]; then
    echo "Require [app] for buildpack heroku/[lang]"
  else
    heroku buildpacks:set heroku/$2 --app $1
    heroku addons:create heroku-postgresql:hobby-dev --app $1
  fi
}
herokupointdns(){
  if [ $# -ne 1 ]; then
    echo "Require [app].herokuapp.com "
  else
    heroku addons:add pointdns --app $1
  fi
}

#!/bin/bash
alignleft(){ printf "%-${COLUMNS}s\n" $1; }
alignright(){ printf "%${COLUMNS}s\n" $1; }
aligncenter(){ printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$1"; }
aligns(){ printf "$1%*.*s$2\n" 0 $(( $COLUMNS - ${#1} - ${#2} )) "$(hr)"; }
keyval(){ printf "$1%*.*s$2\n" 0 $(( $COLUMNS / 2  - ${#1} )) "$(hr)"; }
chmodparentdir(){
sudo chmod 777 $(cd $(dirname $0); pwd) -f
}
chmodcurrentfile(){
sudo chmod 700 ${0##*/}
}
fx(){ 
  sudo wget $1 && sudo chmod +x ${1##*/} && sudo ./${1##*/}
}
shutdownlater(){
  sudo shutdown -h +300
}
rundir(){
  echo $(cd $(dirname $(readlink $0 || echo $0));pwd)
}
fromdir(){
  echo $(cd $(dirname $BASH_SOURCE); pwd)
}
getenvroiment(){
	printenv
}
download(){
  if [ ! -e ${1##*/} ]; then
    wget $1 --trust-server-names --no-check-certificate -O ./${1##*/}
  fi
}
#chmod 600 .ssh/authorized_keys
createsshkey(){
ssh-keygen -t rsa -b 4096 -C ""
}
nginxandphpfpm(){
  d_start(){
    sudo /etc/init.d/nginx   start
    sudo /etc/init.d/php-fpm start
    #sudo /etc/init.d/fcgiwrap start
  }
  d_stop(){
    sudo /etc/init.d/nginx stop
    sudo /etc/init.d/php-fpm stop
    #sudo /etc/init.d/fcgiwrap stop
  }
  case "$1" in
    start)
      d_start
      xdg-open http://localhost/
    ;;
    restart)
      d_stop
      sleep 2
      d_start
    ;;
    stop)
      d_stop
    ;;
    kill)
      sudo killall -KILL nginx
      sudo killall -KILL php-fpm
      #sudo killall -KILL fcgiwrap
    ;;
  esac
}
browse(){
  (sleep 2s; xdg-open $1) &
}
chmod-r(){
  if [ $# -ne 3 ]; then
    echo "Require [f/d],[Permission],[path] "
  else
    sudo find $3 -type $1 -exec sudo chmod $2 {} +
  fi
}
devcopy(){
sudo df
echo "Ex) dd if=/dev/sr0 of=/root/dev.iso"
echo "if path:"
read DDIF
echo "of path:"
read DDOF
sudo dd if=$DDIF of=$DDOF
}
launch-maya(){
	sudo /usr/autodesk/maya2016/bin/maya
}
launch-unity(){
	LD_PRELOAD=/lib/x86_64-linux-gnu/libresolv.so.2 /opt/Unity/Editor/Unity
}
getZipRootDirectoryName(){
  unzip -qql $1 | head -n1 | tr -s ' ' | cut -d' ' -f5- | rev | cut -c 2- | rev
}
togif(){
  if [ $# -ne 1 ]; then
    echo "Require [Filename]"
  else
    ffmpeg -i "$1" -an -r 24 "$(pwd)/${$(basename $1)%.*}.gif"
  fi
}
base64(){
  #usage cat image.gif | base64 > img.css
  w=''
  case "${1:-}" in
    --wrap=*) printf '%s\n' "$1" | grep -q '^--wrap=[0-9]\{1,\}$' && {
                w=${1#--wrap=}
              }
              ;;
  esac
  case "$w" in '') w=76;; esac
  od -A n -t x1 -v                                                         |
  awk 'BEGIN{OFS=""; ORS="";                                               #
             x2o["0"]="0000"; x2o["1"]="0001"; x2o["2"]="0010";            #
             x2o["3"]="0011"; x2o["4"]="0100"; x2o["5"]="0101";            #
             x2o["6"]="0110"; x2o["7"]="0111"; x2o["8"]="1000";            #
             x2o["9"]="1001"; x2o["a"]="1010"; x2o["b"]="1011";            #
             x2o["c"]="1100"; x2o["d"]="1101"; x2o["e"]="1110";            #
             x2o["f"]="1111";                                              #
             x2o["A"]="1010"; x2o["B"]="1011"; x2o["C"]="1100";            #
             x2o["D"]="1101"; x2o["E"]="1110"; x2o["F"]="1111";         }  #
       {     l=length($0);                                                 #
             for(i=1;i<=l;i++){print x2o[substr($0,i,1)];}                 #
             printf("\n");                                              }' |
  awk 'BEGIN{s="";                                                      }  #
       {     buf=buf $0;                                                   #
             l=length(buf);                                                #
             if(l<6){next;}                                                #
             u=int(l/6)*6;                                                 #
             for(p=1;p<u;p+=6){print substr(buf,p,6);}                     #
             buf=substr(buf,p);                                         }  #
       END  {if(length(buf)>0){print substr(buf "00000",1,6);}          }' |
  awk 'BEGIN{ORS=""; w='$w';                                               #
             o2b6["000000"]="A"; o2b6["000001"]="B"; o2b6["000010"]="C";   #
             o2b6["000011"]="D"; o2b6["000100"]="E"; o2b6["000101"]="F";   #
             o2b6["000110"]="G"; o2b6["000111"]="H"; o2b6["001000"]="I";   #
             o2b6["001001"]="J"; o2b6["001010"]="K"; o2b6["001011"]="L";   #
             o2b6["001100"]="M"; o2b6["001101"]="N"; o2b6["001110"]="O";   #
             o2b6["001111"]="P"; o2b6["010000"]="Q"; o2b6["010001"]="R";   #
             o2b6["010010"]="S"; o2b6["010011"]="T"; o2b6["010100"]="U";   #
             o2b6["010101"]="V"; o2b6["010110"]="W"; o2b6["010111"]="X";   #
             o2b6["011000"]="Y"; o2b6["011001"]="Z"; o2b6["011010"]="a";   #
             o2b6["011011"]="b"; o2b6["011100"]="c"; o2b6["011101"]="d";   #
             o2b6["011110"]="e"; o2b6["011111"]="f"; o2b6["100000"]="g";   #
             o2b6["100001"]="h"; o2b6["100010"]="i"; o2b6["100011"]="j";   #
             o2b6["100100"]="k"; o2b6["100101"]="l"; o2b6["100110"]="m";   #
             o2b6["100111"]="n"; o2b6["101000"]="o"; o2b6["101001"]="p";   #
             o2b6["101010"]="q"; o2b6["101011"]="r"; o2b6["101100"]="s";   #
             o2b6["101101"]="t"; o2b6["101110"]="u"; o2b6["101111"]="v";   #
             o2b6["110000"]="w"; o2b6["110001"]="x"; o2b6["110010"]="y";   #
             o2b6["110011"]="z"; o2b6["110100"]="0"; o2b6["110101"]="1";   #
             o2b6["110110"]="2"; o2b6["110111"]="3"; o2b6["111000"]="4";   #
             o2b6["111001"]="5"; o2b6["111010"]="6"; o2b6["111011"]="7";   #
             o2b6["111100"]="8"; o2b6["111101"]="9"; o2b6["111110"]="+";   #
             o2b6["111111"]="/";                                           #
             if (getline) {print o2b6[$0];n=1;}                         }  #
       n==w {printf("\n")  ; n=0;                                       }  #
       {     print o2b6[$0]; n++;                                       }  #
       END  {if(NR>0){printf("%s\n",substr("===",1,(4-(NR%4))%4));}     }'
}
portcheck(){
  if [ $# -ne 1 ]; then
    echo "Require [PortNumber]"
  else
    sudo netstat -apnt4 | grep $1	
  fi
}
compress(){
  tar cfvz $1.tar.gz $1/
}
extract(){
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.tar.xz)  xz -dc $1 | tar xfv - ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
	  *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
	  *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)
        echo "Unable to extract '$1'"
      ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
declare -a jetbrains=("IdeaProjects" "PhpstormProjects" "CLionProjects" "PycharmProjects" "RubymineProjects" "WebstormProjects" )
createJetBrainsDirectory(){
  for ((i = 0; i < ${#jetbrains[@]}; i++)) {
    echo "mkdir -p ${jetbrains[i]}"
  }
}
getDirSize(){
  if [ $# -ne 1 ]; then
    echo "Require [DirectoryName]"
  else
    du -sh $1
  fi
}
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o
  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}
gtk-input(){
  VAR=$(zenity --entry --text="input:")
  echo $VAR
}
cmakeclean(){
  rm CMakeCache.txt
  rm cmake_install.cmake
  rm -r CMakeFiles
  rm Makefile
}
cmakeuninstall(){
  xargs rm < install_manifest.txt
}
sudopostgres(){
sudo -i -u postgres
}
crossorigincheck(){
  if [ $# -ne 1 ]; then
    echo "Require [http://example.com]"
  else
    curl -H "Origin: ${1}" \
      -H "Access-Control-Request-Method: POST" \
      -H "Access-Control-Request-Headers: X-Requested-With" \
      -X OPTIONS \
      --verbose https://www.googleapis.com/discovery/v1/apis?fields=
  fi
}

checkdirectorysize(){
  if [ $# -ne 1 ]; then
    echo "Require [DirectoryPath]"
  else
    du -sh $1
  fi
}
phpconfigurecheck(){
php -i  | grep './configure'
}
updatelocaletime(){
sudo cp /etc/localtime /etc/localtime.org
sudo ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
}
rmcomment(){
grep -v -e '^\s*#' -e '^\s*$' $1
}
bkup(){
if [[ -d "${1}" && ! -L "${1}" ]] ; then
  rm -rf $1.org
  cp -rf $1 $1.org
fi
}
checkglobalip(){
curl inet-ip.info
}
checkproxy(){
HOST=${1:-localhost}
curl inet-ip.info -x $HOST:3128
}
sudoeof(){
sudo bash -c "cat << 'EOF' > $1
$2
EOF"
}
simpleHTTPServer(){
python -u -m SimpleHTTPServer 8000
}
isRoot(){
  test "$(id -u)" == "0";
}
vncstart(){
export USER=root
VNC_RESOLUTION="800x600"#"1360x768"
vncserver :1 -geometry $VNC_RESOLUTION -depth 24
}
vncstop(){
export USER=root
vncserver -kill :1
}
kokoroiopost(){
  MESSAGE=$1
  KOKOROIO_CHANNEL=$KOKOROIO_CHANNEL_DEV
  curl -X POST \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --header "Accept: application/json" \
    --header "X-Access-Token: $KOKOROIO_ACCESS_TOKEN" \
    -d "message=$MESSAGE" \
    "https://kokoro.io/api/v1/channels/$KOKOROIO_CHANNEL/messages"
}
gorun(){
  MAIN=${1:-main.go}
  go run $MAIN
}
filesearch(){
  if [ $# -ne 1 ]; then
    echo "Require [FileName]"
  else
    find / -name $1 -ls
  fi
}
dnscheck(){
  if [ $# -ne 1 ]; then
    echo "Require [domain]"
  else
    dig + noall + answer $1
  fi
}
rmknown_hosts(){
  rm ~/.ssh/known_hosts
}
cmdconfirm(){
  echo "run [$1] ? [y]"
  read ans
  case $ans in
    '' | y* | Y* )
      echo "Yes" && eval "${1}"
      ;;
    * )
      echo "No" && exit
    ;;
  esac
}
requirecmd(){
  CMD=$1
  if type "$CMD" > /dev/null 2>&1 ; then
    echo "found command:$CMD"
  else
    echo "not found command:$CMD"
    exit
  fi
}
requirepkg(){
  requirecmd "dpkg-query"
  PKG=$1
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $PKG|grep "install ok installed") 
  if [ "" != "$PKG_OK" ]; then
    echo "found package:$PKG"
  else
    echo "not found package:$PKG"
    cmdconfirm "sudo apt-get install -y $PKG"
  fi
}
requiresudo(){
  if [[ "$(id -u)" != "0" ]]; then
    PASS=$(zenity --entry --text="input:")
    CMD=$0
    expect -c "
      set timeout -1
      spawn sudo $CMD
      expect \"assword\" {
        send \"$PASS\n\"
      }
      interact
    "
    exit
  fi
}
tmuxexit(){
  tmux kill-server
}
winry(){
  vim +":source ~/.vim/dein/repos/github.com/axrat/winry.vim/plugin/winry.vim " +:q
}
purge(){
  readonly DRYRUN=false
  #BASE=$(cd $(dirname $0); pwd)
  BASE=$(pwd)
  HEADER="####################################################################################################"
  A="a.txt"
  A_NO_MAX=$([ `wc -c < $A` -eq 0 ] && echo 0 || ([ `tail -c 1 $A | wc -l` -eq 1 ] && wc -l < $A || expr `wc -l < $A` + 1))
  TEST_DIR="$BASE/_a"
  if [ ! -f "$A" ]; then
    echo "not found $A"
  else
    echo $HEADER
    mkdir -p $TEST_DIR
    ##
    AR=($(grep -e ^"$HEADER"$ -n $A | sed -e 's/:.*//g'))
    for i in "${!AR[@]}"; do
      #printf '${AR[%s]}=%s\n' "$i" "${AR[i]}"
      _NEXT=`expr $i \+ 1`
      _START=`expr ${AR[$i]} \+ 2`
      _NAME=$(head -n `expr ${AR[$i]} \+ 1` $A | tail -n 1)
      if [ `expr ${#AR[@]} \- 1` -eq $i ];then
       #echo "last"
        _END=$A_NO_MAX
      else
        _END=`expr ${AR[$_NEXT]} \- 1`
      fi
      ##empty
      if [ $_START -gt $_END ];then
        _END=$_START
      fi
      echo "$_NAME#L$_START-L$_END"
      _OUT="$TEST_DIR/$_NAME"
      _CMD="sed -n ${_START},${_END}p $A >> $_OUT"
      echo " => $_CMD"
      if ! "${DRYRUN}"; then
        :> $_OUT
        eval "${_CMD}"
      fi
    done
    ##
    #rm -rf $TEST_DIR
    echo $HEADER
    echo "diff -rs --speed-large-files $TEST_DIR [DIR]"
  fi
}
forParentDir(){
  sudo chmod 777 ../`pwd | awk -F "/" '{ print $NF }'`
}
forSudo(){
chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo
chmod u+s "$(command -v su)" "$(command -v sudo)"
}
forNodejs(){
sudo chown -R $(whoami) $(npm config get prefix)/lib/node_modules
#rm -rf node_modules/ && npm cache clean && npm install
#sudo chmod 770 $NVM_DIR -R
}
forDocker(){
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker
echo "plz relogin"
}
directory_size(){
  du --separate-dirs -h --total $(pwd)/*/
}
#!/bin/bash
LOADED+=('f')
f(){
  hr
  echo VERSION:2021-05-11 19:19:43.124315700
  hr
}
#!/bin/bash
function arch1(){
if [[ -d "/sys/firmware/efi/efivars" ]] ; then
  echo "EFI MODE"
fi
loadkeys jp106
}
#!/bin/bash
function arch2(){
wifi-menu
ping google.com -c2
echo "complete"
}
#!/bin/bash
function arch3(){
cat > /etc/resolv.conf << EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
echo "complete"
}
#!/bin/bash
function arch4(){
dd if=/dev/zero of=/dev/sda bs=512 count=1
sgdisk -Z /dev/sda
echo "complete"
}
#!/bin/bash
function arch5(){
parted -s -a optimal /dev/sda -- mklabel msdos
#/dev/sda1 boot(1GiB)
parted -s -a optimal /dev/sda -- set 1 boot on
parted -s -a optimal /dev/sda -- mkpart primary ext4 1 1GiB
#/dev/sda2 swap(15GiB)
parted -s -a optimal /dev/sda -- mkpart primary linux-swap 1GiB 16GiB
#/dev/sda3 root(32GiB)
parted -s -a optimal /dev/sda -- mkpart primary ext4 16GiB 48GiB
#/dev/sda4 home
parted -s -a optimal /dev/sda -- mkpart primary ext4 48GiB 100%
#parted -l -m
fdisk -l
#parted -s -a optimal /dev/sda -- mklabel mkpard primary ext4 1 -1 set 1 lvm on
echo "complete"
}
#!/bin/bash
function arch6(){
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
echo "complete"
}
#!/bin/bash
function arch7(){
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home
echo "complete"
}
#!/bin/bash
function arch8(){
cat > /etc/pacman.d/mirrorlist << 'EOF'
Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch
Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch
Server = http://ftp.sh.cvut.cz/arch/$repo/os/$arch
Server = http://arch.yourlabs.org/$repo/os/$arch
Server = http://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
Server = http://mirror.internode.on.net/pub/archlinux/$repo/os/$arch
Server = http://mirror.host.ag/archlinux/$repo/os/$arch
Server = http://mirrors.nix.org.ua/linux/archlinux/$repo/os/$arch
Server = http://mirror.nl.leaseweb.net/archlinux/$repo/os/$arch
Server = http://arch.softver.org.mk/archlinux/$repo/os/$arch
Server = http://mirrors.aggregate.org/archlinux/$repo/os/$arch
Server = http://ftp.lysator.liu.se/pub/archlinux/$repo/os/$arch
Server = http://mirror.cc.columbia.edu/pub/linux/archlinux/$repo/os/$arch
Server = http://mirrors.cat.pdx.edu/archlinux/$repo/os/$arch
Server = http://mirrors.nic.cz/archlinux/$repo/os/$arch
Server = http://mirror.poliwangi.ac.id/archlinux/$repo/os/$arch
Server = http://ftp.energia.mta.hu/pub/mirrors/ftp.archlinux.org/$repo/os/$arch
Server = http://mirrors.lug.mtu.edu/archlinux/$repo/os/$arch
Server = http://mirror.nexcess.net/archlinux/$repo/os/$arch
Server = http://ftp.klid.dk/ftp/archlinux/$repo/os/$arch
Server = http://mirror.netcologne.de/archlinux/$repo/os/$arch
Server = http://archlinux.vi-di.fr/$repo/os/$arch
Server = http://osl.ugr.es/archlinux/$repo/os/$arch
Server = http://mirror.0x.sg/archlinux/$repo/os/$arch
Server = http://mirror.lnx.sk/pub/linux/archlinux/$repo/os/$arch
Server = http://ftp.vectranet.pl/archlinux/$repo/os/$arch
Server = http://ftp.nluug.nl/os/Linux/distr/archlinux/$repo/os/$arch
Server = http://mirrors.rutgers.edu/archlinux/$repo/os/$arch
Server = http://mirrors.niyawe.de/archlinux/$repo/os/$arch
Server = http://mirror.umd.edu/archlinux/$repo/os/$arch
Server = http://ftp.gwdg.de/pub/linux/archlinux/$repo/os/$arch
Server = http://glua.ua.pt/pub/archlinux/$repo/os/$arch
Server = http://mirror.cedia.org.ec/archlinux/$repo/os/$arch
Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.uni-plovdiv.net/archlinux/$repo/os/$arch
Server = http://ftp.ntua.gr/pub/linux/archlinux/$repo/os/$arch
Server = http://archlinux.thelinuxnetworx.rocks/$repo/os/$arch
Server = http://repo.sadjad.ac.ir/arch/$repo/os/$arch
Server = http://archlinux.mirror.digitalpacific.com.au/$repo/os/$arch
Server = http://archlinux.surlyjake.com/archlinux/$repo/os/$arch
Server = http://arch.apt-get.eu/$repo/os/$arch
Server = http://ftp.uni-hannover.de/archlinux/$repo/os/$arch
Server = http://archlinux.thaller.ws/$repo/os/$arch
Server = http://ftp.u-strasbg.fr/linux/distributions/archlinux/$repo/os/$arch
Server = http://mirrors.netix.net/archlinux/$repo/os/$arch
Server = http://mirror.f4st.host/archlinux/$repo/os/$arch
Server = http://mirror.fluxent.de/archlinux/$repo/os/$arch
Server = http://mirror.its.dal.ca/archlinux/$repo/os/$arch
Server = http://mirrors.zju.edu.cn/archlinux/$repo/os/$arch
Server = http://mirror.united-gameserver.de/archlinux/$repo/os/$arch
Server = http://mirror.onet.pl/pub/mirrors/archlinux/$repo/os/$arch
Server = http://mirror.hactar.xyz/$repo/os/$arch
Server = http://mirror.csclub.uwaterloo.ca/archlinux/$repo/os/$arch
Server = http://archlinux.cu.be/$repo/os/$arch
Server = http://mirror.bytemark.co.uk/archlinux/$repo/os/$arch
Server = http://archlinux.melbourneitmirror.net/$repo/os/$arch
Server = http://mirror.tyborek.pl/arch/$repo/os/$arch
Server = http://mir.archlinux.fr/$repo/os/$arch
Server = http://mirror.gerhard.re/archlinux/$repo/os/$arch
Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch
Server = http://mirror.easyname.at/archlinux/$repo/os/$arch
Server = http://arch.mirror.constant.com/$repo/os/$arch
Server = http://arch.jensgutermuth.de/$repo/os/$arch
Server = http://ftp.acc.umu.se/mirror/archlinux/$repo/os/$arch
Server = http://k42.ch/mirror/archlinux/$repo/os/$arch
Server = http://mirror.ubrco.de/archlinux/$repo/os/$arch
Server = http://repo.iut.ac.ir/repo/archlinux/$repo/os/$arch
Server = http://mirror.archlinux.no/$repo/os/$arch
Server = http://mirror.grig.io/archlinux/$repo/os/$arch
Server = http://mirror.premi.st/archlinux/$repo/os/$arch
Server = http://archlinux.mirror.rafal.ca/$repo/os/$arch
Server = http://www.gtlib.gatech.edu/pub/archlinux/$repo/os/$arch
Server = http://mirrors.ocf.berkeley.edu/archlinux/$repo/os/$arch
Server = http://ftp.heanet.ie/mirrors/ftp.archlinux.org/$repo/os/$arch
Server = http://mirror.devilzc0de.org/archlinux/$repo/os/$arch
Server = http://archlinux.uib.no/$repo/os/$arch
Server = http://ftp.osuosl.org/pub/archlinux/$repo/os/$arch
Server = http://ftp.rnl.tecnico.ulisboa.pt/pub/archlinux/$repo/os/$arch
Server = http://mirror.js-webcoding.de/pub/archlinux/$repo/os/$arch
Server = http://archlinux.prometeolibero.eu/archlinux/$repo/os/$arch
Server = http://ftp.wa.co.za/pub/archlinux/$repo/os/$arch
Server = http://mirror.metalgamer.eu/archlinux/$repo/os/$arch
Server = http://ftp.tu-chemnitz.de/pub/linux/archlinux/$repo/os/$arch
Server = http://mirror.system.is/arch/$repo/os/$arch
Server = http://mirror1.hackingand.coffee/arch/$repo/os/$arch
Server = http://ca.us.mirror.archlinux-br.org/$repo/os/$arch
Server = http://mirror.archlinux.ro/archlinux/$repo/os/$arch
Server = http://arch.localmsp.org/arch/$repo/os/$arch
Server = http://repo.itmettke.de/archlinux/$repo/os/$arch
Server = http://mirror.t-home.mk/archlinux/$repo/os/$arch
Server = http://ftp.linux.org.tr/archlinux/$repo/os/$arch
Server = http://ftp.halifax.rwth-aachen.de/archlinux/$repo/os/$arch
Server = http://mirror.cs.vt.edu/pub/ArchLinux/$repo/os/$arch
Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.myaegean.gr/linux/archlinux/$repo/os/$arch
Server = http://mirror.htnshost.com/archlinux/$repo/os/$arch
Server = http://mirror.one.com/archlinux/$repo/os/$arch
Server = http://ftp.fau.de/archlinux/$repo/os/$arch
Server = http://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch
Server = http://mirror.rackspace.com/archlinux/$repo/os/$arch
Server = http://mirrors.gigenet.com/archlinux/$repo/os/$arch
Server = http://archmirror.hbit.sztaki.hu/archlinux/$repo/os/$arch
Server = http://foss.aueb.gr/mirrors/linux/archlinux/$repo/os/$arch
Server = http://ftp.cc.uoc.gr/mirrors/linux/archlinux/$repo/os/$arch
Server = http://arch.midov.pl/arch/$repo/os/$arch
Server = http://mirror2.hackingand.coffee/arch/$repo/os/$arch
Server = http://mirror.lagoon.nc/pub/archlinux/$repo/os/$arch
Server = http://mirror.digitalnova.at/archlinux/$repo/os/$arch
Server = http://mirror.vtti.vt.edu/archlinux/$repo/os/$arch
Server = http://artfiles.org/archlinux.org/$repo/os/$arch
Server = http://archlinux.mirrors.linux.ro/$repo/os/$arch
Server = http://archlinux.koyanet.lv/archlinux/$repo/os/$arch
Server = http://mirrors.m247.ro/archlinux/$repo/os/$arch
Server = http://ftp.swin.edu.au/archlinux/$repo/os/$arch
Server = http://muug.ca/mirror/archlinux/$repo/os/$arch
Server = http://archlinux.pop-es.rnp.br/$repo/os/$arch
Server = http://mirror.cse.iitk.ac.in/archlinux/$repo/os/$arch
Server = http://archlinux.iskon.hr/$repo/os/$arch
Server = http://mirrors.evowise.com/archlinux/$repo/os/$arch
Server = http://br.mirror.archlinux-br.org/$repo/os/$arch
Server = http://mirrors.163.com/archlinux/$repo/os/$arch
Server = http://ftp.lanet.kr/pub/archlinux/$repo/os/$arch
Server = http://mirrors.liquidweb.com/archlinux/$repo/os/$arch
Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch
Server = http://mirror.selfnet.de/archlinux/$repo/os/$arch
Server = http://mirror.archlinux.cl/$repo/os/$arch
Server = http://mirrors.standaloneinstaller.com/archlinux/$repo/os/$arch
Server = http://mirrors.pidginhost.com/arch/$repo/os/$arch
Server = http://mirror.metrocast.net/archlinux/$repo/os/$arch
Server = http://archlinux.nullpointer.io/$repo/os/$arch
Server = http://mirror.cs.pitt.edu/archlinux/$repo/os/$arch
Server = http://mirror.lty.me/archlinux/$repo/os/$arch
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = http://ftp-stud.hs-esslingen.de/pub/Mirrors/archlinux/$repo/os/$arch
Server = http://mirror.cedille.club/archlinux/$repo/os/$arch
Server = http://mirrors.n-ix.net/archlinux/$repo/os/$arch
Server = http://mirror.wbs.co.za/archlinux/$repo/os/$arch
Server = http://ftp.myrveln.se/pub/linux/archlinux/$repo/os/$arch
Server = http://mi.mirror.garr.it/mirrors/archlinux/$repo/os/$arch
Server = http://ftp.byfly.by/pub/archlinux/$repo/os/$arch
Server = http://arch-mirror.wtako.net/$repo/os/$arch
Server = http://ftp.otenet.gr/linux/archlinux/$repo/os/$arch
Server = http://mirror.gnomus.de/$repo/os/$arch
Server = http://arch.serverspace.co.uk/arch/$repo/os/$arch
Server = http://archlinux.mirror.root.lu/$repo/os/$arch
Server = http://arch.mirror.far.fi/$repo/os/$arch
Server = http://mirror3.hackingand.coffee/arch/$repo/os/$arch
Server = http://mirrors.manchester.m247.com/arch-linux/$repo/os/$arch
Server = http://archlinux.de-labrusse.fr/$repo/os/$arch
Server = http://mirror.yellowfiber.net/archlinux/$repo/os/$arch
Server = http://mirror.es.its.nyu.edu/archlinux/$repo/os/$arch
Server = http://ftp.iinet.net.au/pub/archlinux/$repo/os/$arch
Server = http://mirror.netrouting.net/archlinux/$repo/os/$arch
Server = http://ftp.uni-bayreuth.de/linux/archlinux/$repo/os/$arch
Server = http://mirror.datacenter.by/pub/archlinux/$repo/os/$arch
Server = http://mirror.pseudoform.org/$repo/os/$arch
Server = http://ftp.iitm.ac.in/archlinux/$repo/os/$arch
Server = http://mirror.pmf.kg.ac.rs/archlinux/$repo/os/$arch
Server = http://mirror.lastmikoi.net/archlinux/$repo/os/$arch
Server = http://download.nus.edu.sg/mirror/arch/$repo/os/$arch
Server = http://ftp.spline.inf.fu-berlin.de/mirrors/archlinux/$repo/os/$arch
Server = http://ftp.hosteurope.de/mirror/ftp.archlinux.org/$repo/os/$arch
Server = http://archlinux.ip-connect.vn.ua/$repo/os/$arch
Server = http://mirror.vpsfree.cz/archlinux/$repo/os/$arch
Server = http://mirror.yandex.ru/archlinux/$repo/os/$arch
Server = http://mirror.espoch.edu.ec/archlinux/$repo/os/$arch
Server = http://mirror.aur.rocks/$repo/os/$arch
Server = http://arch.mirrors.pair.com/$repo/os/$arch
Server = http://mirror.kaminski.io/archlinux/$repo/os/$arch
Server = http://arlm.tyzoid.com/$repo/os/$arch
Server = http://mirrors.atviras.lt/archlinux/$repo/os/$arch
Server = http://sunsite.rediris.es/mirror/archlinux/$repo/os/$arch
Server = http://archlinux.polymorf.fr/$repo/os/$arch
Server = http://mirror.archlinux.ikoula.com/archlinux/$repo/os/$arch
Server = http://mirror.23media.de/archlinux/$repo/os/$arch
Server = http://www.gutscheindrache.com/mirror/archlinux/$repo/os/$arch
Server = http://archimonde.ts.si/archlinux/$repo/os/$arch
Server = http://mirror.upb.edu.co/archlinux/$repo/os/$arch
Server = http://mirror.rol.ru/archlinux/$repo/os/$arch
Server = http://ftp.yzu.edu.tw/Linux/archlinux/$repo/os/$arch
Server = http://archlinux.puzzle.ch/$repo/os/$arch
Server = http://archlinux.mirrors.ovh.net/archlinux/$repo/os/$arch
Server = http://archlinux.nautile.nc/archlinux/$repo/os/$arch
Server = http://mirror.isoc.org.il/pub/archlinux/$repo/os/$arch
Server = http://pet.inf.ufsc.br/mirrors/archlinux/$repo/os/$arch
Server = http://ftp.fi.muni.cz/pub/linux/arch/$repo/os/$arch
Server = http://archlinux.mirrors.uk2.net/$repo/os/$arch
Server = http://mirrors.rit.edu/archlinux/$repo/os/$arch
Server = http://fooo.biz/archlinux/$repo/os/$arch
Server = http://archlinux.mirror.colo-serv.net/$repo/os/$arch
Server = http://linux.rz.rub.de/archlinux/$repo/os/$arch
Server = http://mirror.frgl.pw/archlinux/$repo/os/$arch
Server = http://mirror.chmuri.net/archmirror/$repo/os/$arch
Server = http://archlinux.mirror.pkern.at/$repo/os/$arch
Server = http://mirror.armbrust.me/archlinux/$repo/os/$arch
Server = http://archlinux.dynamict.se/$repo/os/$arch
Server = http://mirror1.htu.tugraz.at/archlinux/$repo/os/$arch
Server = http://mirrors.acm.wpi.edu/archlinux/$repo/os/$arch
Server = http://mirror.rise.ph/archlinux/$repo/os/$arch
Server = http://mirror.kku.ac.th/archlinux/$repo/os/$arch
Server = http://ftp.uni-kl.de/pub/linux/archlinux/$repo/os/$arch
Server = http://mirrors.advancedhosters.com/archlinux/$repo/os/$arch
Server = http://mirror.as65535.net/archlinux/$repo/os/$arch
Server = http://cosmos.cites.illinois.edu/pub/archlinux/$repo/os/$arch
Server = http://mirror.vfn-nrw.de/archlinux/$repo/os/$arch
Server = http://ftp.linux.cz/pub/linux/arch/$repo/os/$arch
Server = http://il.us.mirror.archlinux-br.org/$repo/os/$arch
Server = http://archlinux.mirror.wearetriple.com/$repo/os/$arch
Server = http://mirror.lzu.edu.cn/archlinux/$repo/os/$arch
Server = http://mirror.nus.edu.sg/archlinux/$repo/os/$arch
Server = http://archlinux.honkgong.info/$repo/os/$arch
Server = http://mirrors.prometeus.net/archlinux/$repo/os/$arch
Server = http://archlinux.mirrors.benatherton.com/$repo/os/$arch
Server = http://mirrors.xmission.com/archlinux/$repo/os/$arch
Server = http://za.mirror.archlinux-br.org/$repo/os/$arch
Server = http://archlinux.mirror.ba/$repo/os/$arch
Server = http://archlinux.students.cs.unibo.it/$repo/os/$arch
Server = http://mirror.neolabs.kz/archlinux/$repo/os/$arch
Server = http://burek.archlinux.ba/$repo/os/$arch
Server = http://mirror.edatel.net.co/archlinux/$repo/os/$arch
Server = http://il.mirrors.linaxe.net/archlinux/$repo/os/$arch
Server = http://arch.tamcore.eu/$repo/os/$arch
Server = http://mirrors.dotsrc.org/archlinux/$repo/os/$arch
Server = http://mirror.michael-eckert.net/archlinux/$repo/os/$arch
Server = http://archlinux.mirror.kangaroot.net/$repo/os/$arch
Server = http://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch
Server = http://ftp.kaist.ac.kr/ArchLinux/$repo/os/$arch
Server = http://suro.ubaya.ac.id/archlinux/$repo/os/$arch
Server = http://archmirror.tomforb.es/$repo/os/$arch
Server = http://mirror.dkm.cz/archlinux/$repo/os/$arch
Server = http://pkg.adfinis-sygroup.ch/archlinux/$repo/os/$arch
Server = http://mirror.qnren.qa/archlinux/$repo/os/$arch
Server = http://f.archlinuxvn.org/archlinux/$repo/os/$arch
Server = http://mirror.neuf.no/archlinux/$repo/os/$arch
Server = http://gluttony.sin.cvut.cz/arch/$repo/os/$arch
Server = http://ftp.snt.utwente.nl/pub/os/linux/archlinux/$repo/os/$arch
Server = http://mirror.math.princeton.edu/pub/archlinux/$repo/os/$arch
Server = http://mirror.loli.forsale/arch/$repo/os/$arch
Server = http://ftp.portlane.com/pub/os/linux/archlinux/$repo/os/$arch
Server = http://mirror.epiphyte.network/archlinux/$repo/os/$arch
Server = http://mirror.i3d.net/pub/archlinux/$repo/os/$arch
Server = http://mirror.us.leaseweb.net/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
Server = http://mirror.jmu.edu/pub/archlinux/$repo/os/$arch
Server = http://mirror.is.co.za/mirror/archlinux.org/$repo/os/$arch
Server = http://tux.rainside.sk/archlinux/$repo/os/$arch
Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch
Server = http://mirror.adminbannok.com/archlinux/$repo/os/$arch
Server = http://archlinux.mailtunnel.eu/$repo/os/$arch
Server = http://www.mirrorservice.org/sites/ftp.archlinux.org/$repo/os/$arch
Server = http://mirror.de.leaseweb.net/archlinux/$repo/os/$arch
Server = http://mirror.uta.edu.ec/archlinux/$repo/os/$arch
EOF
pacstrap /mnt base base-devel
pacstrap /mnt sh bash bash-completion zsh
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
echo "complete"
}
#!/bin/bash
function arch9(){
loadkeys jp106
pwd
pacman -Syu
pacman -S openssl netctl wireless_tools wpa_supplicant iw wpa_actiond dialog
pacman -S grub
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "complete"
}
#!/bin/bash
installapache2phpubuntu(){
  sudo apt install -y apache2
  sudo a2enmod userdir
  sudo a2enmod include
  sudo a2enmod cgid
  sudo systemctl restart apache2
  sudo apt install -y php
  sudo apt install -y libapache2-mod-php
  sudo mkdir -p /var/www/html
  sudo bash -c "cat << 'EOF' > /var/www/html/info.php
<?php phpinfo();
EOF"
  sudo mkdir -p ~/public_html
  sudo chmod 777 ~/public_html/
  sudo bash -c "cat << 'EOF' > ~/public_html/index.html
HelloWorld
EOF"
}
#!/bin/bash
installdein(){
  if [ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ]; then 
    echo "found dein directory"
  else 
    DOWNLOAD=installer.sh 
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $DOWNLOAD 
    chmod +x $DOWNLOAD 
    sh ./$DOWNLOAD ~/.vim/dein 
    rm $DOWNLOAD 
  fi
}
#!/bin/bash
installnanorc(){
  if [ -d ~/.nano ]; then
    echo found ~/.nano
  else
    DOWNLOAD=nanorc.zip
    if [ -e $DOWNLOAD ]; then
      echo "found $DOWNLOAD"
    else
      echo "not found $DOWNLOAD"
      wget --no-check-certificate https://github.com/nanorc/nanorc/archive/master.zip -O $DOWNLOAD
      unzip $DONWLOAD
      cd nanorc-master
      make install
      cd ..
      rm -rf nanorc-master
      rm -f $DOWNLOAD
  fi
fi
}
#!/usr/bin/env bash

installopenrestysource(){

#require check package
declare -a PKGS=("libpcre3-dev" "libssl-dev" "perl" "make" "build-essential" "curl")
for ((i = 0; i < ${#PKGS[@]}; i++)) {
  requirepkg ${PKGS[i]}
}

DIRECTORY="openresty-1.13.6.1"
DOWNLOAD="$DIRECTORY.tar.gz"
TO="/usr/local/src"

sudo mkdir -p $TO
##already exist check
if [[ ! -d $TO/$DIRECTORY ]] ; then
  ##check donwload archive
  if [ ! -f "$DOWNLOAD" ] ; then
    wget "https://openresty.org/download/$DOWNLOAD"
  else
    echo "found download:$DOWNLOAD"
  fi
  ##check extract directory
  if [[ ! -d $DIRECTORY ]] ; then
    tar -xvf $DOWNLOAD
  else
    echo "found directory:$DIRECTORY"
  fi
  ##move source directory
  sudo mv $DIRECTORY "$TO/$DIRECTORY"
  rm -f $DOWNLOAD
  rm -rf $DIRECTORY
else
  echo "already exist directory to:$TO/$DIRECTORY"
fi
echo "=> download,extract,move complete"

cd "$TO/$DIRECTORY"
sudo ./configure -j2

cmdconfirm "sudo make -j2"
cmdconfirm "sudo make install"
cmdconfirm "sudo ln -s /usr/local/openresty/bin/openresty /usr/bin/openresty"
cmdconfirm "sudo ln -s /usr/local/openresty/nginx /etc/nginx"

echo "complete"
}
#!/usr/bin/env bash

installopenrestyubuntu(){

sudo apt-get install -y zlib1g-dev

#https://openresty.org/en/linux-packages.html
sudo apt-get install -y libpcre3-dev \
    libssl-dev perl make build-essential curl
wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"
sudo apt-get update
sudo apt-get install openresty

cmdconfirm "sudo ln -s /usr/local/openresty/bin/openresty /usr/bin/openresty"
cmdconfirm "sudo ln -s /usr/local/openresty/nginx /etc/nginx"

echo "complete"
}
#!/bin/bash
installpip(){
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm get-pip.py
}
#!/bin/bash
installrbenv(){
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}
#!/bin/bash
installtrans(){
#https://github.com/soimort/translate-shell
DIR=/usr/local/bin/
if [ ! -e ${DIR}trans ]; then
  wget git.io/trans
  chmod +x ./trans
  sudo mv ./trans $DIR
fi
}
#!/bin/bash
installvim(){
sudo mkdir -p /usr/local/src
cd /usr/local/src
if [ ! -d /usr/local/src/vim ] ; then
  if [ ! -f /usr/local/src/vim-master.zip ] ; then
    sudo wget --no-check-certificate https://github.com/vim/vim/archive/master.zip -O vim-master.zip
  fi
  sudo unzip vim-master.zip
  sudo mv vim-master vim
else
  echo "found vim directory"
fi
cd vim

sudo ./configure \
 --with-features=huge \
 --enable-multibyte \
 --enable-xim \
 --with-tlib=ncurses \
 --enable-terminal \
 --enable-pythoninterp=dynamic \
 --enable-python3interp=dynamic \
 --enable-fail-if-missing

cd src && sudo make install

echo "complete"
}
#!/bin/bash
skeldockermakefile(){
cat > Makefile << 'EOF'
AUTHOR := skel
IMAGE := skel
TAG := latest
PORT := 65535
all:
	@echo make dockerfile,dockerbuild,build,rm,frm,enable,disable,ps,run,stop,bash
dockerfile:
	@rm -f Dockerfile
	@echo 'FROM centos/systemd'>>Dockerfile
	@echo 'RUN yum -y update; yum clean all;'>>Dockerfile
	@echo 'RUN yum -y install curl libcurl-devel openssl-devel wget nano vim git zip expect bc mariadb httpd httpd-devel mod_ssl; yum clean all; systemctl enable httpd.service'>>Dockerfile
	@echo 'RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm'>>Dockerfile
	@echo 'RUN yum -y install --enablerepo=remi,remi-php72 php php-mbstring php-pdo php-gd php-pecl-redis php-mysql php-pecl-mcrypt'>>Dockerfile
	@echo 'RUN echo "<VirtualHost *:80>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  ServerName __default__">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  DocumentRoot /var/www/html">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  DirectoryIndex index.php index.html index.htm">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  <Directory /var/www/html>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "    Options Indexes FollowSymLinks">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "    AllowOverride All">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  </Directory>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "</VirtualHost>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'ENV TZ=Asia/Tokyo'>>Dockerfile
	@echo 'RUN echo "ZONE=Asia/Tokyo" > /etc/sysconfig/clock '>>Dockerfile
	@echo 'RUN rm -f /etc/localtime'>>Dockerfile
	@echo 'RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime'>>Dockerfile
	@echo 'RUN yum -y install cronie'>>Dockerfile
	@echo 'RUN echo "* * * * * /var/www/cron/cron.sh">>/var/spool/cron/root'>>Dockerfile
	@echo 'RUN yum -y install --enablerepo=remi jq nkf'>>Dockerfile
	@echo 'COPY override/ /'>>Dockerfile
	@echo 'CMD ["/usr/sbin/init"]'>>Dockerfile
dockerbuild:
	@mkdir -p override
	sudo docker build -t $(AUTHOR)/$(IMAGE):$(TAG) .
	@rmdir override --ignore-fail-on-non-empty
fdockerbuild:
	@mkdir -p override
	sudo docker build --rm -t $(AUTHOR)/$(IMAGE):$(TAG) .
	@rmdir override --ignore-fail-on-non-empty
build: dockerfile fdockerbuild
	@rm -f Dockerfile
rm:
	sudo docker rm $(IMAGE)
frm:
	sudo docker rm --force $(IMAGE)
enable:
	sudo docker update --restart=always $(IMAGE)
disable:
	sudo docker update --restart=no $(IMAGE)
ps:
	sudo docker ps -a -f name=$(IMAGE)
run:
	sudo docker run -d \
	--privileged \
	--name $(IMAGE) \
	--hostname $(IMAGE) \
	-p $(PORT):80 \
	-v "$(PWD)/www":/var/www \
	$(AUTHOR)/$(IMAGE):$(TAG)
stop:
	sudo docker stop $(IMAGE)
bash:
	sudo docker exec -it $(IMAGE) /bin/bash
EOF
}
#!/bin/bash
skelmakefile(){
cat > Makefile << 'EOF'
#!/usr/bin/make -f
SHELL=/bin/bash
##
define README
# README
endef
export README
RUN := /bin/bash

all:
	@echo make readme
readme:
	-@echo "$$README"
version:
	$(RUN) \
	--version
EOF
}
#!/bin/bash
skelversion(){
bash -c "cat << 'EOF' > VERSION
1.0.0
EOF"
}
#!/bin/bash
skelbash(){
OUTPUT=skel.sh
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/bin/bash
BASE=$(cd $(dirname $0); pwd)
DATEID=$(date +%Y%m%d%H%M%S)
#if [ $# -ne 1 ]; then
#  echo "require args:$#/1"
#else
#  echo "$1"
#fi
readonly DRYRUN=false
if "${DRYRUN}"; then echo "DRYRUN"; fi
#if [[ -d "${DIR}" ]] ; then echo "found dirctory"; fi
#ARR=('docker' 'vagrant');for i in "${!ARR[@]}";do ITEM="${ARR[i]}";if ! type "$ITEM" > /dev/null 2>&1;then echo "not found $ITEM";fi;done
#is_ok() { return 0; }
#is_ok "ARGS" && echo "OK" || echo "NG" && exit 1
#sudo bash -c "cat << 'EOF' > ok
#$DATEID
#EOF"
#if [ -f "/.dockerenv" ] ; then
#  echo "try docker process"
#fi
echo "complete"

EOF
chmod +x $OUTPUT
fi
}

#!/bin/bash
skelcmake(){
OUTPUT=CMakeLists.txt
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
cmake_minimum_required(VERSION 2.8.12.2)
project(skel CXX)
add_executable(skelton main.cpp)

EOF
fi
}

#!/bin/bash
skelcpp(){
OUTPUT=skel.cpp
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#include <iostream>
int main() {
  std::cout << "HelloWorld" << std::endl;
  return 0;
}
EOF
fi
}

#!/bin/bash
skelcsharp(){
OUTPUT=skel.cs
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
using System;
public class HelloWorld {
    public static void Main(string[] args){
        Console.WriteLine ("HelloWorld");
    }
}
EOF
fi
}

#!/bin/bash
skelgo(){
cat > main.go << 'EOF'
package main
//import (
//	_ "github.com/mattn/go-sqlite3"
//)
import (
	"fmt"
	"os"
	"path/filepath"
)
func main() {
	//fmt.Println("HelloWorld")
	pwd, _ := os.Getwd()
	fmt.Println("PWD:"+pwd)
	exe_path, _ := os.Executable()
	fmt.Println("EXE_PATH:"+exe_path)
	exe_dir := filepath.Dir(exe_path)
	fmt.Println("EXE_DIR:"+exe_dir)
	file, _ := os.Create(exe_dir+"/ok.txt")
	defer file.Close()
	file.Write(([]byte)("Hello,World!"))
}

EOF
}
#!/bin/bash
skelhtml(){
cat > index.html << 'EOF'
<html>
<head></head>
<body><center>HelloWorld</center>
</body>
</html>
EOF
}
#!/bin/bash
skeljson(){
OUTPUT=skel.json
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
{
  "root":{
    "id":"1",
    "list":["a","b","c"],
    "object":{"key":"val"},
    "array":[
      {"name":"name1"},
      {"name":"name2"}
    ]
  }
}
EOF
fi
}
#!/bin/bash
skelperl(){
OUTPUT=skel.pl
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "HelloWorld\n";

EOF
chmod 755 $OUTPUT
fi
}

#!/bin/bash
skelphp(){
cat > info.php << 'EOF'
<?php phpinfo();

EOF
}
skelref(){
cat > info.php << 'EOF'
<?php
class View extends Views{}

EOF
}
#!/bin/bash
skelpython(){
OUTPUT=main.py
if [ ! -f "$OUTPUT" ]; then
bash -c "cat << 'EOF' > $OUTPUT
#!/usr/bin/env python3
# coding:utf-8

EOF"
chmod +x $OUTPUT
fi
}
#!/bin/bash
ubuntuinstallntp(){
  sudo apt-get install ntp
  sudo /etc/init.d/ntp start
}
#!/bin/bash
installubuntuoraclejdk(){
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install oracle-java8-installer
}
#!/bin/bash
citravis(){
if ! type "travis" > /dev/null 2>&1 ; then
  echo "Command Not Found:travis"
  return 0;
fi
if [ $# -ne 2 ]; then
  echo "Require [Username],[Reponame]"
else
  echo "travis encrypt -r $1/$2 \"<github_token>\""
  read -sp "GithubToken:" TOKEN
  #echo "<<$TOKEN>>"
  travis encrypt -r $1/$2 "$TOKEN"
fi
}
#!/bin/bash
dockerexec(){
sudo docker exec -it $1 /bin/bash
}
dockerrminone(){
sudo docker images | awk '/<none/{print $3}' | xargs sudo docker rmi
}
dockerstopall(){
sudo docker stop $(sudo docker ps -a -q)
}
dockerrmall(){
sudo docker rm $(sudo docker ps -a -q)
}
dockerstartonwslforadmin(){
#sudo apt-get install -y docker.io
sudo cgroupfs-mount
#sudo usermod -aG docker $USER
#restart terminal for admin privilege
sudo service docker start
}
dockerphp72apache80html(){
  if [ $# -ne 2 ]; then
    echo "require name,port:$#/2"
  else
    sudo docker run -d --name $1 -p $2:80 -v "$PWD":/var/www/html php:7.2-apache
  fi
}
dockerphp72apache80www(){
  mkdir -p www
  sudo docker run -d --name php72apache -p 80:80 -v "$PWD/www":/var/www php:7.2-apache
}
dockercentos7systemd80(){
  sudo docker run -d --name centos7systemd --privileged -p 80:80 -v "$PWD":/var/www centos/systemd
}
