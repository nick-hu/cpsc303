%{
CPSC 303 Assignment 4: Problem 5
Part (h): Image decoder with nonlinear quantization
Nicholas Hu
%}

function decode_nonlinear(infile, outfile)
    load(infile);
    
    D = zeros(dim);
    
    C = (double(C) * maxC / 255) + minC;
    C = sign(C) .* ((exp(C) .^ sign(C)) - 1);
    D(1:size(C, 1), 1:size(C, 2)) = C;
    
    imwrite(uint8(255 * idct2(D)), outfile);
end