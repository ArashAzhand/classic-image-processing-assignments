clc;clear;close all;

img = (imread('Cells.tif'));

write_to_excel(img, 'cell_propertie.xlsx');