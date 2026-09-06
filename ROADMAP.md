# Roadmap — REIGN TRADE AI

Version guide from V1 → V8. Each version lists primary objectives and success criteria.

V1 — Scaffold & dev environment
- Create monorepo structure and development container
- Minimal FastAPI backend with health endpoint
- Minimal AI engine CLI placeholder
- Minimal Flutter Android-first app with lib/main.dart
- Success: Developers can open Codespaces/devcontainer and run smoke checks

V2 — Local integration & auth
- Basic API endpoints for user auth (mock)
- Local token-based authentication
- Flutter app sign-in screens (mocked)
- Success: end-to-end local flow with mocked data

V3 — Data ingestion & storage
- Add database (Postgres) scaffolding and migrations
- Data models for trades and signals (no execution)
- Background ingestion worker (Celery/RQ)
- Success: data persisted and queryable locally

V4 — Strategy plugin system
- Plugin API for strategy implementations
- Basic sandbox runner for backtesting
- Success: plug-and-play strategies in ai/ that can be tested

V5 — Live paper trading & monitoring
- Paper trading adapter to simulate exchange orders
- Monitoring dashboards and alerting
- Success: paper trades executed and visible in UI

V6 — Risk controls & governance
- Position sizing engine, circuit breakers, and risk limits
- Audit logs and tamper-evident trails
- Success: operational risk controls enforced in simulation

V7 — Production-grade AI models
- Model training pipelines, feature stores, validation & drift detection
- Canary deployments and model versioning
- Success: reproducible model training & safe rollout

V8 — Multi-exchange production deploy
- Connectors for major exchanges, order routing, resiliency
- High-availability deployment patterns, scaling, and CI/CD hardened
- Success: live deployments with monitoring, RBAC, and SRE runbooks

Each version will include tests, CI, and documentation as part of the definition of done.