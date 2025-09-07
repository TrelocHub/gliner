FROM intel/intel-optimized-pytorch:latest

WORKDIR /app

# Install deps
RUN pip install --no-cache-dir transformers gliner fastapi uvicorn[standard]

# Copy app.py into the image
COPY app.py .

# Run server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
