from fastapi import FastAPI
from pydantic import BaseModel
import pkuseg

app = FastAPI()

class SegmentRequest(BaseModel):
    text: str
    model_name: str = "default" 
    postag: bool = False 
@app.post("/segment")
def segment_text(request: SegmentRequest):
    seg = pkuseg.pkuseg(model_name=request.model_name, postag=request.postag)
    result = seg.cut(request.text)
    return {"segmented": result}