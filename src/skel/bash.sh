#!/bin/bash
skelbash(){
OUTPUT=skel.sh
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/bin/bash
#sudo bash -c "cat << 'EOF' > ok
#$(date +%Y%m%d%H%M%S)
#EOF"
#readonly DRYRUN=true
#if "${DRYRUN}"; then echo "DRYRUN"; fi
echo "complete"
EOF
chmod +x $OUTPUT
fi
}

