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
#OK=$(is_ok "ARGS" && echo true || echo false)
#if "${OK}"; then echo "ok"; else echo "ng"; fi
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

