from fastapi import FastAPI
import os

app = FastAPI(title="Project 1 CI/CD Demo")

APP_VERSION = os.getenv("APP_VERSION", "dev")


@app.get("/")
def read_root():
    return {
        "message": "Project 1 CI/CD running",
        "environment": os.getenv("APP_ENV", "local")
    }


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/version")
def version():
    return {"version": APP_VERSION}