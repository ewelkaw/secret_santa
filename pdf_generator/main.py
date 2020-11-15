import base64
from fastapi import FastAPI
from pydantic import BaseModel
from weasyprint import HTML


app = FastAPI()


class HTMLFile(BaseModel):
    file: str


@app.post("/generate_pdf/")
async def generate_pdf(json_values: HTMLFile):
    byte = HTML(string=json_values.file).write_pdf()
    return base64.b64encode(byte)
