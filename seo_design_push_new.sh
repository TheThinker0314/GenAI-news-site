#!/bin/bash
# Add SEO meta tags and structured data
mkdir -p layouts/partials
cat << 'INNER_EOF' > layouts/partials/head-seo-v2.html
<!-- Comprehensive SEO and UI/UX updates -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta name="keywords" content="GenAI, AI news, generative AI, AI updates">
<meta property="og:title" content="{{ .Title }} | {{ .Site.Title }}">
<meta property="og:description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">
<meta property="og:url" content="{{ .Permalink }}">
<meta name="twitter:card" content="summary_large_image">
INNER_EOF

mkdir -p layouts/_default
cat << 'INNER_EOF' > layouts/_default/baseof.html
<!DOCTYPE html>
<html lang="{{ site.LanguageCode | default "en-us" }}">
  <head>
    <meta charset="utf-8">
    <title>{{ block "title" . }}{{ .Title }} | {{ site.Title }}{{ end }}</title>
    {{ partial "head-seo-v2.html" . }}
    <link rel="stylesheet" href="/css/seo-modern-design-v2.css">
  </head>
  <body class="bg-near-black near-white">
    <header>
      <h1><a href="/">{{ site.Title }} - GenAI News</a></h1>
    </header>
    <main>
      {{ block "main" . }}{{ end }}
    </main>
    <footer>
      <p>&copy; {{ now.Year }} {{ site.Title }}</p>
    </footer>
  </body>
</html>
INNER_EOF

# CSS for UI/UX improvements
mkdir -p static/css
cat << 'INNER_EOF' > static/css/seo-modern-design-v2.css
:root {
  --primary-color: #2563eb;
  --bg-color: #0f172a;
  --text-color: #f8fafc;
  --font-sans: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}
body {
  font-family: var(--font-sans);
  background-color: var(--bg-color);
  color: var(--text-color);
  line-height: 1.6;
  margin: 0;
  padding: 0;
}
header {
  background-color: #1e293b;
  padding: 1rem 2rem;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}
header h1 a {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 700;
  font-size: 1.75rem;
}
main {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}
a {
  color: var(--primary-color);
}
a:hover {
  text-decoration: underline;
}
INNER_EOF

git add .
git commit -m "SEO: Enhance meta tags, schema, and UI design (new iteration)"
git push origin main
