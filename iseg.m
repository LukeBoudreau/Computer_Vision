%part 1 Color Image Segmentation using k-means
%% A)
rgb = imread('Color_Images\Color_Images\290.jpg');
[rows cols depth] = size(rgb);
r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);

subplot(131);
histogram(r(:)');
title('Red Channel');

subplot(132);
histogram(g(:)');
title('Green Channel');

subplot(133);
histogram(b(:)');
title('Blue Channel');
print('Histograms','-dpng');
subplot(111);
r_2 = histogram(r(:)','BinWidth',2);
r_2 = r_2.Values;
g_2 = histogram(g(:)','BinWidth',2);
g_2 = g_2.Values;
b_2 = histogram(b(:)','BinWidth',2);
b_2 = b_2.Values;

h_concatenated = [r_2 g_2 b_2];
bar(h_concatenated);
title('Concatenated Histogram');
print('Concatenated Histogram','-dpng');

%% B) K-means
c1 = 64;
c2 = 191;

%% C)
subplot(131);
imshow(rgb);
title('Original');

subplot(132);
I = rgb2gray(rgb);
imshow(I);
title('GrayScale');

subplot(133);
%Define number of clusters
k = 5;
[IDX, C] = lmeans(double(I(:)),k,20);
i_seg = reshape(IDX,[rows,cols]);
i_seg = i_seg./k;
i_seg = imadjust(i_seg,[min(i_seg(:)),max(i_seg(:))],[0.0;1.0]);
imshow(i_seg);
title(sprintf('Segmentation %d clusters',k));

%Compare with Matlab's kmeans
 [IDX, C] = kmeans(double(I(:)),k);
 i_seg = reshape(IDX,[rows,cols]);
 i_seg = i_seg./k;
 i_seg = imadjust(i_seg,[min(i_seg(:)),max(i_seg(:))],[0.0;1.0]);
 imshow(i_seg);
 title(sprintf('Segmentation %d clusters',k));

%save
print('k-means-seg-intensity','-dpng');
