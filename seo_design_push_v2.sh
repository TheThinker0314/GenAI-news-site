#!/bin/bash
echo "Implementing SEO and design improvements..."

# Add meta keywords to hugo.toml if not present
sed -i 's/title = "GenAI News.*/title = "GenAI News - Premium AI \& LLM Updates 2026"/' hugo.toml

# Create a new modern design CSS file
mkdir -p static/css
cat << 'CSS_EOF' > static/css/genai-premium-v4.css
/* 2026 Premium Design Update */
:root {
  --primary-color: #0d1117;
  --secondary-color: #58a6ff;
  --text-primary: #c9d1d9;
  --bg-primary: #010409;
}
body {
  background-color: var(--bg-primary);
  color: var(--text-primary);
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
  line-height: 1.6;
}
.header {
  border-bottom: 1px solid #30363d;
  background: var(--primary-color);
  padding: 1rem 0;
}
.article-title {
  color: var(--secondary-color);
  font-weight: 700;
}
CSS_EOF

# Add it to hugo.toml
sed -i 's/"css\/genai-premium-v3.css"/"css\/genai-premium-v3.css", "css\/genai-premium-v4.css"/' hugo.toml

# Git operations
git config user.name "AI Assistant"
git config user.email "ai@openclaw.local"
git add hugo.toml static/css/genai-premium-v4.css
git commit -m "SEO & Design updates: New title & premium v4 CSS for better UX/UI"
git push origin main
echo "Done."
