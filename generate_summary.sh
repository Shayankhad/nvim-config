#!/bin/bash

OUTPUT_FILE="summary.txt"

# Clear the output file if it exists
> "$OUTPUT_FILE"

echo "===================================================" >> "$OUTPUT_FILE"
echo "                   PROJECT TREE                    " >> "$OUTPUT_FILE"
echo "===================================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Check if 'tree' command is installed, if not use 'find' to emulate it
if command -v tree &> /dev/null; then
    tree -I ".git|lazy-lock.json|$OUTPUT_FILE" >> "$OUTPUT_FILE"
else
    find . -type d -name ".git" -prune -o -not -name "lazy-lock.json" -not -name "$OUTPUT_FILE" -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g' >> "$OUTPUT_FILE"
fi

echo "" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "===================================================" >> "$OUTPUT_FILE"
echo "                LUA FILES CONTENT                  " >> "$OUTPUT_FILE"
echo "===================================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Find all .lua files and append their content
find . -type d -name ".git" -prune -o -name "*.lua" -print | sort | while read -r file; do
    echo "---------------------------------------------------" >> "$OUTPUT_FILE"
    echo "FILE: $file" >> "$OUTPUT_FILE"
    echo "---------------------------------------------------" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo "Summary successfully generated in $OUTPUT_FILE!"
