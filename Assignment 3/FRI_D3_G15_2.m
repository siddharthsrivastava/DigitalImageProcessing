
%% count car using windsheilds
function [ count_a ] = FRI_D3_G15_Soumya_2(  )

img = imread('FRI_D3_G15_Soumya_5.jpg') ;
%imtool(img);
 thresh_range   = 15 ;
 thresh_noBlack = 70 ;
 thresh_noWhite = 200 ;
 rgb_mean  = mean(img, 3) ;
 rgb_range = range(img, 3) ;
 id = rgb_range < thresh_range & ...
      rgb_mean  > thresh_noBlack & ...
      rgb_mean  < thresh_noWhite ;
 r = img(:,:,1) ; g = img(:,:,2) ; b = img(:,:,3) ;
 r(id) = 0 ; g(id) = 0 ; b(id) = 255 ;
r(~id) = 0;g(~id) = 0; b(~id) = 0;
 img_windshields = cat(3, r, g, b) ;
 
 
 sedisk = strel('disk',4);
 
  im2 = imerode(b, sedisk);
  img_windshields = cat(3,r,g,im2);
 %imshow(img_windshields);
  I = rgb2gray(img_windshields);
  %Otsu's Threshold
  l = graythresh(I);
  I = im2bw(I,l);
  
  I = imfill(I, 'holes');
  I = imerode(I, sedisk);
 labeledImage = bwlabel(I, 8); 
 blobMeasurements = regionprops(labeledImage, I, 'all'); 
count = [blobMeasurements(:).Area]; 
s = count > 10;
count1 = count(s);
%numberOfBlobs = size(blobMeasurements, 1)
count_a = size(count1,2);
%  imshow(I);
  %imshow(img_windshields);
 
  %imshow(img) ;
%  subplot(2, 1, 2) ;

%imshow(I1);
%imshow(img_windshields) ;

