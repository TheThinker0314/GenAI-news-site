#!/bin/bash
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site
sed -i 's/description = .*/description = "The latest GenAI news, trends, and tutorials for developers and enthusiasts."/' hugo.toml
mkdir -p static/css
echo 'body { font-family: "Inter", sans-serif; line-height: 1.6; color: #333; }
h1, h2, h3 { color: #222; }' > static/css/custom.css
git add hugo.toml static/css/custom.css
git commit -m "SEO & Design: Update description and tweak typography"
git push
