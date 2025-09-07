# Folosim o imagine de bază Python
FROM python:3.10-slim

# Setăm directorul de lucru în container
WORKDIR /app

# Copiem fișierul de cerințe
COPY requirements.txt .

# Instalăm dependențele
RUN pip install --no-cache-dir -r requirements.txt

# Copiem restul fișierelor aplicației
COPY . .

# Expunem portul pe care va rula aplicația
EXPOSE 8000

# Comanda pentru a rula aplicația la pornirea containerului
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
