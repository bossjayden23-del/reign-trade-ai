#!/usr/bin/env python3
"""Simple CLI placeholder for AI engine"""
import argparse


def main():
    parser = argparse.ArgumentParser(description="REIGN TRADE AI - AI engine CLI")
    parser.add_argument("--version", action="store_true", help="print version")
    args = parser.parse_args()

    if args.version:
        from . import __version__

        print(f"ai_engine version {__version__}")
    else:
        print("AI engine placeholder — no trading logic implemented yet")


if __name__ == "__main__":
    main()
