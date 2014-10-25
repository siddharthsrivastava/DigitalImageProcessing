function [] = FRI_D4_G15_Soumya_7( filename )

I = imread(filename);
figure; imshow(I); 
I_hsv = RGB2HSV(I);

[no_of_rows no_of_cols no_of_colors] = size(I);

I_new = I;

for i = 1:no_of_rows
    for j = 1:no_of_cols
        
        h = I_hsv(i,j,1);
        s = I_hsv(i,j,2);
        v = I_hsv(i,j,3);
        
        if(((s > 0.2)&&(h < 0.1)&&(v < .75))) 
            I_new(i,j,:) = I(i,j,:);
        else
            I_new(i,j,1) = 255;
            I_new(i,j,2) = 255;
            I_new(i,j,3) = 255;
        end

    end
end

figure; imshow(I_new);

M = csvread('info.csv');
[rows, cols] = size(M);

for i=1:rows
    
  x = M(i,1);
  y = M(i,2);
  width = M(i,3);
  height = M(i,4);
  
  limit = 5;
  
  for m = (y+limit):(y+height-limit)
     for n = (x+limit):(x+width-limit)
         I_new(m,n,:) = I(m,n,:);
     end
  end
  

end
figure, imshow(I_new);
imwrite(I_new, 'Demo4_d_res.jpg', 'jpg');

end

