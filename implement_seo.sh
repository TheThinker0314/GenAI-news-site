#!/bin/bash
echo "Implementing SEO and design improvements..."
sed -i 's/title = ".*"/title = "GenAI News - The Latest in Generative AI"/g' hugo.toml
mkdir -p layouts/partials
cat << 'PARTIAL' > layouts/partials/head.html
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Stay updated with the latest news, trends, and breakthroughs in Generative AI.">
<title>{{ .Title }} | GenAI News</title>
PARTIAL
git add hugo.toml layouts/partials/head.html
git commit -m "SEO: Update title and add meta description"
git push origin main
