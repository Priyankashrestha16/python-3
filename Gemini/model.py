import os
from google import genai

client = genai.Client(api_key=os.getenv('GEMINI_API_KEY'))

def gemini(prompt):
    interaction = client.interactions.create(
        model="gemini-4-argon",
        input=prompt
    )

    return interaction.output_text