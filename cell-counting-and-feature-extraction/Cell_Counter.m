function label_image = Cell_Counter(img)
    thresh = multithresh(img, 2);
    BW = img > thresh(1);
    BW(end, :) = 0;
    SE = strel('disk', 2);
    BW = imclose(BW, SE);

    imshow(BW)
    pause(4);

    [row, col] = size(BW);
    label_image = zeros(row, col);
    cell_label = 0;

    for i = 1:row
        for j = 1:col
            if BW(i, j) == 1 && label_image(i, j) == 0
                cell_label = cell_label + 1;
                label_image = labeling_cells(BW, label_image, i, j, cell_label);
            end
        end
    end
end

function label_image = labeling_cells(BW_image, label_image, x, y, label)
    [rows, cols] = size(BW_image);

    if x > 0 && x <= rows && y > 0 && y <= cols && BW_image(x, y) == 1 && label_image(x, y) == 0
        label_image(x, y) = label;

        label_image = labeling_cells(BW_image, label_image, x-1, y-1, label);
        label_image = labeling_cells(BW_image, label_image, x-1, y, label);
        label_image = labeling_cells(BW_image, label_image, x-1, y+1, label);
        label_image = labeling_cells(BW_image, label_image, x+1, y-1, label);
        label_image = labeling_cells(BW_image, label_image, x+1, y, label);
        label_image = labeling_cells(BW_image, label_image, x+1, y+1, label);
        label_image = labeling_cells(BW_image, label_image, x, y-1, label);
        label_image = labeling_cells(BW_image, label_image, x, y+1, label);
    end
end

% using stack to label the cells
% stack = [x, y];
% while ~isempty(stack)
%     curr_x = stack(end, 1);
%     curr_y = stack(end, 2);
%     stack(end,:) = [];
% 
%     if curr_x > 0 && curr_x <= rows && curr_y > 0 && curr_y <= cols && BW_image(curr_x, curr_y) == 1 && label_image(curr_x, curr_y) == 0
%         label_image(curr_x, curr_y) = label;
% 
%         neighbors = [
%             curr_x - 1, curr_y;
%             curr_x + 1, curr_y;
%             curr_x, curr_y - 1;
%             curr_x, curr_y + 1;
%             curr_x - 1, curr_y - 1;
%             curr_x - 1, curr_y + 1;
%             curr_x + 1, curr_y - 1;
%             curr_x + 1, curr_y + 1;
%         ];
% 
%         for k = 1:size(neighbors, 1)
%             nx = neighbors(k, 1);
%             ny = neighbors(k, 2);
%             if nx > 0 && nx <= rows && ny > 0 && ny <= cols && BW_image(nx, ny) == 1 && label_image(nx, ny) == 0
%                 stack = [stack; nx, ny];
%             end
%         end
%     end
% end