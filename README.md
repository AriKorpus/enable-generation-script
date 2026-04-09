# e-NABLE Prosthetics Generation Script

Renders 3D-printable prosthetic parts from OpenSCAD templates based on patient measurements from CSV files — saves hours over manually rendering parts in OpenSCAD.

## Setup

1. Install [OpenSCAD](https://openscad.org/downloads.html)
2. Set `openscad.executable_path` in your template's `config.yaml` to match your install:
   - macOS: `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD`
   - Linux: `openscad`
   - Windows: `C:\Program Files\OpenSCAD\openscad.exe`
3. Run:
```bash
./setup.sh
```

## Run an Existing Design

```bash
./run.sh arm_templates/<design>/config.yaml <cases.csv>
```

The cases CSV must match the column format defined in the template's `cases_template.csv`. Output STLs are written to `output/<case_name>/` organized by material (`main`, `flexible`, `support`).

Available designs: `kwawu_2.1_thermoform`, `kwawu_2.0_socket`, `gripper_kwawu_long`

```bash
./run.sh arm_templates/kwawu_2.1_thermoform/config.yaml cases.csv
./run.sh arm_templates/kwawu_2.0_socket/config.yaml cases.csv
./run.sh arm_templates/gripper_kwawu_long/config.yaml cases.csv
```

## Add a New Design

1. Create the template folder:
```bash
mkdir -p arm_templates/my_design/source
cp arm_templates/kwawu_2.1_thermoform/config.yaml arm_templates/my_design/
cp arm_templates/kwawu_2.1_thermoform/cases_template.csv arm_templates/my_design/
```

2. Place your `.scad` file in `arm_templates/my_design/source/` and update `config.yaml`:
   - `paths.scad_file` — path to your `.scad` file
   - `openscad.executable_path` — path to your OpenSCAD install
   - `csv_to_scad` — map SCAD parameter names to CSV column indices
   - `materials` — list parts under `main`, `flexible`, or `support`
   - `scad_params` — static parameters applied to every render
   - `splittable_parts` — parts that auto-split if they exceed `max_size_mm`

3. Fill in `cases_template.csv` with patient measurements and run.

PRs with new designs are welcome.

---

Created by [Ari Korpus](https://github.com/arikorpus) for the [e-NABLE community](https://enablingthefuture.org).
Prosthetic designs by the e-NABLE community.

Released under the [MIT License](LICENSE).
