#!/bin/bash
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site

# Simple SEO Update
sed -i 's/title = .*/title = "GenAI News - The Latest in Artificial Intelligence"/' hugo.toml

mkdir -p layouts/partials
cat << 'INNER_EOF' > layouts/partials/head.html
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ if .IsHome }}{{ site.Title }}{{ else }}{{ .Title }} | {{ site.Title }}{{ end }}</title>
    <meta name="description" content="Stay updated with the latest news, trends, and breakthroughs in Generative AI.">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; line-height: 1.6; color: #333; max-width: 800px; margin: 0 auto; padding: 20px; }
        h1, h2, h3 { color: #2c3e50; }
        a { color: #3498db; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .post-meta { color: #7f8c8d; font-size: 0.9em; }
    </style>
</head>
INNER_EOF

# Git commit and push
git config user.name "OpenClaw"
git config user.email "bot@openclaw.com"
git add .
git commit -m "Enhance SEO and UI styling"
git push origin HEAD
