#!/bin/bash
set -e

echo "Applying SEO and Design improvements..."

# 1. Update CSS
mkdir -p static/css
cat << 'CSS_EOF' > static/css/seo-modern-design-2026.css
:root {
  --primary-color: #2563eb;
  --secondary-color: #1e40af;
  --bg-color: #0f172a;
  --text-color: #f8fafc;
  --accent-color: #38bdf8;
  --font-base: 'Inter', -apple-system, sans-serif;
}
body {
  background-color: var(--bg-color);
  color: var(--text-color);
  font-family: var(--font-base);
  line-height: 1.6;
}
a { color: var(--accent-color); text-decoration: none; transition: color 0.3s ease; }
a:hover { color: var(--text-color); text-decoration: underline; }
h1, h2, h3, h4, h5, h6 { color: var(--text-color); margin-bottom: 1rem; }
.post-title { font-size: 2.5rem; font-weight: 700; line-height: 1.2; }
.post-meta { color: #94a3b8; font-size: 0.875rem; margin-bottom: 2rem; }
.container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
header { padding: 2rem 0; border-bottom: 1px solid #1e293b; margin-bottom: 3rem; }
.logo { font-size: 1.5rem; font-weight: bold; color: var(--accent-color); }
CSS_EOF

# 2. Update Hugo Config for SEO
sed -i 's/title = "GenAI News - The Latest in Generative AI"/title = "GenAI News 2026 - The Latest in Generative AI, LLMs & ML"/' hugo.toml

# 3. Add Structured Data (Schema.org) snippet to partials
mkdir -p layouts/partials
cat << 'HTML_EOF' > layouts/partials/seo.html
<meta name="description" content="{{ if .IsHome }}{{ site.Params.description }}{{ else }}{{ .Description | default .Summary }}{{ end }}" />
<meta name="keywords" content="{{ delimit site.Params.keywords ", " }}" />
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "{{ site.Title }}",
  "url": "{{ site.BaseURL }}",
  "description": "{{ site.Params.description }}"
}
</script>
HTML_EOF

# 4. Commit and Push
git config user.name "AI Agent"
git config user.email "agent@example.com"
git add static/css/seo-modern-design-2026.css hugo.toml layouts/partials/seo.html
git commit -m "SEO and Design UI/UX improvements 2026"
git push origin HEAD || echo "No remote or failed to push"

echo "Done"
