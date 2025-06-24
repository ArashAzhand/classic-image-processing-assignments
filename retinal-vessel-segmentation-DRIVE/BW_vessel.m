function output = BW_vessel(image, mask)
    

    G_channel = im2double(image(:, :, 2)); % working with G_channel is better
    G_channel_rev_log = exp(G_channel) - 1; % apply inverse logarithm

    image_filtered = imbilatfilt(G_channel_rev_log); % maintain vessels and reduce noise
    

    high_pass = image_filtered - G_channel_rev_log;
    new = G_channel_rev_log + high_pass; % apply unsharp masking

    
    image_enhanced = adapthisteq(new); % enhance the image

   
    level = adaptthresh(image_enhanced, 0.7); % using adaptive threshold
    bw_vessels = image_enhanced < level;

    se = strel("disk", 1);
    mask = imerode(mask, se); % reduce the white circle around the retinal

    
    output = im2double(bw_vessels) .* im2double(mask);
end


