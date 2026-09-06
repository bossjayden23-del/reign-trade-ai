# Backend README

This folder contains the FastAPI backend scaffold.

Quick run (inside devcontainer):

# activate venv
source .venv/bin/activate

# run import check
python -m backend.backend.main --check

# run server
uvicorn backend.main:app --host 0.0.0.0 --port 8000
