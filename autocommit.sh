#!/bin/bash

# Change to the directory you want to monitor
cd ~/dev/nicolasassi

# -------------------- add custom head -------------------------------

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

# Store the content of the snippet in a variable
SNIPPET_CONTENT=$(cat "$SNIPPET_FILE")

# Check if the snippet content already exists in the target HTML file
if ! grep -Fq "$SNIPPET_CONTENT" "$TARGET_HTML_FILE"; then
    echo "aaaa"
    # Read the snippet file and escape newlines for sed
    ESCAPED_SNIPPET_CONTENT=$(sed 's/$/\\/' "$SNIPPET_FILE")

    # Append the snippet before the closing </head> tag of the target HTML file
    sed -i '' "/<\/head>/i\\
    $ESCAPED_SNIPPET_CONTENT
    " "$TARGET_HTML_FILE"
fi

# -------------------- autocommit changes -------------------------------

# Add all changes
git add .

# Commit changes with a timestamp
git commit -m "Auto commit on $(date)"

# Push to the remote repository
git push origin main
