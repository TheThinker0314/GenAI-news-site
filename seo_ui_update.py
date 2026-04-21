import os

# Update hugo.toml
hugo_path = 'hugo.toml'
if os.path.exists(hugo_path):
    with open(hugo_path, 'r') as f:
        content = f.read()
    
    # Add basic SEO fields if not present
    if 'description' not in content:
        content += '\n[params]\n  description = "The latest news and updates on Generative AI, LLMs, and Machine Learning."\n  author = "GenAI News Team"\n  keywords = "Generative AI, LLMs, Machine Learning, AI News"\n'
    
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
<meta name="keywords" content="{{ with .Keywords }}{{ delimit . ", " }}{{ else }}{{ site.Params.keywords }}{{ end }}">
<meta name="author" content="{{ site.Params.author }}">
<meta name="robots" content="index, follow">

{{- template "_internal/opengraph.html" . -}}
{{- template "_internal/twitter_cards.html" . -}}

<link rel="stylesheet" href="{{ "css/style.css" | relURL }}">
"""
with open(head_path, 'w') as f:
    f.write(head_content)

# Create a basic stylesheet if it doesn't exist
css_dir = 'static/css'
os.makedirs(css_dir, exist_ok=True)
css_path = os.path.join(css_dir, 'style.css')
if not os.path.exists(css_path):
    css_content = """
body { 
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; 
    line-height: 1.8; 
    color: #333; 
    background-color: #fdfdfd;
    max-width: 800px; 
    margin: 0 auto; 
    padding: 20px; 
}
h1, h2, h3, h4, h5, h6 { 
    font-family: "Georgia", serif;
    color: #222; 
}
a { 
    color: #007bff; 
    text-decoration: none; 
}
a:hover { 
    text-decoration: underline; 
}
header { 
    border-bottom: 1px solid #eee; 
    padding-bottom: 20px; 
    margin-bottom: 40px; 
    text-align: center;
}
header h1 {
    margin: 0;
}
.post { 
    margin-bottom: 50px; 
}
.post-title a { 
    font-size: 1.8em; 
    color: #333;
}
.post-meta { 
    color: #666; 
    font-size: 0.9em; 
    margin-bottom: 10px;
}
img {
    max-width: 100%;
    height: auto;
    border-radius: 5px;
}
"""
    with open(css_path, 'w') as f:
        f.write(css_content)

print("SEO and UI improvements applied.")
