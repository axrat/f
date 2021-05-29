#!/bin/bash

BASE=$(cd $(dirname $0); pwd)
DATEID=$(date +%Y%m%d%H%M%S)
NOW=$(date +'%Y-%m-%d %H:%M:%S.%N')

mkdir -p $BASE/build
rm -f $BASE/build/*
rm -f $BASE/docs/f.sh

for FILE in $BASE/src/*; do
  DIR=${FILE##*/}
  cat $BASE/src/$DIR/*.sh > $BASE/build/$DIR.sh
done

bash -c "cat << 'EOF' > $BASE/build/f
#!/bin/bash
f(){
  hr
  echo VERSION:$NOW
  hr
}
EOF"

cat \
  $BASE/require/*.sh \
  $BASE/build/* \
  > $BASE/docs/f.sh

chmod +x $BASE/docs/f.sh
echo "build at $NOW"
echo "complete"
