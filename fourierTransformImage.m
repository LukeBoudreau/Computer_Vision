% 2-D Fourier Transform of a Real Image
%% Part A)
image = imread('lena_gray_512.tif');
% image = imread('mandril_gray.tif');
[N,M] = size(image);

subplot(141);
imshow(image);
title('original');

F = fft2(image);
subplot(142);
imshow(abs(F),[0 255]);
title('FFT2');

%Shift origin
F = fftshift(F);
F = abs(F);
subplot(143);
imshow(F,[0 255]);
title('FFT2shift');

%add log
subplot(144);
imshow(log(F),[]);
title('FFT2shit & log');

print('FFT2_image_variations','-dpng');

%% B)
F = fft2(image);
image_2 = ifft2(F);
image = cast(image,'double');
subplot(111);

MSE = 0.0;
MSE = (1/M*N)*(sum(sum((image-abs(image_2)).^2)));

%% C)
close all;
F = fft2(image);


Fp = fftshift(F);
image_2 = ifft2(Fp);
Fp = abs(Fp);

subplot(231);
imshow(log(Fp),[]);
title('DFT');
MSE_1 = (1/M*N)*(sum(sum((image-abs(image_2)).^2)));
xlabel(sprintf('MSE = %0.2e',MSE_1));

subplot(234);
imshow(mat2gray(abs(image_2)));
title('Reconstructed Image');

%N/4

F = fft2(image);
Fp = fftshift(F);

[r c] = meshgrid(1:N);
C = sqrt((r-(N/2)).^2+(c-(M/2)).^2)<=N/4;
Fp = Fp.*C;
image_2 = ifft2(Fp);

subplot(232);
Fp = abs(Fp);
imshow(log(Fp),[]);
title('DFT with N/4');

MSE_2 = (1/M*N)*(sum(sum((image-abs(image_2)).^2)));
xlabel(sprintf('MSE = %0.2e',MSE_2));
subplot(235);
imshow(mat2gray(abs(image_2)));
title('Reconstructed Image');

%N/8
F = fft2(image);
Fp = fftshift(F);

[r c] = meshgrid(1:N);
C = sqrt((r-(N/2)).^2+(c-(M/2)).^2)<=N/8;
Fp = Fp.*C;
image_2 = ifft2(Fp);

subplot(233);
Fp = abs(Fp);
imshow(log(Fp),[]);
title('DFT with N/8');

MSE_3 = (1/M*N)*(sum(sum((image-abs(image_2)).^2)));
xlabel(sprintf('MSE = %0.2e',MSE_3));
subplot(236);
imshow(mat2gray(abs(image_2)));
title('Reconstructed Image');

print('Removing_freq_1','-dpng');

%N/16
close all;
F = fft2(image);
Fp = fftshift(F);

[r c] = meshgrid(1:N);
C = sqrt((r-(N/2)).^2+(c-(M/2)).^2)<=N/16;
Fp = Fp.*C;
image_2 = ifft2(Fp);

subplot(221);
Fp = abs(Fp);
imshow(log(Fp),[]);
title('DFT with N/16');

MSE_4 = (1/M*N)*(sum(sum((image-abs(image_2)).^2)));
xlabel(sprintf('MSE = %0.2e',MSE_4));
subplot(223);
imshow(mat2gray(abs(image_2)));
title('Reconstructed Image');

%N/32
F = fft2(image);
Fp = fftshift(F);

[r c] = meshgrid(1:N);
C = sqrt((r-(N/2)).^2+(c-(M/2)).^2)<=N/32;
Fp = Fp.*C;
image_2 = ifft2(Fp);

subplot(222);
Fp = abs(Fp);
imshow(log(Fp),[]);
title('DFT with N/32');

MSE_5 = (1/M*N)*(sum(sum((image-abs(image_2)).^2)));
xlabel(sprintf('MSE = %0.2e',MSE_5));
subplot(224);
imshow(mat2gray(abs(image_2)));
title('Reconstructed Image');

print('Removing_freq_2','-dpng');

MSE = [MSE_1 MSE_2 MSE_3 MSE_4 MSE_5];
MSEx =[N N/4 N/8 N/16 N/32];
subplot(111);
plot(MSEx,MSE);
title('MSE vs. Radius');
ylabel('Error');

print('MSE_plot','-dpng');