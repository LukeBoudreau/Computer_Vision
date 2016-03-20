%part 1 Color Image Segmentation using k-means
%% A)
rgb = imread('Color_Images\Color_Images\218.jpg');
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

%% B)
