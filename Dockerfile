FROM vllm/vllm-openai:latest

# Installer les dépendances nécessaires (si besoin)
RUN pip install --no-cache-dir runpod==1.6.0

# Définir le modèle
ENV MODEL_NAME="google/gemma-3-27b-it"

# Copier le script d’entrée
COPY handler.py /app/handler.py

# Lancer l’API
CMD ["python3", "-u", "handler.py"]
