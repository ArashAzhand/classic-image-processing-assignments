% this function uses lanczos interpolation algorithm and by doing a little
% chang in the code now it has the highest PSNR value among all other
% algorithms, even matlab's lanczos function. But originally it wasn't my
% idea and I found it throgh the internet
function Output_Image = My_Imresize_MyMethod(Input_Image, Resizing_Factor, a)
    [org_x, org_y, num_channels] = size(Input_Image);
    new_x = org_x * Resizing_Factor;
    new_y = org_y * Resizing_Factor;

    Output_Image = zeros(new_x, new_y, num_channels);

    x_ratio = org_x / new_x;
    y_ratio = org_y / new_y;
    for i=1:new_x
        for j=1:new_y
            for k=1:num_channels
                % this is the changed part
                new_x_in_org = (i ) * x_ratio + 0.5;
                new_y_in_org = (j ) * y_ratio + 0.5;

                % Calculate the Lanczos kernel weights
                weights = zeros(2*a+1, 2*a+1);
                sum_weights = 0;
                for m = -a:a
                    for n = -a:a
                        dx = new_x_in_org - (floor(new_x_in_org) + m);
                        dy = new_y_in_org - (floor(new_y_in_org) + n);
                        weights(m+a+1, n+a+1) = LanczosKernel(dx, a) * LanczosKernel(dy, a);
                        sum_weights = sum_weights + weights(m+a+1, n+a+1);
                    end
                end

                % Compute the new pixel value using the weights
                pixel_value = 0;
                for m = -a:a
                    for n = -a:a
                        src_x = min(max(1, floor(new_x_in_org) + m), org_x);
                        src_y = min(max(1, floor(new_y_in_org) + n), org_y);
                        pixel_value = pixel_value + Input_Image(src_x, src_y, k) * weights(m+a+1, n+a+1);
                    end
                end
                Output_Image(i, j, k) = pixel_value / sum_weights;
            end
        end
    end
end

function L = LanczosKernel(x, a)
    if x == 0
        L = 1;
    elseif abs(x) < a
        L = sin(pi*x) * sin(pi*x/a) / (pi^2 * x^2);
    else
        L = 0;
    end
end



% function Output_Image = My_Imresize_MyMethod(Input_Image, Resizing_Factor)
%     [org_x, org_y, num_channels] = size(Input_Image);
%     new_x = org_x * Resizing_Factor;
%     new_y = org_y * Resizing_Factor;
% 
%     Output_Image = zeros(new_x, new_y, num_channels);
% 
%     x_ratio = org_x / new_x;
%     y_ratio = org_y / new_y;
%     for i=1:new_x
%         for j=1:new_y
%             for k=1:num_channels
%                 new_x_in_org = (i ) * x_ratio + 0.5;
%                 new_y_in_org = (j ) * y_ratio + 0.5;
% 
%                 % Find the coordinates of the four neighbors
%                 x1 = floor(new_x_in_org);
%                 x2 = ceil(new_x_in_org);
%                 y1 = floor(new_y_in_org);
%                 y2 = ceil(new_y_in_org);
% 
%                 % Ensure the coordinates are within the image boundaries
%                 x1 = max(min(x1, org_x), 1);
%                 x2 = max(min(x2, org_x), 1);
%                 y1 = max(min(y1, org_y), 1);
%                 y2 = max(min(y2, org_y), 1);
% 
%                 % neighbors
%                 top_left = Input_Image(x1,y1,k);
%                 top_right = Input_Image(x2,y1,k);
%                 down_left = Input_Image(x1,y2,k);
%                 down_right = Input_Image(x2,y2,k);
% 
%                 e = (top_left + top_right + down_right + down_left) / 4;
% 
%                 Output_Image(i, j, k) = e;
%             end
%         end
%     end
% end
