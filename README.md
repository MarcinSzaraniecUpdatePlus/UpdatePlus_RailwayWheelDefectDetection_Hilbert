# Railway Wheelset Defect Detection

This repository contains the results and implementation of a research project conducted by Update Plus Sp. z o.o. The project focuses on detecting defects in railway wheelsets using Hilbert Transform-based vibration analysis and clustering techniques.

## Project Overview
Ensuring the safety and reliability of railway systems depends heavily on the early detection and monitoring of wheelset defects. This repository includes an efficient and computationally lean approach for identifying characteristic vibration patterns associated with common wheelset defects.

Key highlights of the project:
- Utilization of the Hilbert Transform for non-stationary vibration signal analysis.
- Implementation of clustering techniques to identify patterns in peak distributions.
- A focus on energy-efficient, autonomous operation suitable for onboard systems.

## Project Details
**Polish Name (Official):**
„PRACE BADAWCZO-ROZWOJOWE PROWADZONE PRZEZ FIRMĘ UPDATE PLUS SP. Z O.O. ZMIERZAJĄCE DO STWORZENIA INNOWACYJNEJ USŁUGI AUTOMATYCZNEJ DETEKCJI WAD I USTEREK ZESTAWÓW KOŁOWYCH WAGONÓW KOLEJOWYCH”

**English Name:**
"Research and Development Conducted by Update Plus Sp. z o.o. Aimed at Creating an Innovative Service for Automated Detection of Defects and Faults in Railway Wagon Wheelsets."

**Funding Information (Polish):**
Projekt współfinansowany ze środków Regionalnego Programu Operacyjnego Województwa Łódzkiego na lata 2014-2020 w ramach Działania 1.2 Inwestycje przedsiębiorstw w badania i innowacje, Poddziałanie 1.2.2 Projekty B+R przedsiębiorstw.

**Funding Information (English):**
This project was co-funded by the Regional Operational Program of the Łódzkie Voivodeship for 2014-2020 under Action 1.2 Investments in Enterprise Research and Innovation, Sub-Action 1.2.2 R&D Projects for Enterprises.

## Repository Structure
```
.
├── LICENSE                   # MIT License file
├── README.md                 # This README file
├── code/                     # Contains the Matlab implementation of the algorithm
│   └── hilbert_clustering_demo.m
├── documentation/            # Documentation and reports
│   └── PTR2024-4-6.pdf       # Full research article
```

## Getting Started

### Prerequisites
- Matlab (tested with version R2021b or later)
- A dataset of vibration signals (input as a 1D array `a`)

### Running the Code
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/railway-wheelset-defect-detection.git
   cd railway-wheelset-defect-detection
   ```
2. Open Matlab and navigate to the `code/` directory.
3. Load your vibration signal data into the workspace as a 1D array `a`.
4. Run the script:
   ```matlab
   hilbert_clustering_demo
   ```
5. The output will include:
   - Processed Hilbert Transform results.
   - Clustering analysis with histogram data (`histo_data_capture`).

## Documentation
- Full research article: [PTR2024-4-6.pdf](./documentation/PTR2024-4-6.pdf)

## License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## Authors
- Update Plus Sp. z o.o.

## Acknowledgements
This research was partially funded by the European Regional Development Fund under Grant No. POIR.04.01.04-00-057/17-00. For more information, see the accompanying documentation.
