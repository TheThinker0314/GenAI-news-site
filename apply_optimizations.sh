#!/bin/bash
find content/posts -name "*.md" -exec python3 add_descriptions.py {} +
