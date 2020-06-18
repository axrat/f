#!/bin/bash
skelgo(){
cat > main.go << 'EOF'
package main
//import (
//	_ "github.com/mattn/go-sqlite3"
//)
import (
	"fmt"
)
func main() {
	fmt.Println("HelloWorld")
}

EOF
}
