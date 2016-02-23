%part 3 Edge detection
image = imread('lena_gray_512.tif');
[N,M] = size(image);
%add noise
sp_image = imnoise(image,'salt & pepper',0.15);
%add more noise
gaussian_image = imnoise(image,'gaussian',0,0.05);

sobel_mask_x = (1/8)*[-1 0 1;-2 0 2;-1 0 1];
sobel_mask_y = sobel_mask_x';


%% A)
% Horizontal
subplot(231)
imshow(image);
title('Original');

filtered_image = filter2(sobel_mask_x, image, 'same');
subplot(234);
original_x = mat2gray(abs(filtered_image));
imshow(original_x);
title('Horizontal Edge Detection');

subplot(232);
imshow(sp_image);
title('Salt & Pepper Noise');

filtered_image = filter2(sobel_mask_x, sp_image, 'same');
subplot(235);
sp_x = mat2gray(abs(filtered_image));
imshow(sp_x);
title('Horizontal Edge Detection');

subplot(233);
imshow(gaussian_image);
title('Gaussian Noise');

filtered_image = filter2(sobel_mask_x, gaussian_image, 'same');
subplot(236);
gaussian_x = mat2gray(abs(filtered_image));
imshow(gaussian_x);
title('Horizontal Edge Detection');

print('Sobel_horizontal','-dpng');

%Vertical

filtered_image = filter2(sobel_mask_y, image, 'same');
subplot(234);
original_y = mat2gray(abs(filtered_image));
imshow(original_y);
title('Vertical Edge Detection');

filtered_image = filter2(sobel_mask_y, sp_image, 'same');
subplot(235);
sp_y = mat2gray(abs(filtered_image));
imshow(sp_y);
title('Vertical Edge Detection');

filtered_image = filter2(sobel_mask_y, gaussian_image, 'same');
subplot(236);
gaussian_y = mat2gray(abs(filtered_image));
imshow(gaussian_y);
title('Vertical Edge Detection');

print('Sobel_vertical','-dpng');

%show together
subplot(234);
imshow(original_x + original_y);
title('Edge Detection');

subplot(235);
imshow(sp_x + sp_y);
title('Edge Detection');

subplot(236);
imshow(gaussian_x + gaussian_y);
title('Edge Detection');

print('Sobel_final','-dpng');
%% B)
% Edge detection using Matlab's edge command
original_edges = edge(image,'sobel');
subplot(234);
imshow(original_edges);
title('Matlab edges()');

sp_edges = edge(sp_image,'sobel');
subplot(235);
imshow(sp_edges);
title('Matlab edges()');

gaussian_edges = edge(gaussian_image,'sobel');
subplot(236);
imshow(gaussian_edges);
title('Matlab edges()');

print('Matlab_Sobel_edge_detection','-dpng');

%% C compare & contrast

%% D reduce affect of noise on output

H_LPF = createLPF(11,4,6);

G = filter2(H_LPF,sp_image,'same');
%G = medfilt2(G1,[5 5],'symmetric');
Gx = filter2(sobel_mask_x,G,'same');
Gy = filter2(sobel_mask_y,G,'same');
subplot(231);
imshow(sp_image);
title('Salt & Pepper Noise');
subplot(232);
imshow(mat2gray(G));
title('S&P After LPF');
subplot(233);
imshow(mat2gray(abs(Gx)+abs(Gy)));
title('LPF & Sobel');

G = filter2(H_LPF,gaussian_image,'same');
%G = medfilt2(G1,[5 5],'symmetric');
Gx = filter2(sobel_mask_x,G,'same');
Gy = filter2(sobel_mask_y,G,'same');
subplot(234);
imshow(gaussian_image);
title('Gaussian Noise');
subplot(235);
imshow(mat2gray(G));
title('Gaussian After LPF');
subplot(236);
imshow(mat2gray(abs(Gx)+abs(Gy)));
title('LPF + Sobel');
