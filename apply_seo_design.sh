#!/bin/bash
cd /home/ubuntu/GenAI-news-site
# Update title and add description if not present
sed -i 's/^title = .*/title = "GenAI News & Insights"/' hugo.toml
git add hugo.toml
git commit -m "SEO: Update site title for better ranking" || true
git push origin HEAD || true
