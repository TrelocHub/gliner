from fastapi import FastAPI
from pydantic import BaseModel
from gliner import GLiNER
import logging
import os

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

# Încărcare model cu try-except
model = None
try:
    logger.info("Încărc model GLiNER...")
    model = GLiNER.from_pretrained("urchade/gliner-multilingual-xlarge")
    logger.info("Model încărcat cu succes!")
except Exception as e:
    logger.error(f"Eroare la încărcarea modelului: {str(e)}")
    model = None  # Sau ridică eroare dacă vrei

class Request(BaseModel):
    text: str
    labels: list[str]

@app.get("/health")
def health():
    return {"status": "ok", "model_loaded": model is not None}

@app.post("/extract")
def extract(req: Request):
    if model is None:
        return {"error": "Modelul nu este încărcat!"}
    try:
        ents = model.predict_entities(req.text, req.labels)
        return {"entities": ents}
    except Exception as e:
        logger.error(f"Eroare la predict_entities: {str(e)}")
        return {"error": str(e)}
