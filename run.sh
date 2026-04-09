#!/bin/bash
set -e
[ ! -d "venv" ] && exit 1
source venv/bin/activate
python3 render.py "$1" "$2"
