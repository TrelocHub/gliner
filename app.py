from fastapi import FastAPI
from pydantic import BaseModel
from gliner import GLiNER
import logging
import traceback

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

model = None
try:
    logger.info("Încărc modelul GLiNER-multilingual-xlarge...")
    model = GLiNER.from_pretrained("urchade/gliner-multilingual-xlarge")
    logger.info("Model încărcat cu succes!")
except Exception as e:
    logger.error(f"Eroare la încărcarea modelului: {str(e)}")
    logger.error(f"Traceback: {traceback.format_exc()}")
    model = None

class Request(BaseModel):
    text: str
    labels: list[str]

@app.get("/health")
def health():
    return {"status": "ok", "model_loaded": model is not None}

@app.post("/extract")
def extract(req: Request):
    if model is None:
        return {"error": "Modelul nu este încărcat! Verifică logurile."}
    try:
        ents = model.predict_entities(req.text, req.labels, threshold=0.5)
        return {"entities": ents}
    except Exception as e:
        logger.error(f"Eroare la predict_entities: {str(e)}")
        return {"error": str(e)}
