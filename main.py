from fastapi import FastAPI
from pydantic import BaseModel
from gliner import GLiNER

# Inițializarea aplicației FastAPI
app = FastAPI(
    title="GLiNER Multilingual XLarge API",
    description="API pentru extragerea de entități folosind modelul gliner-multilingual-xlarge",
    version="1.0.0",
)

# Încărcarea modelului
# Asigură-te că ai o conexiune la internet la prima rulare pentru a descărca modelul.
model = GLiNER.from_pretrained("knowledgator/gliner-multilingual-xlarge")

class PredictionRequest(BaseModel):
    text: str
    labels: list[str]

@app.post("/predict/")
async def predict(request: PredictionRequest):
    """
    Endpoint pentru a face predicții.
    Primește un text și o listă de etichete (labels).
    """
    entities = model.predict_entities(request.text, request.labels)
    return {"entities": entities}

@app.get("/")
def read_root():
    return {"message": "GLiNER API is running. Folosește endpoint-ul /predict/ pentru a extrage entități."}
