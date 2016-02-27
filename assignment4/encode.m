%{
CPSC 303 Assignment 4: Problem 5
Part (d): Image encoder
Nicholas Hu
%}

function encode(infile, outfile, eta)
    % (i) Image reading
    img = double(imread(infile)) / 255;
    dim = size(img);
    
    % (ii) 2D DCT
    C = dct2(img);
    
    % (iii) Information loss
    crop = uint64(size(C) * eta);
    C = C(1:crop(1), 1:crop(2));
    
    % (iv) Linear quantization
    minC = min(C(:));
    C = C - minC;
    
    maxC = max(C(:));
    C = uint8(round(255 * C / maxC, 0));

    % (v) Save dimensions of image, coefficients, and scaling factors
    save(outfile, 'dim', 'C', 'minC', 'maxC', '-v6');
end