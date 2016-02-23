% Magnitude and phase of the 2-D DFT
%% A)
image_girl = cast(imread('lena_gray_512.tif'),'double');
image_monkey = cast(imread('mandril_gray.tif'),'double');

% image_girl
subplot(231);
imshow(mat2gray(image_girl));
title('Original');

F = fft2(image_girl);
F = fftshift(F);
F_mag = abs(F);
F_phase = angle(F);

subplot(232);
imshow(log(F_mag),[]);
title('Magnitude of DFT');
subplot(233);
imshow(F_phase,[]);
title('Phase of DFT');

% image_monkey
subplot(234);
imshow(mat2gray(image_monkey));
title('Original');

F2 = fft2(image_monkey);
F2 = fftshift(F2);
F2_mag = abs(F2);
F2_phase = angle(F2);

subplot(235);
imshow(log(F2_mag),[]);
title('Magnitude of DFT');
subplot(236);
imshow(F2_phase,[]);
title('Phase of DFT');

print('Magnitude_phase_real_images','-dpng');
%% B)
% Reconstruct girl
close all;
subplot(221);
imshow(mat2gray(image_girl));
title('original');
subplot(223);
girl_reconstructed = F2_mag.*exp(j*F_phase);
girl_reconstructed = ifft2(girl_reconstructed);

MSE = (1/M*N)*(sum(sum((image_girl-abs(girl_reconstructed)).^2)));
imshow(mat2gray(abs(girl_reconstructed)));

%reconstruct monkey
subplot(222);
imshow(mat2gray(image_monkey));
title('original');
subplot(224);
monkey_reconstructed = F_mag.*exp(j*F2_phase);
monkey_reconstructed = ifft2(monkey_reconstructed);

MSE = (1/M*N)*(sum(sum((image_monkey-abs(monkey_reconstructed)).^2)));
imshow(mat2gray(abs(monkey_reconstructed)));
print('Swapping_magnitude_real_images','-dpng');

