#!/bin/bash

mkdir -p build

function build(){
  cat $PWD/src/$1/*.sh > $PWD/build/$1.sh
}

build install
build skel
build untitled
build arch
build ubuntu

rm -f $PWD/docs/f.sh
NOW=$(date +'%Y-%m-%d %H:%M:%S.%N')

bash -c "cat << 'EOF' > $PWD/build/f
#!/bin/bash
LOADED+=('f')
f(){
	hr
	echo VERSION:$NOW
	hr
}
EOF"
cat \
	$PWD/require/*.sh \
	$PWD/include/*.sh \
	$PWD/shell/*.sh \
	$PWD/build/f \
	$PWD/build/*.sh \
	> $PWD/docs/f.sh

chmod +x $PWD/docs/f.sh
echo "build at $NOW"
echo "complete"
