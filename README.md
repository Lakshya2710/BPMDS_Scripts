# BPMDS_Scripts — Input Instances

This repository collects capacity-only CVRP (Capacitated Vehicle Routing Problem) input instances used in the BPMDS project. The instances are provided in TSPLIB `.vrp` format and grouped by source and scale under the `Inputs-all/` directory.

Summary

- Total instances: **307**
- Sources: **CVRPLIB** (130), **FILO2** (20), **Synthetic** (157)
- Default branch: `main`
- Last pushed: 2026-07-28T18:56:47Z (latest commit on `main`)

Language composition (repository):
- C++: 52.9%
- Python: 44.8%
- Makefile: 1.2%
- Shell: 1.1%

Directory layout (top-level)

- Inputs-all/
  - XS/  — Extra Small instances (10–101 customers)
  - S/   — Small instances (100–1,000 customers)
  - M/   — Medium instances (1,000–10,000 customers)
  - L/   — Large instances (10,000–100,000 customers)
  - XL/  — Extra Large instances (100,000+ customers)
  - XXL/ — Very large FILO2 / Synthetic instances
  - XXXL/— Largest synthetic instances (up to multiple millions)

What the inputs contain

- CVRPLIB: Standard capacity-only CVRP benchmarks (TSPLIB `.vrp`, EUC_2D edge weights, vehicle capacity Q). Sets included: CMT, Golden, X, AGS (Antwerp, Brussels, Flanders, Ghent, Leuven).

- FILO2: Large-scale Italian regional instances under `Inputs-all/*/I/` (TSPLIB `.vrp`, EUC_2D, capacity Q). Scale: L / XL / XXL (~20k – 1M customers). Count: 20 instances.

- Synthetic: XML-style synthetic CVRP instances generated with the Uchoa et al. generator. Naming convention:

  `XML<n>_<depotPos><custPos><demandType><avgRouteSize>_<instanceID>.vrp`

  Fields:
  - `n`: number of customers
  - Depot position: 1 Random · 2 Centered · 3 Cornered
  - Customer position: 1 Random · 2 Clustered · 3 Random-clustered
  - Demand distribution: 1–7 variants (unitary, small/large, quadrant-dependent, etc.)
  - Average route size: 1–6 (very short → ultra long)
  - `instanceID`: instance index (here `01`, `02`, ...)

Notes and pointers

- The full, itemized instance table (307 entries) is kept in this README for reference (sorted by Size / Source / Instance). See the `Inputs-all/` directory for the actual `.vrp` files and the clickable paths used in the table.

- If you add or remove instances, please update this README's summary counts and the instance table.

- The repository contains C++ and Python scripts to process these inputs. See the repository tree for tooling and usage examples.

Contact

- Repository owner: @Lakshya2710
- Repository URL: https://github.com/Lakshya2710/BPMDS_Scripts
