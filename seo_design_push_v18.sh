#!/bin/bash
git pull origin main || true

cat << 'INNER_EOF' >> layouts/partials/head-additions.html
<meta name="description" content="GenAI News Site - Get the latest news and updates on Generative AI.">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:title" content="GenAI News Site">
<meta property="og:description" content="Latest news in Generative AI.">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">
<style>
  body {
    font-family: 'Inter', system-ui, -apple-system, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #f9f9f9;
  }
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
  header {
    background-color: #2c3e50;
    color: white;
    padding: 2rem 0;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  }
  article {
    background: white;
    padding: 2rem;
    margin-bottom: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  }
</style>
INNER_EOF

git add layouts/partials/head-additions.html
git commit -m "SEO and UI Design improvements implemented"
git push origin main
