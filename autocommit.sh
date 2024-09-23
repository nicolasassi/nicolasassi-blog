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

# Remove specific meta and link tags from the target HTML file
sed -i '' '/<title>index</title>/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta name="description" content="nicolasassi.com - index">/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta property="og:title" content="index">/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta property="og:description" content="nicolasassi.com - index">/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta property="og:type" content="website">/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta property="og:url" content="index.html">/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta property="og:image" content="images\/nicolas_profile_picture.jpg">/d' "$TARGET_HTML_FILE"
sed -i '' '/<meta property="og:site_name" content="nicolasassi.com">/d' "$TARGET_HTML_FILE"

# Remove <link> tag regardless of its position on a line
sed -i '' 's|<link rel="icon" href="site-lib/media/favicon.png">||g' "$TARGET_HTML_FILE"


# Store the content of the snippet in a variable
SNIPPET_CONTENT=$(cat "$SNIPPET_FILE")

# Check if the snippet content already exists in the target HTML file
if ! grep -Fq "$SNIPPET_CONTENT" "$TARGET_HTML_FILE"; then
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
