from fastapi import FastAPI

app = FastAPI()

try:
    f = open("num.txt")
    ind = f.read()
    f.close()
except:
    ind = "Server One"

@app.get("/")
async def root():
    return {"message": "Hello World form " + ind}