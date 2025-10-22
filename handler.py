import runpod
from vllm import LLM, SamplingParams
import os 


hf_token = os.getenv("HUGGING_FACE_HUB_TOKEN")
# Charger le modèle
llm = LLM(model="google/gemma-3-27b-it",hf_token=hf_token)


def generate_text(prompt: str, temperature=0.7, max_tokens=256):
    sampling_params = SamplingParams(temperature=temperature, max_tokens=max_tokens)
    outputs = llm.generate([prompt], sampling_params)
    return outputs[0].outputs[0].text

def handler(event):
    # Lire le prompt depuis la requête
    prompt = event.get("input", {}).get("prompt", "")
    temperature = event.get("input", {}).get("temperature", 0.7)
    max_tokens = event.get("input", {}).get("max_tokens", 256)

    # Génération
    result = generate_text(prompt, temperature, max_tokens)
    return {"response": result}

# Lancer le serveur RunPod
runpod.serverless.start({"handler": handler})
