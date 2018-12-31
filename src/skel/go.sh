#!/bin/bash
skelgo(){
cat > main.go << 'EOF'
package main
import (
	"github.com/TransAssist/goz"
)
import (
	_ "github.com/mattn/go-sqlite3"
)
import (
	"fmt"
)

func main() {
	fmt.Println("HelloWorld")
	goz.Complete()
}
EOF
}
