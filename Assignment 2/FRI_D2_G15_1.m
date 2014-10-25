clearvars
close all
clc
warning off

I = imread('FRI_D2_G15_Soumya_5.jpg');
figure, imshow(I);

[imageRows, imageCols, noOfColors] = size(I);

gray_I = rgb2gray(I);
% figure,imshow(gray_I);

gray_med_I = medfilt2(gray_I, [3 3]);

I_hist = histeq(gray_med_I);

edge_I = edge(I_hist,'sobel'); %finding edges 
% figure,imshow(edge_I);

filter_freq = 60;
[rows cols] = size(edge_I);
p=rows/2;
q=cols/2;
fft_trans=fft2(edge_I);
fft_shift=fftshift(fft_trans);

for i=1:rows
    for j=1:cols
    distance=sqrt((i-p)^2+(j-q)^2);
    low_pass_filter(i,j)=exp(-(distance)^2/(2*(filter_freq^2)));
    end
end

filtered_I = zeros(rows, cols);

filtered_a=fft_shift.*low_pass_filter;
ifft_shift=ifftshift(filtered_a);
ifft_trans=abs(ifft2(ifft_shift));
filtered_I(:,:)=ifft_trans;

% figure, imshow(filtered_I)

BW = im2bw(filtered_I, 0.1);
% figure,imshow(BW);

se = strel('line',4,1);
dilatedImg = imdilate(BW,se);
figure,imshow(dilatedImg);
% imwrite(dilatedImg, 'dilated_2d.jpg', 'jpg');

[imx,imy]=size(dilatedImg)


n1 = FRI_D2_G15_Soumya_2(dilatedImg, 4, 500, 500, 7000, 300, 150);
original = n1;
% binaryFilledImage = imfill(n1,'holes');
filled = imfill(n1, 'holes');
holes = filled & ~original;
bigholes = bwareaopen(holes, 700);
smallholes = holes & ~bigholes;
binaryFilledImage = original | smallholes;

size(I)
size(binaryFilledImage)
% figure,imshow(binaryFilledImage);
% imwrite(n1, 'result_2c.png', 'png');

se = strel('line',2,0);
binaryFilledImage = imdilate(binaryFilledImage,se);
masked_image = FRI_D2_G15_Soumya_3(binaryFilledImage, 1, 20);
masked_image = FRI_D2_G15_Soumya_3(masked_image, 2, 20);

se = strel('line',6,1);
masked_image = imdilate(masked_image,se);
masked_image = FRI_D2_G15_Soumya_2(masked_image, 4, 50, 900, 5000, 300, 65);

finalImage = I;
for i=1:imageRows
   for j=1:imageCols
       if(masked_image(i,j)==0)
           finalImage(i,j,1) = 0;
           finalImage(i,j,2) = 0;
           finalImage(i,j,3) = 0;
       end
   end
end



figure,imshow(finalImage);
% imwrite(finalImage, 'car1.jpg', 'jpg');


