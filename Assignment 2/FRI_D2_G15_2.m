function [ output_image ] = GetConnectedComponents( input_image, no_of_connected_comp, least_number_of_comp, min_connected_comp, max_connected_comp, max_width, max_height)

[imx,imy]=size(input_image);

L = bwlabel(input_image, no_of_connected_comp);% Calculating connected components
output_image=zeros(imx,imy); 
count = 0;
for z = 1:least_number_of_comp
    [r,c] = find(L==z);
    rc = [r c];
    [sx sy]=size(rc);
    
    if ((sx > min_connected_comp) && (sx < max_connected_comp))
        noOfWhitePixels = 0;
        count = count + 1;
        x2=[];
        y2=[];
        for i=1:sx

            x1=rc(i,1);
            y1=rc(i,2);
            
            x2(i) = x1;
            y2(i) = y1;
            
            noOfWhitePixels = noOfWhitePixels + 1;
            
        end  
        
        
        height = length(unique(x2));
        width = length(unique(y2));
        val = (width/height);
        if(((width/height) < 4) && ((width/height) >1) && (width < max_width) && (height < max_height))
            
            if(noOfWhitePixels > (0.2*(width*height)))
                for k=1:length(x2)
                    output_image(x2(k),y2(k))=255;
                end
            end
            
        end   
%      figure,imshow(n1);
        
    end
    
end

end

