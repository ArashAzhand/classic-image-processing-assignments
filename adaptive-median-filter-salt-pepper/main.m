clc; close all; clear;

image = im2double(imread("Cameraman.bmp"));
noise_image = imnoise(image, "salt & pepper", 0.9);

[best_filt, final_a, final_b, max_psnr] = optimize_my_filter(image, noise_image);

%-----
mat_med = medfilt2(noise_image, [2*final_a+1 2*final_b+1]);

imshow([noise_image mat_med best_filt], []);

disp(['PSNR of medfilt2: ', num2str(psnr(image, mat_med))]);
disp(['PSNR of my filter: ', num2str(max_psnr)]);
