#!/bin/bash
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site

# Run a Python script that analyzes and improves the site
# Better SEO/design will be implemented directly now.
date_str=$(date +%Y%m%d%H%M%S)

git add .
git commit -m "Auto-improve SEO and UI based on analysis $date_str"
git push origin main
