function [best_filt, final_a, final_b, max_psnr] = optimize_my_filter(image, noise_image)
    max_psnr = 0;
    final_a = 0;
    final_b = 0;
    max_iterations = 20;

    for filt_size = 1:10
        a = filt_size;
        b = filt_size;

        myfilt = my_filter(noise_image, [a b]);

        iteration_count = 0;
        while (any(myfilt(:) == 0) || any(myfilt(:) == 1)) && (iteration_count < max_iterations)
            myfilt = my_filter(myfilt, [a b]);
            iteration_count = iteration_count + 1;
        end

        tmp_psnr = psnr(image, myfilt);
        if tmp_psnr > max_psnr
            max_psnr = tmp_psnr;
            final_a = a;
            final_b = b;
        end
    end

    best_filt = my_filter(noise_image, [final_a final_b]);
    iteration_count = 0;
    while (any(best_filt(:) == 0) || any(best_filt(:) == 1)) && (iteration_count < max_iterations)
        best_filt = my_filter(best_filt, [final_a final_b]);
        iteration_count = iteration_count + 1;
    end
end
