import os
import re

# Update hugo.toml
hugo_path = 'hugo.toml'
if os.path.exists(hugo_path):
    with open(hugo_path, 'r') as f:
        content = f.read()
    
    # Add basic SEO fields if not present
    if 'description' not in content:
        content += '\n[params]\n  description = "The latest news and updates on Generative AI, LLMs, and Machine Learning."\n  author = "GenAI News Team"\n'
    
    with open(hugo_path, 'w') as f:
        f.write(content)

# Update head partial if exists or create one
head_dir = 'layouts/partials'
os.makedirs(head_dir, exist_ok=True)
head_path = os.path.join(head_dir, 'head.html')

head_content = """
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ if .IsHome }}{{ site.Title }}{{ else }}{{ .Title }} | {{ site.Title }}{{ end }}</title>
<meta name="description" content="{{ with .Description }}{{ . }}{{ else }}{{ with site.Params.description }}{{ . }}{{ end }}{{ end }}">
<meta name="author" content="{{ site.Params.author }}">
<meta property="og:title" content="{{ .Title }}">
<meta property="og:description" content="{{ with .Description }}{{ . }}{{ else }}{{ with site.Params.description }}{{ . }}{{ end }}{{ end }}">
<meta property="og:type" content="website">
<style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; color: #333; max-width: 1200px; margin: 0 auto; padding: 20px; }
    h1, h2, h3 { color: #2c3e50; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
    header { border-bottom: 2px solid #eee; padding-bottom: 20px; margin-bottom: 30px; }
    .post { margin-bottom: 40px; }
    .post-title { font-size: 1.5em; margin-bottom: 10px; }
    .post-meta { color: #7f8c8d; font-size: 0.9em; }
</style>
"""
with open(head_path, 'w') as f:
    f.write(head_content)

print("SEO and UI improvements applied.")
