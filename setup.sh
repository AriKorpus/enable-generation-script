#!/bin/bash
set -e

echo "[$(date +%H:%M:%S)] Creating virtual environment"
python3 -m venv venv
source venv/bin/activate

echo "[$(date +%H:%M:%S)] Upgrading pip"
pip install -q --upgrade pip

echo "[$(date +%H:%M:%S)] Installing dependencies"
pip install -q numpy-stl pyyaml numpy

echo "[$(date +%H:%M:%S)] Setup complete"
