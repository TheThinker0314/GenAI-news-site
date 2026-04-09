#!/bin/bash
# Apply SEO and UI improvements
echo "Adding SEO metadata to head"
mkdir -p layouts/partials
cat << 'INNER_EOF' > layouts/partials/head.html
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ .Title }} | {{ .Site.Title }}</title>
    <meta name="description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
    <meta name="robots" content="index, follow">
    <meta property="og:title" content="{{ .Title }}">
    <meta property="og:description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
    <meta property="og:type" content="article">
    <link rel="canonical" href="{{ .Permalink }}">
    {{ hugo.Generator }}
</INNER_EOF>

echo "Updating hugo.toml with SEO params"
if ! grep -q "description = " hugo.toml; then
    sed -i '/\[params\]/a \ \ description = "The latest news and updates on Generative AI, LLMs, and AI research."' hugo.toml
fi

echo "Adding some CSS for UI improvement"
mkdir -p static/css
cat << 'INNER_EOF' > static/css/custom.css
body {
    font-family: 'Inter', sans-serif;
    line-height: 1.6;
    color: #333;
}
h1, h2, h3 {
    color: #111;
}
a {
    color: #0056b3;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
INNER_EOF

if ! grep -q "custom.css" layouts/partials/head.html; then
    sed -i '/<\/head>/i \ \ <link rel="stylesheet" href="/css/custom.css">' layouts/partials/head.html
fi

git add layouts/partials/head.html hugo.toml static/css/custom.css
git commit -m "feat: improve SEO meta tags and update UI typography"
git push origin main
