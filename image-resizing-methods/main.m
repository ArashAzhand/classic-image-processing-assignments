clc;clear;close all;

folder_path = '.\';

files = dir(fullfile(folder_path, '*.png'));
files_tif = dir(fullfile(folder_path, '*.tif'));
files = [files; files_tif];
files = {files.name};

for i = 1:length(files)
    file = files{i};
    if startsWith(file, 'LR_')
        hr_image_name = strcat(file(4:end));
        if ismember(hr_image_name, files)
            lr_image = im2double(imread(fullfile(folder_path, file)));
            % using my method to resize
            resized_image = My_Imresize_MyMethod(lr_image, 2, 2);
            hr_image = im2double(imread(fullfile(folder_path, hr_image_name)));
            
            current_psnr = psnr(im2double(resized_image), im2double(hr_image));
            fprintf('PSNR between %s and %s: %.4f \n', file, hr_image_name, current_psnr);
        end
    end
end
