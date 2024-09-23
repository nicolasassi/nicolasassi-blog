#!/bin/bash

# Change to the directory you want to monitor
cd ~/dev/nicolasassi

# Assign arguments to variables
SNIPPET_FILE=custom_head.html
TARGET_HTML_FILE=dist/index.html

# Check if both files exist
if [ ! -f "$SNIPPET_FILE" ]; then
    echo "Error: Snippet file '$SNIPPET_FILE' not found."
    exit 1
fi

if [ ! -f "$TARGET_HTML_FILE" ]; then
    echo "Error: Target HTML file '$TARGET_HTML_FILE' not found."
    exit 1
fi

# Append the snippet before the closing </head> tag of the target HTML file
sed -i '' "/<\/head>/i\\
$(cat "$SNIPPET_FILE")
" "$TARGET_HTML_FILE"

# Add all changes
git add .

# Commit changes with a timestamp
git commit -m "Auto commit on $(date)"

# Push to the remote repository
git push origin main
