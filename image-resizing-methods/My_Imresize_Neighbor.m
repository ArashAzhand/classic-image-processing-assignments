function Output_Image = My_Imresize_Neighbor(Input_Image, Resizing_Factor)
    [org_x, org_y, num_channels] = size(Input_Image);
    new_x = round(org_x * Resizing_Factor);
    new_y = round(org_y * Resizing_Factor);

    Output_Image = zeros(new_x, new_y, num_channels);

    for x = 1:new_x
        for y = 1:new_y
            for k=1:num_channels
                % convert to original axis
                % +0.5 is for using the center of the pixels for more accuracy
                % it was like this befor:
                % nearest_x = round((x - 0.5) / Resizing_Factor + 0.5);
                nearest_x = round((x ) / Resizing_Factor + 0.5);
                nearest_y = round((y ) / Resizing_Factor + 0.5);
                
                % prevent the output not to be in original range
                nearest_x = max(min(nearest_x, org_x), 1);
                nearest_y = max(min(nearest_y, org_y), 1);
    
                % Copy the color values from the nearest pixel
                
                Output_Image(x, y, k) = Input_Image(nearest_x, nearest_y, k);
            end
        end
    end
end
