%% count car using windsheilds
function [ totalCount ] = FRI_D3_G15_Soumya_3(  )

img = imread('FRI_D3_G15_Soumya_6.jpg') ;
%imtool(img);

 thresh_range   = 20 ;
 thresh_noBlack = 50;
 thresh_noWhite = 120;
 rgb_mean  = mean(img, 3) ;
 rgb_range = range(img, 3) ;
 id = rgb_range < thresh_range & ...
      rgb_mean  > thresh_noBlack & ...
      rgb_mean  < thresh_noWhite ;
 r = img(:,:,1) ; g = img(:,:,2) ; b = img(:,:,3) ;
 r(id) = 0 ; g(id) = 0 ; b(id) = 255 ;
%r(~id) = 0;g(~id) = 0; b(~id) = 0;
 img_windshields = cat(3, r, g, b) ;
 
 
 sedisk = strel('disk',4);
 
  im2 = imopen(b, sedisk);
  img_windshields = cat(3,r,g,im2);
  %imshow(img_windshields);
 %imshow(img_windshields);
  I = rgb2gray(img_windshields);
  %Otsu's Threshold
  l = graythresh(I);
  I = im2bw(I,l);
  
  %I = imfill(I, 'holes');
  %I = imerode(I, sedisk);
 labeledImage = bwlabel(I, 8); 
 blobMeasurements = regionprops(labeledImage, I, 'all'); 
count = [blobMeasurements(:).Area]; 
s = count > 50 & count < 200;
% auto and dark car count
count1 = count(s);

%setting for light colored vehicles
thresh_range   = 20 ;
thresh_noBlack = 200;
thresh_noWhite = 255;

rgb_mean  = mean(img, 3) ;
 rgb_range = range(img, 3) ;
 id = rgb_range < thresh_range & ...
      rgb_mean  > thresh_noBlack & ...
      rgb_mean  < thresh_noWhite ;
 r = img(:,:,1) ; g = img(:,:,2) ; b = img(:,:,3) ;
 r(id) = 0 ; g(id) = 0 ; b(id) = 255 ;
%r(~id) = 0;g(~id) = 0; b(~id) = 0;
 img_windshields = cat(3, r, g, b) ;
 
 
 sedisk = strel('disk',4);
 
  im2 = imdilate(b, sedisk);
  img_windshields = cat(3,r,g,im2);
  %imshow(img_windshields);
 %imshow(img_windshields);
  I = rgb2gray(img_windshields);
  %Otsu's Threshold
  l = graythresh(I);
  I = im2bw(I,l);
  
  %I = imfill(I, 'holes');
  %I = imerode(I, sedisk);
 labeledImage = bwlabel(I, 8); 
 blobMeasurements = regionprops(labeledImage, I, 'all'); 
count = [blobMeasurements(:).Area]; 
s = count > 80 & count < 100;
% auto and dark car count
count2 = count(s);

%numberOfBlobs = size(blobMeasurements, 1)

 % imshow(I);
  %imshow(img_windshields);
 
  %imshow(img) ;
%  subplot(2, 1, 2) ;

%imshow(I1);
%imshow(I) ;
totalCount = size(count1,2) + size(count2,2);
