%part 1: Filtering in the Space Domain
% A) Image Filter using Matlab commands
image = imread('lena_gray_512.tif');
subplot(2,1,1);

imshow(image);
title('Original Image');
N = 11;
filter_kernel = fspecial('gaussian',N,5.0);
image_filtered = cast(round(filter2(filter_kernel,image,'full')),'uint8');
subplot(2,1,2);
imshow(image_filtered);
title('Gaussian Filter');
print('Gaussian_before_after','-dpng');
subplot(1,1,1);
%frequency response of filter
colormap(jet(64));
freqz2(filter_kernel,N,N); axis([-1 1 -1 1 0 1])

title('Frequency Response of Gaussian Filter');
print('Freq_Gaussian_Filter','-dpng');

%try filtering 5 times
for i = 1:5
    temp = cast(round(filter2(filter_kernel,image_filtered,'full')),'uint8');
    image_filtered = temp;
end

imshow(image_filtered);
title('5 times Gaussian Filter');
print('Gaussian_filter_5_times','-dpng');

for i = 1:5
    temp = cast(round(filter2(filter_kernel,image_filtered,'full')),'uint8');
    image_filtered = temp;
end

imshow(image_filtered);
title('10 Times Gaussian Filter');
print('Gaussian_filter_10_times','-dpng');

for i = 1:10
    temp = cast(round(filter2(filter_kernel,image_filtered,'full')),'uint8');
    image_filtered = temp;
end

imshow(image_filtered);
title('20 Times Gaussian Filter');
print('Gaussian_filter_20_times','-dpng');
%Image will eventually look like completely black after many iterations

% B) Image Filtering with my own code
filter_kernel
HPF = 1 - filter_kernel;
HPF
colormap(jet(64));
freqz2(HPF,N,N);
title('Frequency Response of High Pass Filter');
print('Freq_HPF','-dpng');

pause
image_filtered = cast(round(filter2(HPF,image,'full')),'uint8');
imshow(image);