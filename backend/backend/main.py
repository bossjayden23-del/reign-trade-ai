from fastapi import FastAPI

app = FastAPI(title="REIGN TRADE AI - Backend")


@app.get("/health")
async def health():
    return {"status": "ok"}


@app.get("/ping")
async def ping():
    return {"pong": True}


if __name__ == "__main__":
    import argparse
    import uvicorn

    parser = argparse.ArgumentParser()
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8000)
    parser.add_argument("--check", action="store_true", help="run a quick import check and exit")
    args = parser.parse_args()

    if args.check:
        print("Backend import check OK")
    else:
        uvicorn.run("backend.main:app", host=args.host, port=args.port, reload=False)
