%{
CPSC 303 Assignment 4: Problem 5
Lossy Image Compression
Nicholas Hu
%}

clear variables; clc; format;

%% Part (a): face1.bmp is already a (1024x1024) greyscale image

img = imread('face1.bmp');

%% Part (b)

figure;
subplot(2, 1, 1);
colormap(gray); % No colour printer :(
imagesc(log(abs(fft2(img))));
colorbar;
title('FFT');

%% Part (c)

subplot(2, 1, 2);
imagesc(log(abs(dct2(img))));
colorbar;
title('DCT');

%% Part (f)

eta = [0.05, 0.1, 0.5, 1];
orig = dir('face2.bmp');

figure;
for i = 1:length(eta);
    encode('face2.bmp', 'face2_encoded.mat', eta(i));
    decode('face2_encoded.mat', 'face2_decoded.bmp');
    
    subplot(2, 2, i);
    imshow(imread('face2_decoded.bmp'));
    enc = dir('face2_encoded.mat');
    title(['$\eta = ', num2str(eta(i)), '$ (compression ratio: ', ...
           num2str(enc.bytes / orig.bytes), ')'], 'Interpreter', 'latex');
end

%% Part (h)

figure;
for i = 1:length(eta);
    encode_nonlinear('face2.bmp', 'face2_encoded.mat', eta(i));
    decode_nonlinear('face2_encoded.mat', 'face2_decoded.bmp');
    
    subplot(2, 2, i);
    imshow(imread('face2_decoded.bmp'));
    enc = dir('face2_encoded.mat');
    title(['$\eta = ', num2str(eta(i)), '$ (compression ratio: ', ...
           num2str(enc.bytes / orig.bytes), ')'], 'Interpreter', 'latex');
end

%% Part (i)

eta_min = 0.18;

encode_nonlinear('face2.bmp', 'face2_encoded.mat', eta_min);
decode_nonlinear('face2_encoded.mat', 'face2_decoded.bmp');

orig = imread('face2.bmp');
dec = imread('face2_decoded.bmp');

dist = sqrt(sum((dec(:) - orig(:)) .^ 2));

figure;
subplot(2, 2, 1);
imshow(orig);
title('Original image (face)', 'Interpreter', 'latex');

subplot(2, 2, 2);
imshow(dec);
title(['$\eta = ', num2str(eta_min), '$ ($L_2$ distance: ', ...
       num2str(dist), ')'], 'Interpreter', 'latex');
   
%% Part (j)

orig = uint8(randi([0, 255], size(orig)));
imwrite(orig, 'noise.bmp');

encode_nonlinear('noise.bmp', 'noise_encoded.mat', eta_min);
decode_nonlinear('noise_encoded.mat', 'noise_decoded.bmp');

dec = imread('noise_decoded.bmp');

dist = sqrt(sum((dec(:) - orig(:)) .^ 2));

subplot(2, 2, 3);
imshow(orig);
title('Original image (noise)', 'Interpreter', 'latex');

subplot(2, 2, 4);
imshow(dec);
title(['$\eta = ', num2str(eta_min), '$ ($L_2$ distance: ', ...
       num2str(dist), ')'], 'Interpreter', 'latex');