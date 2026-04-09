#!/bin/bash
set -e
python3 -m venv venv
source venv/bin/activate
pip install -q --upgrade pip
pip install -q numpy-stl pyyaml numpy
