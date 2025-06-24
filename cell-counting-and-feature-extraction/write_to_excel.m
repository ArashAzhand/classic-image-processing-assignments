function write_to_excel(img, FileName)    
    L = Cell_Counter(img);
    number_cell = max(L(:))
    
    areas = zeros(number_cell, 1);
    mean_brightnesses = zeros(number_cell, 1);
    for i=1:number_cell
        cell_mask = L == i;
        areas(i) = sum(cell_mask(:));
        cell_in_org = cell_mask .* double(img);
        mean_brightnesses(i) = mean(cell_in_org(cell_mask));
        imshow(cell_in_org, [])
        pause(0.05)
    end

    T = table((1:number_cell)', areas, mean_brightnesses,'VariableNames', {'CellLabel', 'Area', 'MeanBrightness'});

    if isfile(FileName)
        delete(FileName);
    end

    writetable(T, FileName);

end