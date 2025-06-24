# Cell Counting and Feature Extraction (Without `bwlabel`)

This project implements a custom algorithm for detecting and labeling individual cells in a binary (black & white) microscopic image **without using built-in functions** like `bwlabel` or `connectedComponents`. Additionally, the program extracts properties of each detected cell and writes them to an Excel file.

## Task Overview

### Goal:
- Detect and count all the connected cell regions in a black-and-white microscopic image.
- For each cell, calculate:
  - **Area (number of pixels)**
  - **Average brightness** (from original grayscale image if available)

### Constraints:
- No use of `bwlabel`, `cv2.connectedComponents`, or similar built-in labeling functions.
- Labeling and analysis must be implemented manually (e.g., using flood-fill, DFS/BFS).

---

## Approach

1. **Image Input**: A gray scale image (black background, white cells).
2. **Convert to Binary**: Using adaptive thresholding and morphological closing to remove noise and close small gaps.
3. **Region Labeling**:
   - Use a manual DFS approach to traverse unvisited white pixels.
   - Label each connected region with a unique ID.
4. **Feature Extraction**:
   - For each labeled region:
     - Count the number of pixels → Area
     - calculate the average intensity of that region
5. **Export to Excel**:
   - Save results to an `.xlsx` file with one row per cell:
     - `Cell ID`, `Area`, `Average Brightness`


