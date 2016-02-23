%part 2 filtering a noisy image
%% A)
image = imread('lena_gray_512.tif');
[N,M] = size(image);
%add noise
sp_image = imnoise(image,'salt & pepper',0.15);
%add more noise
g_sigma = 0.05;
gaussian_image = imnoise(image,'gaussian',0,g_sigma);
subplot(221);
imshow(mat2gray(image));
title('Original');
subplot(222);
imshow(mat2gray(sp_image));
title('S & P Noise');
subplot(223);
imshow(mat2gray(gaussian_image));
title('Gaussian Noise');

%calculate variance FOR SNR.
image_variance = var(cast(image(:)','double'));
sp_noise = sp_image - image;
sp_noise_variance = var(cast(sp_noise(:)','double'));
gaussian_variance = g_sigma;

SNR_sp = 10*log10(image_variance/sp_variance);
SNR_gaussian = 10*log10(image_variance/gaussian_variance);

subplot(222);
xlabel(sprintf('SNR = %f', SNR_sp));
subplot(223);
xlabel(sprintf('SNR = %f', SNR_gaussian));
print('Noisy_images','-dpng');

%% B)

subplot(111);
%kernel = fspecial('gaussian',11,3.0);
kernel = createLPF(11,4,6);

filtered_image = filter2(kernel,sp_image,'same');
subplot(221);
imshow(mat2gray(filtered_image));
title('Salt and Pepper Noise with LPF');

subplot(223);
filtered_image = filter2(kernel,gaussian_image,'same');
imshow(mat2gray(filtered_image));
title('Gaussian Noise with LPF');

subplot(222);
filtered_image = medfilt2(sp_image,'symmetric');
imshow(mat2gray(filtered_image));
title('Salt and Pepper Noise with Median Filter');

subplot(224);
filtered_image = medfilt2(gaussian_image,'symmetric');
imshow(mat2gray(filtered_image));
title('Gaussian Noise with Median Filter');

print('LPF_median_filters','-dpng');

