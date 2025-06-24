# Retinal Vessel Segmentation using Classical Image Processing (DRIVE Dataset)

This project presents a classical image processing pipeline to extract blood vessels from retinal images using the DRIVE dataset. The method avoids deep learning models and instead relies on a carefully designed sequence of enhancement and segmentation techniques.

---

##  Processing Pipeline

### 🔹 1. **Green Channel Extraction**
The green channel is selected from the RGB image because it provides the best contrast between the retinal background and the blood vessels.

### 🔹 2. **Inverse Log Transformation**
To restore original intensity values and enhance contrast, a reverse logarithmic transformation is applied to the green channel.

### 🔹 3. **Noise Reduction**
A bilateral filter is used to smooth the image while preserving edges (especially useful for keeping vessel boundaries intact).

### 🔹 4. **Unsharp Masking**
High-frequency components are extracted and added back to the image to enhance edges and fine vessel structures.

### 🔹 5. **Contrast Enhancement**
Adaptive histogram equalization (CLAHE) is applied to improve local contrast and better distinguish vessels from background tissue.

### 🔹 6. **Adaptive Thresholding**
A local thresholding technique is used to binarize the image and segment vessels based on enhanced contrast patterns.

### 🔹 7. **Region of Interest Masking**
To remove irrelevant parts of the image (like the bright border around the retina), the provided binary mask is eroded and applied to the vessel image.

---

## Evaluation Metrics

For each test image, the segmented result is compared to the expert annotation using the following metrics:

- **Sensitivity** (True Positive Rate)
- **Specificity** (True Negative Rate)
- **Accuracy** (Overall Pixel Classification Correctness)

---

## Evaluation Results (on DRIVE training set)

| Image             | Sensitivity (%) | Specificity (%) | Accuracy (%) |
|------------------|------------------|------------------|---------------|
| 21_training.tif  | 74.23           | 90.71           | 88.91         |
| 22_training.tif  | 71.62           | 88.53           | 86.32         |
| 23_training.tif  | 76.73           | 75.78           | 75.87         |
| 24_training.tif  | 71.14           | 88.83           | 85.86         |
| 25_training.tif  | 60.66           | 92.81           | 88.33         |
| 26_training.tif  | 73.28           | 88.22           | 86.40         |
| 27_training.tif  | 70.21           | 89.90           | 87.39         |
| 28_training.tif  | 69.36           | 90.44           | 87.45         |
| 29_training.tif  | 74.70           | 88.38           | 86.71         |
| 30_training.tif  | 73.64           | 85.28           | 83.95         |
| 31_training.tif  | 73.58           | 82.48           | 81.70         |
| 32_training.tif  | 71.87           | 90.54           | 88.30         |
| 33_training.tif  | 73.68           | 86.64           | 85.12         |
| 34_training.tif  | 66.97           | 76.60           | 75.23         |
| 35_training.tif  | 76.33           | 90.68           | 88.87         |
| 36_training.tif  | 67.39           | 90.54           | 86.89         |
| 37_training.tif  | 74.26           | 85.49           | 84.06         |
| 38_training.tif  | 73.26           | 91.14           | 88.89         |
| 39_training.tif  | 75.33           | 87.94           | 86.37         |
| 40_training.tif  | 77.42           | 91.56           | 90.01         |
| **Overall Avg.** | **72.28**        | **87.62**        | **85.63**     |
