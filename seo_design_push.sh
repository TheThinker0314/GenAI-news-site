#!/bin/bash
cd /home/ubuntu/.openclaw/workspace/GenAI-news-site

# 1. Update CSS
mkdir -p static/css
cat << 'CSS' > static/css/seo-improvements.css
/* Design Improvements */
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #fcfcfc;
}

h1, h2, h3, h4 {
    font-family: 'Montserrat', sans-serif;
    color: #1a202c;
    letter-spacing: -0.02em;
}

.article-content {
    max-width: 800px;
    margin: 0 auto;
    font-size: 1.125rem;
}

a {
    color: #2563eb;
    text-decoration: none;
    transition: color 0.2s ease;
}

a:hover {
    color: #1d4ed8;
    text-decoration: underline;
}

.nav-header {
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 50;
    background: #fff;
}
CSS

# 2. Update Hugo.toml SEO Title
sed -i 's/^title = .*/title = "GenAI News - Latest AI & LLM Updates"/' hugo.toml

# 3. Add a layout override for head if doesn't exist to ensure meta tags
mkdir -p layouts/partials
cat << 'HTML' > layouts/partials/seo_meta.html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta name="author" content="{{ .Site.Params.author }}">
<meta property="og:title" content="{{ .Title }} - {{ .Site.Title }}">
<meta property="og:description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">
<meta name="twitter:card" content="summary_large_image">
HTML

git add .
git commit -m "SEO & UX: Enhance typography, contrast, layout, and meta tags"
git push origin HEAD
