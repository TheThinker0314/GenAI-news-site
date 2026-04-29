#!/bin/bash
mkdir -p static/css
cat << 'CSS_EOF' > static/css/genai-premium-v15.css
/* V15 SEO and Design Updates */
body {
  font-family: 'Inter', system-ui, sans-serif;
  line-height: 1.7;
}
.premium-card {
  box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
  border-radius: 12px;
  transition: transform 0.2s ease;
}
.premium-card:hover {
  transform: translateY(-4px);
}
h1, h2, h3 {
  letter-spacing: -0.025em;
  color: #111827;
}
CSS_EOF

sed -i 's/"css\/genai-premium-v99.css"/"css\/genai-premium-v99.css", "css\/genai-premium-v15.css"/g' hugo.toml

git add static/css/genai-premium-v15.css hugo.toml
git commit -m "Enhance SEO and UI design styling v15"
git push
