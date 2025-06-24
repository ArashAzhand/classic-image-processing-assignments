# Adaptive Median Filtering for Salt & Pepper Noise Removal

This project presents an enhanced median filtering approach to remove salt & pepper noise from grayscale images. The method adapts the kernel size and applies the filter iteratively to maximize denoising quality.

##  Method Description

### Problem:
Standard median filters work well on low-noise images, but at high noise densities (e.g., 70%–90%), fixed-size kernels fail to restore detail while removing all noise.

### Proposed Adaptive Method:
- **Step 1:** Iterate over every pixel.
- **Step 2:** Check if pixel value is 0 or 255 (noisy).
  - If **not noisy**, keep original value.
  - If **noisy**, apply median filter over a dynamic kernel.
- **Step 3:** Loop over increasing kernel sizes from `3x3` to `21x21` to find the best PSNR.
- **Step 4:** Repeat the process until no more salt/pepper pixels are left or a max iteration limit is reached to avoid infinite loops.

This allows the method to:
- Adapt kernel size to local noise conditions
- Perform **aggressive filtering** only where needed
- Outperform traditional median filters at high noise densities

---

## 📊 PSNR Comparison Results

| Noise (%) | Peppers | Barbara | Cameraman | Baboon | Avg (Proposed) | Avg (Median) |
|-----------|---------|---------|-----------|--------|----------------|---------------|
|           | Median / Proposed | Median / Proposed | Median / Proposed | Median / Proposed |                |               |
| 30%       | 27.75 / 33.43 | 23.67 / 30.53 | 22.89 / 33.68 | 21.38 / 26.84 | **31.12**         | 23.92         |
| 50%       | 22.76 / 29.10 | 20.66 / 26.68 | 14.88 / 29.48 | 19.48 / 23.98 | **27.31**         | 19.44         |
| 70%       | 13.98 / 25.29 | 13.41 / 22.63 | 13.47 / 24.78 | 16.50 / 21.74 | **23.61**         | 14.34         |
| 90%       | 7.33 / 19.95 | 7.32 / 17.64 | 7.14 / 19.47 | 12.93 / 18.60 | **18.91**         | 8.68          |
| **Avg**   |             |               |               |                | **25.24**         | 16.60         |

> Result: The adaptive approach consistently improves PSNR by a wide margin, especially under high-noise conditions.

