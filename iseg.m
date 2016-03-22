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
% See lmeans.m

% DEBUG: Compare with Matlab's kmeans
%  [IDX, C] = kmeans(double(I(:)),k);
%  i_seg = reshape(IDX,[rows,cols]);
%  i_seg = i_seg./k;
%  i_seg = imadjust(i_seg,[min(i_seg(:)),max(i_seg(:))],[0.0;1.0]);
%  imshow(i_seg);
%  title(sprintf('Segmentation %d clusters',k));

%% C) Segmentation based on Intensity
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
%Perform custom implementation of Kmeans (Luke-means) on Intensity.
[IDX, C] = lmeans(I,k,30);
i_seg = IDX;
% Use Centroids for actual point values
i_seg(:,:) = C(IDX(:,:));
%Truncate to keep original values
imshow(uint8(i_seg));
title(sprintf('%d clusters Segmentation',k)); 
print(sprintf('kmeans seg %d',k),'-dpng');

%% D) Repeat with different values of K
%Again with small number of k
k = 2;
%Perform custom implementation of Kmeans (Luke-means)
[IDX, C] = lmeans(I,k,30);
i_seg = IDX;
% Use Centroids for actual point values
i_seg(:,:) = C(IDX(:,:));
%Truncate to keep original values
imshow(uint8(i_seg));
title(sprintf('%d clusters Segmentation',k));
print(sprintf('kmeans seg %d',k),'-dpng');

%Again with large number of k
k = 20;
%Perform custom implementation of Kmeans (Luke-means)
[IDX, C] = lmeans(I,k,30);
i_seg = IDX;
% Use Centroids for actual point values
i_seg(:,:) = C(IDX(:,:));
%Truncate to keep original values
imshow(uint8(i_seg));
title(sprintf('%d clusters Segmentation',k));
print(sprintf('kmeans seg %d',k),'-dpng');



%% E) Segmentation based on Color
k = 5;
[IDX, C] = lmeans(rgb,k,50);
i_seg = zeros(rows,cols,depth);
for i = 1:rows
    for j = 1:cols
        i_seg(i,j,:) = C(IDX(i,j),:);
    end
end

%Truncate to stay close to Centroid values.
imshow(uint8(i_seg));
title(sprintf('%d clusters Segmentation',k));
print(sprintf('Color kmeans seg %d',k),'-dpng');

%Again with small number of k
k = 2;
[IDX, C] = lmeans(rgb,k,50);
i_seg = zeros(rows,cols,depth);
for i = 1:rows
    for j = 1:cols
        i_seg(i,j,:) = C(IDX(i,j),:);
    end
end

%Truncate to stay close to Centroid values.
imshow(uint8(i_seg));
title(sprintf('%d clusters Segmentation',k));
print(sprintf('Color kmeans seg %d',k),'-dpng');

%Again with large number of k
k = 20;
[IDX, C] = lmeans(rgb,k,50);
i_seg = zeros(rows,cols,depth);
for i = 1:rows
    for j = 1:cols
        i_seg(i,j,:) = C(IDX(i,j),:);
    end
end

%Truncate to stay close to Centroid values.
imshow(uint8(i_seg));
title(sprintf('%d clusters Segmentation',k));
print(sprintf('Color kmeans seg %d',k),'-dpng');