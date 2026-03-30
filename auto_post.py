import os
import sys
import xml.etree.ElementTree as ET
import urllib.request
from datetime import datetime
import re
import subprocess

RSS_URL = 'https://news.google.com/rss/search?q="Generative+AI"&hl=en-US&gl=US&ceid=US:en'
POSTS_DIR = 'content/posts'

def sanitize_filename(title):
    s = re.sub(r'[^a-zA-Z0-9\s-]', '', title)
    return s.strip().replace(' ', '-').lower()[:50]

def main():
    try:
        req = urllib.request.urlopen(RSS_URL)
        xml_data = req.read()
        root = ET.fromstring(xml_data)
        
        channel = root.find('channel')
        items = channel.findall('item')
        
        if not items:
            print("No items found in RSS.")
            return

        for item in items:
            title = item.find('title').text
            link = item.find('link').text
            pub_date = item.find('pubDate').text
            
            filename = f"{sanitize_filename(title)}.md"
            filepath = os.path.join(POSTS_DIR, filename)
            
            if not os.path.exists(filepath):
                # New post
                date_str = datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
                content = f"""---
title: "{title.replace('"', '')}"
date: {date_str}
draft: false
tags: ["GenAI", "News"]
categories: ["News"]
---

[Read the full article here]({link})
"""
                with open(filepath, 'w') as f:
                    f.write(content)
                
                print(f"Created post: {filename}")
                
                # Commit and push
                subprocess.run(['git', 'add', filepath], check=True)
                subprocess.run(['git', 'commit', '-m', f'feat: Auto-post {filename}'], check=True)
                subprocess.run(['git', 'push', 'origin', 'main'], check=True)
                return # Only one per run
        print("No new items.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == '__main__':
    main()
