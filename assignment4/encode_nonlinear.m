%{
CPSC 303 Assignment 4: Problem 5
Part (h): Image encoder with nonlinear quantization
Nicholas Hu
%}

function encode_nonlinear(infile, outfile, eta)
    img = double(imread(infile)) / 255;
    dim = size(img);
    
    C = dct2(img);
    
    crop = uint64(size(C) * eta);
    C = C(1:crop(1), 1:crop(2));
    
    C = log(1 + abs(C)) .* sign(C);
    minC = min(C(:));
    C = C - minC;
    maxC = max(C(:));
    C = uint8(round(255 * C / maxC, 0));

    save(outfile, 'dim', 'C', 'minC', 'maxC', '-v6');
end