function Output_Image = My_Imresize_Euclidean_Distance(Input_Image, Resizing_Factor)
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
                
                % neighbors
                top_left = Input_Image(x1,y1,k);
                top_right = Input_Image(x2,y1,k);
                down_left = Input_Image(x1,y2,k);
                down_right = Input_Image(x2,y2,k);

                % Eucledian
                top_left_dis = sqrt((i - x1)^2 + (j - y1)^2);
                top_right_dis = sqrt((i - x2)^2 + (j - y1)^2);
                down_left_dis = sqrt((i - x1)^2 + (j - y2)^2);
                down_right_dis = sqrt((i - x2)^2 + (j - y2)^2);
                
                % some pixels might be exactly in org pixels' position
                % and if not, we should reverse the impact of distance
                if top_left_dis == 0
                    weight_top_left = 1;
                else
                    weight_top_left = 1 / top_left_dis;
                end
                if top_right_dis == 0
                    weight_top_right = 1;
                else
                    weight_top_right = 1 / top_right_dis;
                end
                if down_left_dis == 0
                    weight_down_left = 1;
                else
                    weight_down_left = 1 / down_left_dis;
                end
                if down_right_dis == 0
                    weight_down_right = 1;
                else
                    weight_down_right = 1 / down_right_dis;
                end


                % normalizing the wights
                weight_sum = weight_top_left + weight_top_right + weight_down_left + weight_down_right;
                weight_top_left = weight_top_left/weight_sum;
                weight_top_right = weight_top_right/weight_sum;
                weight_down_left = weight_down_left/weight_sum;
                weight_down_right = weight_down_right/weight_sum;

                e = (weight_top_left*top_left)+(weight_top_right*top_right)+(weight_down_left*down_left)+(weight_down_right*down_right);
              
                Output_Image(i, j, k) = e;
            end
        end
    end
end
