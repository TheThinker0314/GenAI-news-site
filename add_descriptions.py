import os
import re
from pathlib import Path

def add_descriptions_and_alt_text_to_posts(posts_dir):
    """
    Adds a 'description' and 'image_alt' field to the front matter of Markdown posts if they are missing.
    The description is generated from the first 160 characters of the post's content.
    The image_alt is generated from the title if not present.
    """
    for filepath in Path(posts_dir).rglob('*.md'):
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Simple front matter and body extraction
            parts = content.split('---', 2)
            if len(parts) < 3:
                print(f"Skipping {filepath}: Not a valid front matter format.")
                continue

            front_matter_str = parts[1]
            body = parts[2].strip()
            
            new_front_matter_str = front_matter_str.strip()
            
            # Add description if it doesn't exist
            if 'description:' not in front_matter_str:
                # Create description
                # Remove markdown and newlines for a cleaner description
                clean_body = re.sub(r'#+\s*', '', body)  # Remove headers
                clean_body = re.sub(r'!?\[.*?\]\(.*?\)', '', clean_body) # Remove links and images
                clean_body = clean_body.replace('\n', ' ')
                description = (clean_body[:157] + '...') if len(clean_body) > 160 else clean_body
                new_front_matter_str += f'\ndescription: "{description}"'

            # Add image_alt if it doesn't exist
            if 'image_alt:' not in front_matter_str:
                title_match = re.search(r'title:\s*"(.*?)"', front_matter_str)
                if title_match:
                    title = title_match.group(1)
                    new_front_matter_str += f'\nimage_alt: "{title} - Generative AI News"'

            # Write back to file if changed
            if new_front_matter_str != front_matter_str.strip():
                new_content = f'---\n{new_front_matter_str}\n---\n{body}'
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Updated front matter for {filepath}")

        except Exception as e:
            print(f"Error processing {filepath}: {e}")

if __name__ == '__main__':
    posts_directory = 'content/posts'
    add_descriptions_and_alt_text_to_posts(posts_directory)
