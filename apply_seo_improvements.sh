#!/bin/bash
cd GenAI-news-site

# 1. Update config for better SEO
sed -i 's/title = "GenAI News - The Latest in Artificial Intelligence & LLMs"/title = "GenAI News - Latest in AI, LLMs & Generative Tech 2026"/g' hugo.toml

# 2. Add an updated CSS file for UI/UX
mkdir -p static/css
cat << 'CSS' > static/css/genai-premium-v105.css
body {
    font-family: 'Inter', system-ui, sans-serif;
    background-color: #0d1117;
    color: #c9d1d9;
    line-height: 1.6;
}
h1, h2, h3, h4, h5, h6 {
    color: #f0f6fc;
    font-weight: 700;
}
a {
    color: #58a6ff;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
.header {
    background: linear-gradient(90deg, #1f6feb 0%, #238636 100%);
    padding: 1rem 2rem;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}
.article-card {
    background: #161b22;
    border: 1px solid #30363d;
    border-radius: 8px;
    padding: 1.5rem;
    margin-bottom: 1.5rem;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.article-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(0,0,0,0.2);
}
CSS

# Add the new CSS to config
sed -i 's/"css\/seo-modern-design-v30.css"/"css\/seo-modern-design-v30.css", "css\/genai-premium-v105.css"/g' hugo.toml

# Git commit and push
git add .
git commit -m "Enhance SEO title and inject modern UI/UX styles (genai-premium-v105.css)"
git push
