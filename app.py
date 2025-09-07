from fastapi import FastAPI
from pydantic import BaseModel
from gliner import GLiNER

app = FastAPI()
model = GLiNER.from_pretrained("urchade/gliner-multilingual-xlarge")

class Request(BaseModel):
    text: str
    labels: list[str]

@app.post("/extract")
def extract(req: Request):
    ents = model.predict_entities(req.text, req.labels)
    return {"entities": ents}
