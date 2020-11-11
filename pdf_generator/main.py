import pdfkit
from fastapi import FastAPI
from pydantic import BaseModel


app = FastAPI()


class HTMLFile(BaseModel):
    file: str


@app.post("/generate_pdf/")
async def generate_pdf(json_values: HTMLFile):
    print(json_values.file)
    pdfkit.from_string(json_values.file, "micro.pdf")
    return {"file_size": "HELLO"}
