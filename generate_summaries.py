import os
import re
import requests
from pathlib import Path
from bs4 import BeautifulSoup
from openai import OpenAI

def get_page_content(url):
    """Fetches and parses the content of a webpage."""
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Extract text from the body, focusing on paragraphs
        paragraphs = soup.find_all('p')
        text = ' '.join([p.get_text() for p in paragraphs])
        return text.strip()
    except requests.RequestException as e:
        print(f"Error fetching URL {url}: {e}")
        return None

def generate_summary(text, client):
    """Generates a summary using an AI model."""
    if not text:
        return ""
    try:
        # Use a chat model for summarization
        response = client.chat.completions.create(
            model="gpt-4-turbo", # Or another suitable model
            messages=[
                {"role": "system", "content": "Summarize the following article text into a compelling meta description of about 150-160 characters."},
                {"role": "user", "content": text[:4000]} # Limit input size
            ]
        )
        summary = response.choices[0].message.content.strip()
        # Clean up and truncate
        summary = summary.replace('"', '').replace("'", '')
        return summary[:160]

    except Exception as e:
        print(f"Error generating summary: {e}")
        return ""

def process_posts(posts_dir, client):
    """
    Processes markdown files to add summaries as descriptions.
    """
    for filepath in Path(posts_dir).rglob('*.md'):
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            parts = content.split('---', 2)
            if len(parts) < 3:
                continue

            front_matter_str = parts[1]
            body = parts[2].strip()

            # Check if description is empty or missing
            if 'description: ""' not in front_matter_str and 'description:' in front_matter_str:
                print(f"Skipping {filepath}, description already exists.")
                continue

            # Extract URL
            url_match = re.search(r'\[Read the full article here\]\((.*?)\)', body)
            if not url_match:
                continue
            
            article_url = url_match.group(1)
            
            # Get content and generate summary
            page_text = get_page_content(article_url)
            if not page_text:
                continue
                
            summary = generate_summary(page_text, client)
            if not summary:
                continue

            # Update front matter
            if 'description: ""' in front_matter_str:
                new_front_matter_str = front_matter_str.replace('description: ""', f'description: "{summary}"')
            else:
                new_front_matter_str = front_matter_str.strip() + f'\ndescription: "{summary}"'

            new_content = f'---\n{new_front_matter_str.strip()}\n---\n{body}'
            
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            
            print(f"Successfully added summary to {filepath}")

        except Exception as e:
            print(f"Failed to process {filepath}: {e}")

if __name__ == '__main__':
    # It's better to manage the API key via environment variables
    api_key = os.environ.get("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY environment variable not set.")
    
    client = OpenAI(api_key=api_key)
    posts_directory = 'content/posts'
    process_posts(posts_directory, client)
