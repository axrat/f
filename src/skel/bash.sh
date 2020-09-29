#!/bin/bash
skelbash(){
OUTPUT=skel.sh
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/bin/bash
BASE=$(cd $(dirname $0); pwd)
DATEID=$(date +%Y%m%d%H%M%S)
if [ $# -ne 3 ]; then
  echo "require args:$#/3"
  exit 1
else
  echo "$1,$2,$3"
fi
readonly DRYRUN=false
if "${DRYRUN}"; then echo "DRYRUN"; fi
#if [[ -d "${DIR}" ]] ; then echo "found dirctory"; fi
#ARR=('a' 'b' 'c'); for i in "${!ARR[@]}"; do printf '${ARR[%s]}=%s\n' "$i" "${ARR[i]}"; done
#is_ok() { return 0; }
#is_ok "ARGS" && echo "OK" || echo "NG" && exit 1
#sudo bash -c "cat << 'EOF' > ok
#$DATEID
#EOF"
echo "complete"

EOF
chmod +x $OUTPUT
fi
}

