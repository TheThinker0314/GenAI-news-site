#!/bin/bash
# Modify hugo.toml for better SEO
sed -i 's/title = .*/title = "GenAI News 2026 - The Leading Source for AI, Agents & LLMs"/' hugo.toml
sed -i 's/description = .*/description = "The ultimate guide to Generative AI, LLMs, and AI Agents in 2026. Daily news, tutorials, and breakthroughs."/' hugo.toml

git add hugo.toml
git commit -m "Enhance SEO title and description for 2026"
git push origin HEAD
