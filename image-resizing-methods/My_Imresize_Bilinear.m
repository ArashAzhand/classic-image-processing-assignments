function Output_Image = My_Imresize_Bilinear(Input_Image, Resizing_Factor)
    [org_x, org_y, num_channels] = size(Input_Image);
    new_x = org_x * Resizing_Factor;
    new_y = org_y * Resizing_Factor;

    Output_Image = zeros(new_x, new_y, num_channels);
    
    x_ratio = org_x / new_x;
    y_ratio = org_y / new_y;
    for i=1:new_x
        for j=1:new_y
            for k=1:num_channels
                
                new_x_in_org = (i ) * x_ratio + 0.5;
                new_y_in_org = (j ) * y_ratio + 0.5;
    
                % Find the coordinates of the four neighbors
                x1 = floor(new_x_in_org);
                x2 = ceil(new_x_in_org);
                y1 = floor(new_y_in_org);
                y2 = ceil(new_y_in_org);
    
                % Ensure the coordinates are within the image boundaries
                x1 = max(min(x1, org_x), 1);
                x2 = max(min(x2, org_x), 1);
                y1 = max(min(y1, org_y), 1);
                y2 = max(min(y2, org_y), 1);
    
                dx = new_x_in_org - x1;
                dy = new_y_in_org - y1;
    
                f1 = (1 - dx) * Input_Image(x1, y1) + dx * Input_Image(x2, y1);
                f2 = (1 - dx) * Input_Image(x1, y2) + dx * Input_Image(x2, y2);
    
                e = (1 - dy) * f1 + dy * f2;
    
                Output_Image(i, j, k) = e;
            end
        end
    end
end

            