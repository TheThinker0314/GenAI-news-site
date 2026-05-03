#!/bin/bash
# Add basic SEO and Design improvements

# Add some custom CSS
mkdir -p static/css
cat << 'CSS' > static/css/custom.css
body { font-family: 'Inter', sans-serif; line-height: 1.6; color: #333; }
.header { background-color: #f8f9fa; padding: 2rem 0; text-align: center; }
.post-title { font-size: 2.5rem; font-weight: 700; margin-bottom: 1rem; }
.post-content { font-size: 1.125rem; }
.footer { text-align: center; padding: 2rem 0; margin-top: 3rem; background-color: #f8f9fa; }
a { color: #007bff; text-decoration: none; }
a:hover { text-decoration: underline; }
CSS

# Add custom CSS to hugo.toml
if ! grep -q "customCSS" hugo.toml; then
    sed -i '/\[params\]/a \ \ customCSS = ["/css/custom.css"]' hugo.toml
fi

# Add basic SEO tags to head
mkdir -p layouts/partials
cat << 'HTML' > layouts/partials/head-additions.html
<meta name="description" content="GenAI News - The latest updates, trends, and breakthroughs in Artificial Intelligence and Generative AI.">
<meta name="keywords" content="AI, Generative AI, ChatGPT, Machine Learning, Artificial Intelligence, News">
<meta property="og:title" content="{{ .Title }}">
<meta property="og:description" content="{{ .Summary | default "GenAI News - The latest updates in Artificial Intelligence." }}">
<meta property="og:type" content="article">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ .Title }}">
<meta name="twitter:description" content="{{ .Summary | default "GenAI News - The latest updates in Artificial Intelligence." }}">
HTML

git add static/css/custom.css hugo.toml layouts/partials/head-additions.html
git commit -m "Enhance SEO and design with custom CSS and meta tags"
git push origin main
