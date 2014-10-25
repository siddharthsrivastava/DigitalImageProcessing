function [filtered_image] = DoLowPassFreqFiltering(image, freq)

I = image;
%figure(1), imshow(I)
filtered_image = image;
[rows cols colors]=size(I);

p=rows/2;
q=cols/2;

filter_freq = freq;

for color =1:colors

    a = I(:,:, color);
    fft_trans=fft2(a);
    fft_shift=fftshift(fft_trans);

    for i=1:rows
        for j=1:cols
        distance=sqrt((i-p)^2+(j-q)^2);
        low_pass_filter(i,j)=exp(-(distance)^2/(2*(filter_freq^2)));
        end
    end


    filtered_a=fft_shift.*low_pass_filter;
    ifft_shift=ifftshift(filtered_a);
    ifft_trans=abs(ifft2(ifft_shift));
    filtered_image(:,:,color)=ifft_trans;

end

