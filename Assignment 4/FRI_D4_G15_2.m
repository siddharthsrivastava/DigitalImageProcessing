function [] = FRI_D4_G15_Soumya_2( filename )

    img = imread(filename);
    figure; imshow(img);
    
    gray_img=rgb2gray(img);

    [THETAS] = FRI_D4_G15_Soumya_3(gray_img)

    LENGHTS = zeros(1, length(THETAS));
    for i = 1:length(THETAS)
        THETA = THETAS(i);
        LENGHTS(1,i) = FRI_D4_G15_Soumya_4(gray_img, THETA, 0, 0);
    end

    LENGHTS



    PSF = fspecial('gaussian', LENGHTS(4), THETAS(4));
    deconvolved_img = DECONVLUCY(img, PSF, 7);
    figure; imshow(deconvolved_img);
    
    imwrite(deconvolved_img, 'Demo4_b_res.jpg', 'jpg');
    
    
end

