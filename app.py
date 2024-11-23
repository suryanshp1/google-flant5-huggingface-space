from fastapi import FastAPI
from transformers import pipeline


## create a new FastAPI app instance

app=FastAPI()

# initialize text generation pipeline
pipe = pipeline("text2text-generation", model="google/flan-t5-small")

@app.get("/")
def home():
    return {"message": "Welcome to home page!"}

# Define a function to handle the GET request at '/generate'


@app.get("/generate")
def generate(text: str):
    # Generate text using the pipeline
    generated_text = pipe(text)

    # Return the generated text
    return {"output": generated_text[0]["generated_text"]}