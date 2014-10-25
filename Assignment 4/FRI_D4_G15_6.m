function [ ] = FRI_D4_G15_Soumya_6( filename, mask_length )

    I = imread(filename);
    figure; imshow(I); 

    I_filtered = I;


    [rows cols] = size(I);
    madian_index = ceil((mask_length^2/2));

    % pad the image with zeros on all sides
    pad_size = floor(mask_length/2);
    I_temp = zeros(rows+pad_size, cols+pad_size);
    [rows_temp, cols_temp] = size(I_temp);
    for i = 1:rows
       for j = 1:cols
           I_temp(pad_size+i, pad_size+j) = I(i, j);
       end
    end


    for i = 1:(rows_temp-mask_length+1)
       for j = 1:(cols_temp-mask_length+1)

           %take the mask
           mask = I_temp(i:i+mask_length-1, j:j+mask_length-1);

           %convert the 2d mask to 1d array
           mask_1d = reshape(mask, 1, numel(mask));

           %sort the elements
           mask_1d_sorted = sort(mask_1d);

           %find the median value
           median = mask_1d_sorted(madian_index);

           %replace with the median value
           I_filtered(i, j) = median;

       end
    end

    figure; imshow(I_filtered);
    imwrite(I_filtered, 'Demo4_c_res.jpg', 'jpg');

end

