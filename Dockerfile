FROM python:3.11-slim

WORKDIR /app

# deps for torch
RUN apt-get update && apt-get install -y \
    build-essential python3-dev \
    && rm -rf /var/lib/apt/lists/*

# install torch CPU-only wheels directly from PyTorch index
RUN pip install --no-cache-dir \
    torch==2.3.1+cpu torchvision==0.18.1+cpu torchaudio==2.3.1+cpu \
    --index-url https://download.pytorch.org/whl/cpu \
    transformers gliner fastapi uvicorn[standard]

COPY app.py .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
