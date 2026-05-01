#!/bin/bash
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site

# Add SEO tags
mkdir -p layouts/partials
cat << 'EOF' > layouts/partials/head-additions.html
<meta name="description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Summary | plainify | truncate 160 }}{{ end }}">
<meta property="og:title" content="{{ .Title }}" />
<meta property="og:description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Summary | plainify | truncate 160 }}{{ end }}" />
<meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}" />
<meta property="og:url" content="{{ .Permalink }}" />
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="{{ .Title }}"/>
<meta name="twitter:description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Summary | plainify | truncate 160 }}{{ end }}"/>
<link rel="stylesheet" href="/css/genai-seo-improved.css">
EOF

# Add CSS improvements
mkdir -p static/css
cat << 'EOF' > static/css/genai-seo-improved.css
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #f8f9fa;
}
.header {
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
h1, h2, h3, h4, h5, h6 {
    color: #2c3e50;
    font-weight: 600;
}
a {
    color: #3498db;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
.content {
    background: #fff;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
}
EOF

git add layouts/partials/head-additions.html static/css/genai-seo-improved.css
git commit -m "Enhance SEO meta tags and improve UI/UX design"
git push
