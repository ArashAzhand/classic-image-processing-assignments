# Classical Image Processing Assignments

This repository contains a collection of classical image processing assignments implemented in MATLAB. These projects were completed as part of an academic course, focusing on core image analysis techniques without the use of machine learning or deep learning.

Each folder represents a self-contained assignment with its own explanation, implementation, and results.

---

## Project List

### [adaptive-median-filter-salt-pepper](./adaptive-median-filter-salt-pepper)
An adaptive method to remove salt-and-pepper noise from grayscale images.  
The approach dynamically selects the optimal kernel size (from 3x3 up to 21x21) and applies median filtering repeatedly until noise is reduced.  
Final results are evaluated using PSNR across multiple images and noise levels.

---

### [cell-counting-and-feature-extraction](./cell-counting-and-feature-extraction)
Implements a custom algorithm (without using `bwlabel`) to label and count connected components (cells) in a binary microscope image.  
For each detected region, it computes the area and average brightness, and outputs the results into an Excel spreadsheet.  
Includes grayscale-to-binary preprocessing with thresholding and morphological operations.

---

### [image-resizing-methods](./image-resizing-methods)
Compares various image resizing techniques, including nearest neighbor, bilinear, bicubic, and lanczos.  
Demonstrates visual and structural differences between methods using standard test images.  

---

### [retinal-vessel-segmentation-DRIVE](./retinal-vessel-segmentation-DRIVE)
Segments blood vessels from retinal fundus images using a classical pipeline.  
Includes: green channel processing, log transformation, bilateral filtering, contrast enhancement, adaptive thresholding, and region masking.  
Evaluates segmentation results on the DRIVE dataset using sensitivity, specificity, and accuracy metrics.

---



## Purpose

These assignments reflect hands-on experience with essential image processing tasks such as noise removal, segmentation, binary labeling, and evaluation.  
The implementations demonstrate understanding of algorithmic design, experimentation, and performance evaluation using domain-specific metrics.

Developed by Arash Azhand as part of an undergraduate computer engineering image processing course.
