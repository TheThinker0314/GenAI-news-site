#!/bin/bash
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site
git pull
# Modify hugo.toml to ensure good SEO title/description if not present
sed -i 's/title = .*/title = "GenAI News - Latest AI Updates & Insights"/' hugo.toml
git add hugo.toml
git commit -m "SEO: Update site title for better search visibility"
git push
