# REIGN TRADE AI

A modular monorepo that will become a production-grade AI-powered trading assistant combining a Flutter Android-first client, a FastAPI backend, and a dedicated AI engine.

This repository contains scaffolding, Codespaces/devcontainer configuration, docs, and verification scripts so developers can open the project immediately in GitHub Codespaces or a local devcontainer and run minimal smoke checks.

Goals
- Provide a clean, maintainable monorepo for frontend, backend, and AI engine.
- Enable onboarding via Codespaces with all required toolchains installed (Flutter, Python 3.11, Node 20).
- Provide a clear roadmap from V1 to V8.

Quick start (development)
1. Open this repository in GitHub Codespaces or with the VS Code Remote - Containers extension.
2. The devcontainer will run ./scripts/setup-dev.sh automatically after creation. Alternatively run it manually:

   ./scripts/setup-dev.sh

3. Verify the backend smoke check locally:

   # from repo root
   python -m backend.backend.main --check

4. Verify the AI engine CLI:

   python -m ai_engine.cli --version

5. Flutter (inside the devcontainer):
   cd app
   flutter pub get
   flutter run

Notes
- No trading logic has been implemented yet. This is scaffolding only.
