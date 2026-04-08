#!/bin/bash

POSTS_DIR="content/posts"

# Find all markdown files and iterate through them
find "$POSTS_DIR" -type f -name "*.md" | while read -r filepath; do
    echo "Processing $filepath..."

    # Check if description is already filled
    # Use grep with -q for quiet mode and check the exit status
    if ! grep -q 'description: ""' "$filepath"; then
        if grep -q 'description:' "$filepath"; then
            echo "Skipping, description already seems to be present."
            continue
        fi
    fi

    # Extract the URL from the markdown file
    URL=$(grep -o '\[Read the full article here\](.*)' "$filepath" | sed -n 's/\[Read the full article here\](\(.*\))/\1/p')

    if [ -z "$URL" ]; then
        echo "No URL found, skipping."
        continue
    fi

    echo "Fetching content from $URL..."
    # Fetch HTML, extract readable text, and then pass to Gemini for summary
    SUMMARY=$(curl -sL "$URL" | w3m -T text/html -dump | gemini summarize -)

    # Clean the summary: remove quotes and limit length if needed.
    # Shell-based text manipulation is more cumbersome, so we'll do a basic cleanup.
    CLEAN_SUMMARY=$(echo "$SUMMARY" | tr -d '"' | tr -d "'")

    if [ -z "$CLEAN_SUMMARY" ]; then
        echo "Failed to generate summary, skipping."
        continue
    fi

    echo "Generated Summary: $CLEAN_SUMMARY"

    # Use sed to replace the empty description with the new summary.
    # The sed command needs to handle special characters in the summary.
    # The 's' delimiter is changed to '#' to avoid conflicts with slashes in the summary.
    sed -i "s#description: \"\"#description: \"$CLEAN_SUMMARY\"#" "$filepath"

    echo "Updated description for $filepath"
done

echo "All posts have been processed."
