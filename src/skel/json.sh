#!/bin/bash
skeljson(){
OUTPUT=skel.json
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
{
  "root": {
    "name":"value",
    "list":["a","b","c"],
    "object":{
      "key": "val"
    }
  }
}
EOF
chmod +x $OUTPUT
fi
}
