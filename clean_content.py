import os
import hashlib
import re

duplicates = []

def generate_slug(filename):
    # Remove the .md extension
    name_without_extension = os.path.splitext(filename)[0]
    # Remove leading numbers and hyphens
    cleaned_name = re.sub(r'^\d+-*', '', name_without_extension)
    # Replace spaces and special characters with hyphens
    slug = re.sub(r'[^a-zA-Z0-9]+', '-', cleaned_name).lower()
    # Remove leading/trailing hyphens
    slug = slug.strip('-')
    return slug

def process_files(directory):
    hashes = {}
    for filename in os.listdir(directory):
        if filename.endswith(".md"):
            filepath = os.path.join(directory, filename)
            try:
                with open(filepath, 'rb') as f:
                    content = f.read()
                    file_hash = hashlib.md5(content).hexdigest()
                    if file_hash in hashes:
                        duplicates.append(filename)
                        os.remove(filepath)
                        print(f"Removed duplicate file: {filename}")
                    else:
                        hashes[file_hash] = filename
                        new_slug = generate_slug(filename)
                        new_filename = f"{new_slug}.md"
                        new_filepath = os.path.join(directory, new_filename)
                        if not os.path.exists(new_filepath):
                            os.rename(filepath, new_filepath)
                            print(f"Renamed {filename} to {new_filename}")
                        else:
                            # If the new filename already exists, it's likely a duplicate in content or title
                            # For simplicity, we'll just remove it. A more robust solution might merge them.
                            duplicates.append(filename)
                            os.remove(filepath)
                            print(f"Removed file due to slug collision: {filename}")
            except FileNotFoundError:
                print(f"File not found, likely already removed: {filename}")


if __name__ == "__main__":
    process_files("/home/ubuntu/GenAI-news-site/content/posts")
    print("\nDuplicate files removed:")
    for dup in set(duplicates):
        print(dup)
