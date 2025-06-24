function filter_image = my_filter(image, filter_size)
    [rows, cols] = size(image);
    filter_image = image;
    a = filter_size(1);
    b = filter_size(2);
    padded_image = padarray(image, [a b],"replicate");
    neighbors = zeros(power(a*2+1, 2), 1);
    for x=1:rows
        for y=1:cols
            if image(x, y) == 0 || image(x, y) == 1
                neighbor_cnt = 1; 
                for i=-a:a
                    for j=-b:b
                        neighbors(neighbor_cnt) = padded_image(x+a+i, y+b+j);
                        neighbor_cnt = neighbor_cnt + 1;
                    end
                end
                filter_image(x, y) = median(neighbors);
            end
        end
    end  
end