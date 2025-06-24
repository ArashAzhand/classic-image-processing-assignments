clc; clear; close all;

path_image = 'Training/images';
path_mask = 'Training/mask';
path_manual = 'Training/1st_manual';

image_dir = dir(fullfile(path_image, '*.tif'));
mask_dir = dir(fullfile(path_mask, '*.gif'));
manual_dir = dir(fullfile(path_manual, '*.gif'));

sum_sensitivity = 0;
sum_specificity = 0;
sum_accuracy = 0;

results = table('Size', [length(image_dir), 4], 'VariableTypes', {'string', 'double', 'double', 'double'}, ...
                'VariableNames', {'Image', 'Sensitivity', 'Specificity', 'Accuracy'});


for i = 1:length(image_dir)
    image_name = image_dir(i).name;
    mask_name = mask_dir(i).name;
    manual_name = manual_dir(i).name;

    image = imread(fullfile(path_image, image_name));
    mask = imread(fullfile(path_mask, mask_name));
    manual = imread(fullfile(path_manual, manual_name));
    

    % ------------------------
    BW_image = BW_vessel(image, mask);
    imshow([im2double(manual) BW_image]);
    %---------------------------
    title("Image " + int2str(i));


    manual_masked = manual & mask;


    
    retinal_pixels = mask > 0; % this ensures that only retinal pixels are going to be compared
    sensitivity = my_sensitivity(BW_image(retinal_pixels), manual_masked(retinal_pixels));
    specificity = my_specificity(BW_image(retinal_pixels), manual_masked(retinal_pixels));
    accuracy = my_accuracy(BW_image(retinal_pixels), manual_masked(retinal_pixels));

    sum_sensitivity = sum_sensitivity + sensitivity;
    sum_specificity = sum_specificity + specificity;
    sum_accuracy = sum_accuracy + accuracy;

    fprintf('Image %d:\n', i);
    fprintf('  Sensitivity: %.2f%%\n', sensitivity);
    fprintf('  Specificity: %.2f%%\n', specificity);
    fprintf('  Accuracy: %.2f%%\n', accuracy);
    fprintf('\n');
    results.Image(i) = string(image_name);
    results.Sensitivity(i) = sensitivity;
    results.Specificity(i) = specificity;
    results.Accuracy(i) = accuracy;
    pause(0.5);
end

mean_sensitivity = sum_sensitivity / length(image_dir);
mean_specificity = sum_specificity / length(image_dir);
mean_accuracy = sum_accuracy / length(image_dir);
fprintf('Overal:\n');
fprintf('  mean Sensitivity: %.2f%%\n', mean_sensitivity);
fprintf('  mean Specifisity: %.2f%%\n', mean_specificity);
fprintf('  mean Accuracy: %.2f%%\n', mean_accuracy);

mean_row = table("Overall", mean_sensitivity, mean_specificity, mean_accuracy, 'VariableNames', results.Properties.VariableNames);
results = [results; mean_row];
disp(results);



function output = my_sensitivity(my_image, org_image)
    TP = sum((my_image == 1) & (org_image == 1), 'all');
    FN = sum((my_image == 0) & (org_image == 1), 'all');
    
    if TP + FN == 0
        output = NaN;
    else
        output = 100 * (TP / (TP + FN));
    end
end

function output = my_specificity(my_image, org_image)
    TN = sum((my_image == 0) & (org_image == 0), 'all');
    FP = sum((my_image == 1) & (org_image == 0), 'all');
    
    if TN + FP == 0
        output = NaN;
    else
        output = 100 * (TN / (TN + FP));
    end
end

function output = my_accuracy(my_image, org_image)
    TP = sum((my_image == 1) & (org_image == 1), 'all');
    TN = sum((my_image == 0) & (org_image == 0), 'all');
    FP = sum((my_image == 1) & (org_image == 0), 'all');
    FN = sum((my_image == 0) & (org_image == 1), 'all');
    
    if TP + TN + FP + FN == 0
        output = NaN;
    else
        output = 100 * ((TP + TN) / (TP + TN + FP + FN));
    end
end
