# ---- Étape 1 : Base ----
FROM python:3.13-slim

# ---- Étape 2 : Préparation ----
WORKDIR /app

# Installer quelques dépendances système nécessaires à PyTorch, vLLM, etc.
RUN apt-get update && apt-get install -y \
    git wget curl build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---- Étape 3 : Copier les fichiers ----
COPY requirements.txt /app/requirements.txt
COPY handler.py /app/handler.py

# ---- Étape 4 : Installer les dépendances ----
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ---- Étape 5 : Variables d'environnement ----
ENV MODEL_NAME="google/gemma-3-27b-it"
ENV HUGGINGFACE_HUB_CACHE="/root/.cache/huggingface"

# ---- Étape 6 : Lancement du handler RunPod ----
CMD ["python", "-u", "handler.py"]
