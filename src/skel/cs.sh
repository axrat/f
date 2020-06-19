#!/bin/bash
skelcs(){
OUTPUT=skel.cs
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
using System;
public class HelloWorld {
    public static void Main(string[] args){
        Console.WriteLine ("HelloWorld");
    }
}
EOF
fi
}

