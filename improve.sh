#!/bin/bash
# Apply SEO and design improvements
echo "<meta name=\"description\" content=\"Latest GenAI news and updates\">" >> index.html
echo "<style>body { font-family: Arial, sans-serif; background: #f4f4f9; color: #333; line-height: 1.6; padding: 20px; max-width: 800px; margin: 0 auto; } h1 { color: #0056b3; }</style>" >> index.html
git add .
git commit -m "Enhance SEO and UI design"
git push
