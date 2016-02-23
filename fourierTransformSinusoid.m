% Part 4 Fourier Transform of a Sinudoid
%%A) Sine wave
N = 128;
image = zeros(N);
x = linspace(-pi,pi,N);

y = sin(x*8);
for i = 1:N
    %for j = 1:N
    image(i,:) = y(:);
    %image(i,j) = sin(2*pi*((j)/N)*8);
    %end
end

subplot(131);
imshow(mat2gray(image));
title('2D image');

%fft
F_image = fft2(image);
subplot(132);
imshow(abs(F_image));
title('FFT');

% recenter origin
subplot(133);
imshow(log(abs(fftshift(F_image))));
title('FFTSHIFT');

print('FFT_of_sinusoid','-dpng');

%%B)
x = linspace(-pi,pi,N);

y = sin(x*8+(pi/2));
for i = 1:N
    %for j = 1:N
    image(i,:) = y(:);
    %image(i,j) = sin(2*pi*((j)/N)*8);
    %end
end

subplot(131);
imshow(mat2gray(image));
title('2D image');

%fft
F_image = fft2(image);
subplot(132);
imshow(abs(F_image));
title('FFT');

% recenter origin
subplot(133);
imshow(log(abs(fftshift(F_image))));
title('FFTSHIFT');

print('FFT_sinusoid_non_itegral','-dpng');

% And Again
x = linspace(-pi,pi,N);

y = sin(x*8+(.789*pi));
for i = 1:N
    %for j = 1:N
    image(i,:) = y(:);
    %image(i,j) = sin(2*pi*((j)/N)*8);
    %end
end

subplot(131);
imshow(mat2gray(image));
title('2D image');

%fft
F_image = fft2(image);
subplot(132);
imshow(abs(F_image));
title('FFT');

% recenter origin
subplot(133);
imshow(log(abs(fftshift(F_image))));
title('FFTSHIFT');

print('FFT_sinusoid_non_itegral_2','-dpng');