import os
import subprocess
import csv
import time
from stl import mesh
import numpy as np
import sys
import yaml
from multiprocessing import Pool

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)

def checkSize(filePath, maxSize):
    vertices = mesh.Mesh.from_file(filePath).vectors.reshape(-1, 3)
    return np.all((np.max(vertices, axis=0) - np.min(vertices, axis=0)) <= maxSize)

def renderPart(args):
    part, params, scadParams, scadFile, openscadConfig, outputFile = args
    os.makedirs(os.path.dirname(outputFile), exist_ok=True)
    cmd = [openscadConfig['executable_path'], "--export-format", "stl", "-o", outputFile, "-D", f"part=\"{part}\""]
    for key, val in {**params, **scadParams}.items():
        if isinstance(val, bool):
            cmd.extend(["-D", f"{key}={'true' if val else 'false'}"])
        elif isinstance(val, str):
            cmd.extend(["-D", f"{key}=\"{val}\""])
        else:
            cmd.extend(["-D", f"{key}={val}"])
    log(f"Rendering {part} -> {outputFile}")
    result = subprocess.run(cmd + [scadFile], capture_output=True, text=True)
    if result.returncode != 0 or not os.path.exists(outputFile):
        log(f"ERROR: Failed to render {part}: {result.stderr.strip()}")
        return None
    log(f"Done: {part}")
    return outputFile

def renderSplittablePart(splitConfig, params, scadParams, scadFile, openscadConfig, materialDir, maxSize, workers):
    splitParam = splitConfig['param']
    options = splitConfig['options']

    for option in options:
        numPieces = option['pieces']
        partNames = option['parts']
        log(f"Trying {splitConfig['name']} in {numPieces} piece(s): {partNames}")
        tasks = [(part, {**params, splitParam: numPieces}, scadParams, scadFile, openscadConfig, f"{materialDir}/{part}.stl") for part in partNames]

        if len(tasks) == 1:
            renderPart(tasks[0])
        else:
            with Pool(workers) as pool:
                pool.map(renderPart, tasks)

        if all(os.path.exists(f"{materialDir}/{part}.stl") for part in partNames) and \
           all(checkSize(f"{materialDir}/{part}.stl", maxSize) for part in partNames):
            log(f"{splitConfig['name']} fits in {numPieces} piece(s)")
            return {splitParam: numPieces}

        log(f"{splitConfig['name']} too large in {numPieces} piece(s), trying next split")
        for part in partNames:
            path = f"{materialDir}/{part}.stl"
            if os.path.exists(path):
                os.remove(path)

    lastOption = options[-1]
    maxPieces = lastOption['pieces']
    maxPartNames = lastOption['parts']
    log(f"WARNING: {splitConfig['name']} exceeds max size even in {maxPieces} pieces, keeping {maxPieces}-piece version")
    tasks = [(part, {**params, splitParam: maxPieces}, scadParams, scadFile, openscadConfig, f"{materialDir}/{part}.stl") for part in maxPartNames]
    with Pool(workers) as pool:
        pool.map(renderPart, tasks)
    return {splitParam: maxPieces}

def processCase(caseData, config, workers):
    caseName = caseData[0]
    log(f"Processing case: {caseName}")
    params = {}
    for scadParam, colIndex in config.get('csv_to_scad', {}).items():
        if colIndex < len(caseData):
            val = caseData[colIndex]
            try:
                params[scadParam] = float(val) if '.' in val else int(val)
            except ValueError:
                params[scadParam] = val

    baseDir = config['paths']['output_dir']
    caseFolderName = config['output'].get('case_folder_name', '')
    if caseFolderName:
        baseDir = os.path.join(baseDir, caseFolderName)
    materialDirs = {mat: os.path.join(baseDir, caseName, mat) for mat in config['materials']}
    maxSize = config['stl_validation']['max_size_mm']
    scadFile = config['paths']['scad_file']
    openscadConfig = config['openscad']
    scadParams = config.get('scad_params', {})

    splitState = {}
    splittableNames = set()
    for splitConfig in config.get('splittable_parts', []):
        partName = splitConfig['name']
        splittableNames.add(partName)
        partMaterial = next((mat for mat, parts in config['materials'].items() if partName in parts), None)
        if partMaterial:
            splitState.update(renderSplittablePart(splitConfig, params, scadParams, scadFile, openscadConfig, materialDirs[partMaterial], maxSize, workers))

    tasks = [
        (part, {**params, **splitState}, scadParams, scadFile, openscadConfig, f"{materialDirs[mat]}/{part}.stl")
        for mat, parts in config['materials'].items()
        for part in parts if part not in splittableNames
    ]
    log(f"Rendering {len(tasks)} parts for {caseName}")
    with Pool(workers) as pool:
        pool.map(renderPart, tasks)
    log(f"Case complete: {caseName}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit("Usage: python render.py <config.yaml> <cases.csv>")

    configPath = sys.argv[1]
    csvPath = sys.argv[2]
    configDir = os.path.dirname(os.path.abspath(configPath))

    log(f"Config: {configPath}")
    log(f"Cases:  {csvPath}")

    with open(configPath) as f:
        config = yaml.safe_load(f)

    workers = config.get('num_workers', 4)
    log(f"Workers: {workers}")

    for key in ['scad_file', 'output_dir']:
        if not os.path.isabs(config['paths'][key]):
            config['paths'][key] = os.path.join(configDir, config['paths'][key])

    if not os.path.isabs(csvPath):
        csvPath = os.path.abspath(csvPath)

    outputDir = config['paths']['output_dir']
    caseFolderName = config['output'].get('case_folder_name', '')
    if caseFolderName:
        outputDir = os.path.join(outputDir, caseFolderName)
    os.makedirs(outputDir, exist_ok=True)

    cases = []
    with open(csvPath) as f:
        next(f)
        for row in csv.reader(f):
            cases.append(row)

    log(f"Found {len(cases)} case(s)")
    start = time.time()

    for row in cases:
        processCase(row, config, workers)

    log(f"All done. Total time: {time.time() - start:.1f}s")
    sys.exit(0)
