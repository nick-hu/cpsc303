%{
CPSC 303 Assignment 4: Problem 4
Information in Phases and Magnitudes of Fourier Coefficients
Nicholas Hu
%}

clear variables; clc; format;

% face1.bmp and face2.bmp are both 1024x1024 greyscale images
img1 = imread('face1.bmp');
img2 = imread('face2.bmp');
F1 = fft2(img1);
F2 = fft2(img2);

F1_swap = zeros(size(F1));
F2_swap = zeros(size(F2));

for y = 1:size(F1, 1)
    for x = 1:size(F1, 2)
        % The coefficients of F1_swap will have the phases of the
        % coefficients of F2
        F1_swap(x, y) = abs(F1(x, y)) * exp(1i * angle(F2(x, y)));
        
        % The coefficients of F2_swap will have the phases of the
        % coefficients of F1
        F2_swap(x, y) = abs(F2(x, y)) * exp(1i * angle(F1(x, y)));
    end
end

% Real casting is needed as the IFFT sometimes produces complex numbers
% with very small imaginary parts (owing to numerical errors)

img1_swap = uint8(real(ifft2(F1_swap)));
img2_swap = uint8(real(ifft2(F2_swap)));
imwrite(img1_swap, 'face1_swap.bmp');
imwrite(img2_swap, 'face2_swap.bmp');

subplot(2, 2, 1);
imshow(img1);
title('face1.bmp');
subplot(2, 2, 2);
imshow(img2);
title('face2.bmp');
subplot(2, 2, 3);
imshow(img1_swap);
title('face1\_swap.bmp');
subplot(2, 2, 4);
imshow(img2_swap);
title('face2\_swap.bmp');
