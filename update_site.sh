#!/bin/bash
# Add meta description and SEO improvements
echo '<meta name="description" content="{{ if .IsHome }}{{ .Site.Params.description }}{{ else }}{{ .Summary | plainify | truncate 160 }}{{ end }}">' > layouts/partials/head-additions.html
echo '<meta property="og:title" content="{{ .Title }}">' >> layouts/partials/head-additions.html
echo '<meta property="og:description" content="{{ if .IsHome }}{{ .Site.Params.description }}{{ else }}{{ .Summary | plainify | truncate 160 }}{{ end }}">' >> layouts/partials/head-additions.html
echo '<meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">' >> layouts/partials/head-additions.html
echo '<meta name="twitter:card" content="summary_large_image">' >> layouts/partials/head-additions.html

# Add some UI improvements
mkdir -p static/css
cat << 'CSS' > static/css/custom.css
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; line-height: 1.6; color: #333; }
.title { font-weight: 700; color: #111; }
a { color: #0066cc; text-decoration: none; transition: color 0.2s; }
a:hover { color: #004499; text-decoration: underline; }
.content { max-width: 800px; margin: 0 auto; padding: 20px; }
article { margin-bottom: 2rem; border-bottom: 1px solid #eee; padding-bottom: 1rem; }
CSS

# Add custom CSS to hugo.toml if not exists
if ! grep -q "custom.css" hugo.toml; then
  echo 'customCSS = ["css/custom.css"]' >> hugo.toml
fi

git add .
git commit -m "Enhance SEO meta tags and improve UI design"
git push
