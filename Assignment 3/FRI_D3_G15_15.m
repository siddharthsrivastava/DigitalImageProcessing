function [ col_a ] = FRI_D3_G15_Soumya_15(imgname )

I1 = imread(imgname);
I = rgb2gray(I1);
taggedCars = zeros([size(I,1) size(I,2) 3 1], class(I));
[L, num] = bwlabel(I);

darkCarValue = 150;
noDarkCars = imextendedmax(I, darkCarValue);
%imshow(I);
%imshow(noDarkCars);
sedisk = strel('disk',2);
noSmallStructures = imopen(noDarkCars, sedisk);

 noSmallStructures = bwareaopen(noSmallStructures, 150);
 labeledImage = bwlabel(noSmallStructures, 8); 
 blobMeasurements = regionprops(labeledImage, I, 'all'); 
count = [blobMeasurements(:).Area]; 
keys = [];
values = [];
red = 0;
blue = 0;
green = 0;
black = 0;
white = 0;
yellow = 0;
col_a = [];
for i = 1:length(blobMeasurements)
    x_coordinate = blobMeasurements(i).Centroid(1);
    y_coordinate = blobMeasurements(i).Centroid(2);  
    col_a = [col_a,impixel(I1, x_coordinate, y_coordinate)];
%     
%     if(P(1) > 180 && P(2) > 180 && P(3) < 80)
%         yellow = yellow + 1;
%     elseif ( P(1) > 180 && P(2) < 80 &&  P(3) < 80)
%             red = red + 1;
%     elseif(P(1) > 220 && P(2) > 220 && P(3) > 220)
%         white = white + 1;
%     elseif(P(1) < 40 && P(2) < 40 && P(3) < 40)
%         black = black + 1;
%     elseif(P(1) < 80 && P(2) > 180 && P(3) < 80)
%         green = green + 1;
%     elseif(P(1) < 80 && P(2) < 80 && P(3) > 180)
%         blue = blue + 1;       
%     end
            
 end


% taggedCars(:,:,:,k) = I1;
 %imhist(I);
imshow(noSmallStructures);
% stats = regionprops(noSmallStructures, {'Centroid','Area'});
%     if ~isempty([stats.Area])
%         areaArray = [stats.Area];
%         [junk,idx] = max(areaArray);
%         c = stats(idx).Centroid;
%         c = floor(fliplr(c));
%         width = 2;
%         row = c(1)-width:c(1)+width;
%         col = c(2)-width:c(2)+width;
%         taggedCars(row,col,1,k) = 255;
%         taggedCars(row,col,2,k) = 0;
%         taggedCars(row,col,3,k) = 0;
%     end
%     imshow(taggedCars);
% 
