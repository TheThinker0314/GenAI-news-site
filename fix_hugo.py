import re

with open('hugo.toml', 'r') as f:
    content = f.read()

# remove duplicate [params] at the bottom
content = re.sub(r'googleAnalytics = "G-GENAINEWS2026"\s*\[params\]\s*description = "The latest news and insights on Generative AI, LLMs, and Machine Learning."\s*author = "GenAI News Team"\s*keywords = \["GenAI", "AI", "LLM", "Machine Learning", "Artificial Intelligence", "News"\]', '', content)

with open('hugo.toml', 'w') as f:
    f.write(content)
