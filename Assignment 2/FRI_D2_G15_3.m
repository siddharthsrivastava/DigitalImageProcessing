function [ masked_image ] = MaskImage(image, mask_type, mask_size)

%     figure, imshow(image);
    [rows, cols, colors] = size(image);
    masked_image = image;
    if(mask_type == 1)
        
        for i=1:cols
            for j = 1:(rows-mask_size-1)
                temp = image(j:j+mask_size-1,i);
                if(temp(1,1) == 0) && (temp(mask_size,1) == 0)
                    masked_image(j:j+mask_size-1, i) = 0;
                end
            end
        end

    end
    
    if(mask_type == 2)
        
        for i=1:rows
            for j = 1:(cols-mask_size-1)
                temp = image(i,j:j+mask_size-1);
                if(temp(1,1) == 0) && (temp(1,mask_size) == 0)
                    masked_image(i,j:j+mask_size-1) = 0;
                end
            end
        end

    end
    
%     figure, imshow(masked_image);

end

