%part 1: Filtering in the Space Domain
%% A) Image Filter using Matlab commands
image = imread('lena_gray_512.tif');
subplot(2,1,1);

imshow(image);
title('Original Image');
N = 5;
filter_kernel = fspecial('gaussian',N,5.0);
image_filtered = cast(round(filter2(filter_kernel,image,'full')),'uint8');
subplot(2,1,2);
imshow(image_filtered);
title('Gaussian Filter');
print('Gaussian_before_after','-dpng');
subplot(1,1,1);
%frequency response of filter
colormap(jet(64));
freqz2(filter_kernel); axis([-1 1 -1 1 -1 1])

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

%% B) Image Filtering with my own code
HPF = (1/25)*[-1 -1 -1 -1 -1; -1 -1 -1 -1 -1;-1 -1 24 -1 -1;-1 -1 -1 -1 -1;-1 -1 -1 -1 -1];

%HPF = [.1 0 .1 0 .1;0 .1 0 .1 0;.1 0 .1 0 .1;0 .1 0 .1 0; .1 0 .1 0 .1];
HPF = filter_kernel;

colormap(jet(64));
freqz2(HPF,[10 10]); axis([-1 1 -1 1 0 1])
title('Frequency Response of High Pass Filter');
print('Freq_HPF','-dpng');

pixels = length(image);
image_filtered = zeros(pixels);
for i = 1:pixels
    for j = 1:pixels
        image_filtered(i,j) = convolution(image,HPF,i,j);
    end
end

figure;
subplot(221);
imshow(image);
title('original');
subplot(222);
imshow(mat2gray(image_filtered));
title('Luke shitty convo');

subplot(223);
imshow(mat2gray(filter2(HPF,image,'same')));
title('Matlab filter2');