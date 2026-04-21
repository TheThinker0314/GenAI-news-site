#!/bin/bash
cd /home/ubuntu/GenAI-news-site

# Add meta description and keywords to config
sed -i 's/title = ".*"/title = "GenAI News Site - The Latest in Generative AI"\nDescription = "Stay updated with the latest news, trends, and breakthroughs in Generative AI, LLMs, and machine learning."\nKeywords = "Generative AI, AI news, LLM, machine learning, artificial intelligence"/g' hugo.toml

# Add basic CSS improvements
cat << 'CSS' >> static/css/custom.css
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
}
header {
    background-color: #2c3e50;
    color: #fff;
    padding: 1rem 0;
}
a {
    color: #3498db;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
CSS

# Add custom CSS to hugo.toml if not there
if ! grep -q "customCSS" hugo.toml; then
    echo -e '\n[params]\n  customCSS = ["css/custom.css"]' >> hugo.toml
fi

git add hugo.toml static/css/custom.css
git commit -m "Enhance SEO and UI/UX with custom CSS and meta tags"
git push origin main
