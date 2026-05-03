#!/bin/bash

# Ensure we're in the right directory
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site

# Add a simple CSS file for design improvements
mkdir -p static/css
cat << 'CSS' > static/css/seo-modern-design-2026-v21.css
/* Modern UI/UX Improvements 2026 */
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    line-height: 1.6;
    color: #e0e0e0;
    background-color: #0f1115;
}
a {
    color: #4f8cf6;
    transition: color 0.2s ease-in-out;
}
a:hover {
    color: #79a8ff;
    text-decoration: underline;
}
.article-title {
    font-size: 2.5rem;
    font-weight: 800;
    letter-spacing: -0.02em;
    margin-bottom: 1rem;
}
.nav-link {
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}
CSS

# Update hugo.toml to include the new CSS and improve SEO
sed -i 's/custom_css = \[/custom_css = ["css\/seo-modern-design-2026-v21.css", /' hugo.toml
sed -i 's/title = "GenAI News - The Latest in Artificial Intelligence & LLMs"/title = "GenAI News 2026 - The Latest in Artificial Intelligence, Agents & LLMs"/' hugo.toml

# Git operations
git add static/css/seo-modern-design-2026-v21.css hugo.toml
git commit -m "feat: Enhance UI/UX design and improve SEO metadata"
git push origin main
