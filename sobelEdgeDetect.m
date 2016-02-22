%part 3 Edge detection
%%A
image = imread('lena_gray_512.tif');
[N,M] = size(image);
%add noise
sp_image = imnoise(image,'salt & pepper',0.15);
%add more noise
gaussian_image = imnoise(image,'gaussian',0,0.05);

