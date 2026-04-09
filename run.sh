#!/bin/bash
set -e

echo "[$(date +%H:%M:%S)] Starting render: $1 $2"

if [ ! -d "venv" ]; then
    echo "[$(date +%H:%M:%S)] ERROR: venv not found, run setup.sh first"
    exit 1
fi

source venv/bin/activate
python3 render.py "$1" "$2"
echo "[$(date +%H:%M:%S)] run.sh complete"
