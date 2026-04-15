
import os
import sys
import subprocess
import frontmatter

def generate_description(title):
    prompt = f"Generate a concise, SEO-friendly meta description of around 155 characters for a news article with the title: '{title}'"
    result = subprocess.run(['gemini', prompt], capture_output=True, text=True)
    return result.stdout.strip()

def generate_summary(title):
    prompt = f"Generate a 2-3 sentence summary for a news article with the title: '{title}'"
    result = subprocess.run(['gemini', prompt], capture_output=True, text=True)
    return result.stdout.strip()

def process_file(file_path):
    with open(file_path, 'r') as f:
        post = frontmatter.load(f)

    if not post.get('description'):
        print(f"Generating description for {file_path}...")
        description = generate_description(post['title'])
        post['description'] = description

    if not post.content.strip():
        print(f"Generating summary for {file_path}...")
        summary = generate_summary(post['title'])
        post.content = summary + "\n\n" + post.content

    with open(file_path, 'w') as f:
        frontmatter.dump(post, f)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        for file_path in sys.argv[1:]:
            process_file(file_path)
    else:
        print("Usage: python add_descriptions.py <file1> <file2> ...")
