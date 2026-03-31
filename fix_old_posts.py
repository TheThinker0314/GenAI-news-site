
import os
import re
import logging
from newspaper import Article
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

POSTS_DIR = 'content/posts'

def get_google_news_link(file_path):
    """Extracts the Google News link from a markdown file."""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        # Simple regex to find the Google News link
        match = re.search(r'\[Read the full article here\]\((https:\/\/news\.google\.com\/rss\/articles\/[^\)]+)\)', content)
        if match:
            return match.group(1)
    return None

def get_ai_summary(text):
    """
    Placeholder for a function that calls a GenAI model for a summary.
    For now, it returns the first 400 characters.
    """
    # This is a simple truncation, a real GenAI call would be better.
    return (text[:400].replace('"', '')) if len(text) > 400 else text.replace('"', '')

def process_and_update_post(file_path):
    """
    Processes a single post file: fetches full content and overwrites the file.
    """
    logging.info(f"Processing file: {file_path}")

    google_news_link = get_google_news_link(file_path)
    if not google_news_link:
        logging.warning(f"No Google News link found in {file_path}. Skipping.")
        return False

    try:
        # Create an Article object to fetch the real source.
        article = Article(google_news_link)
        article.download()
        article.parse()
    except Exception as e:
        logging.error(f"Could not download/parse article from {google_news_link}. Error: {e}")
        return False

    if not article.text or not article.title:
        logging.warning(f"Skipping article, no text or title found for {article.source_url}")
        return False

    logging.info(f"Successfully fetched article: {article.title}")

    # Generate a summary
    summary = get_ai_summary(article.text)
    
    # Get original publication date if available, otherwise use now.
    date_str = article.publish_date.strftime('%Y-%m-%dT%H:%M:%SZ') if article.publish_date else datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')

    # Prepare new front matter and content
    new_content = f"""---
title: "{article.title.replace('"', '')}"
date: {date_str}
draft: false
summary: "{summary}"
tags: ["GenAI", "News", "Updated"]
categories: ["News Digest"]
featured_image: "{article.top_image}"
source_url: "{article.source_url}"
---

{article.text}

---
*Originally published at [{article.meta_data.get('og', {}).get('site_name', 'the source')}]({article.source_url})*
"""

    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        logging.info(f"Successfully updated file: {file_path}")
        return True
    except Exception as e:
        logging.error(f"Could not write updated content to {file_path}. Error: {e}")
        return False

def main():
    logging.info("Starting script to fix old posts.")
    
    # Make sure we are in the script's directory
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    # Limit the number of posts to process in a single run to avoid timeouts and to be safe.
    processed_count = 0
    limit = 10 

    for filename in os.listdir(POSTS_DIR):
        if filename.endswith('.md'):
            file_path = os.path.join(POSTS_DIR, filename)
            
            # Check if file has already been updated by checking for a summary in its frontmatter
            with open(file_path, 'r', encoding='utf-8') as f:
                if 'summary:' in f.read():
                    # logging.info(f"Skipping already updated post: {filename}")
                    continue
            
            if process_and_update_post(file_path):
                processed_count += 1

            if processed_count >= limit:
                logging.info(f"Reached processing limit of {limit}. Exiting.")
                break
    
    logging.info(f"Finished fixing old posts. {processed_count} posts were updated.")

if __name__ == '__main__':
    main()
