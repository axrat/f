#!/bin/bash
skelbash(){
OUTPUT=skel.sh
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/bin/bash
BASE=$(cd $(dirname $0); pwd)
#sudo bash -c "cat << 'EOF' > ok
#$(date +%Y%m%d%H%M%S)
#EOF"
#readonly DRYRUN=true
#if "${DRYRUN}"; then echo "DRYRUN"; fi
#is_ok() { return 0; }
#is_ok "ARG" && echo "OK" || echo "NG" && exit 1
#ARR=('a' 'b' 'c'); for i in "${!ARR[@]}"; do printf '${ARR[%s]}=%s\n' "$i" "${ARR[i]}"; done
echo "complete"
EOF
chmod +x $OUTPUT
fi
}

