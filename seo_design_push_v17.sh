#!/bin/bash
# Adding more SEO keywords and design settings to hugo.toml
sed -i 's/keywords = \[/keywords = \["AI News 2026", "Generative Models", /' hugo.toml
sed -i 's/theme_color = '\''#1b1b1b'\''/theme_color = '\''#121212'\''/' hugo.toml

# Creating a new CSS file for design improvements
mkdir -p static/css
cat << 'CSS' > static/css/seo-modern-design-2026.css
body { font-family: 'Inter', sans-serif; line-height: 1.6; color: #333; }
.bg-near-black { background-color: #121212 !important; }
h1, h2, h3 { font-weight: 700; letter-spacing: -0.02em; }
article { max-width: 800px; margin: 0 auto; padding: 20px; }
.premium-shadow { box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
CSS

git add hugo.toml static/css/seo-modern-design-2026.css
git commit -m "feat: enhance SEO keywords and update modern design CSS for 2026"
git push origin main
