#!/bin/bash
mkdir -p static/css
cat << 'CSS_EOF' > static/css/genai-premium-v16.css
/* V16 SEO and Design Updates */
body {
  font-family: 'Inter', system-ui, sans-serif;
  line-height: 1.8;
  color: #333;
}
.premium-card {
  box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
  border-radius: 12px;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.premium-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
}
h1, h2, h3 {
  letter-spacing: -0.025em;
  color: #111827;
}
a.read-more {
  color: #2563eb;
  text-decoration: none;
  font-weight: 500;
}
a.read-more:hover {
  text-decoration: underline;
}
CSS_EOF

sed -i 's/"css\/genai-premium-v15.css"/"css\/genai-premium-v15.css", "css\/genai-premium-v16.css"/g' hugo.toml

git add static/css/genai-premium-v16.css hugo.toml
git commit -m "Enhance SEO and UI design styling v16"
git push
