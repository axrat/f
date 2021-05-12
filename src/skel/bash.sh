#!/bin/bash
skelbash(){
OUTPUT=skel.sh
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/bin/bash
DATEID=$(date +%Y%m%d%H%M%S)
BASE=$(cd $(dirname $0); pwd)
[ -e $BASE/_.sh ] && source $BASE/_.sh
cd $BASE
#if ask "FLG ?";then FLG=true;else FLG=false;fi
#if $FLG; then echo "ok"; else echo "ng"; fi
#if [ $# -ne 1 ]; then
#  echo "require args:$#/1"
#else
#  echo "$1"
#fi
#readonly DRYRUN=false
#if "${DRYRUN}"; then echo "DRYRUN"; fi
#if [[ -d "${DIR}" ]] ; then echo "found dirctory"; fi
#ARR=('docker' 'vagrant');for i in "${!ARR[@]}";do ITEM="${ARR[i]}";if ! type "$ITEM" > /dev/null 2>&1;then echo "not found $ITEM";fi;done
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

