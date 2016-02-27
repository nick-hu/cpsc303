%{
CPSC 303 Assignment 4: Problem 5
Part (e): Image decoder
Nicholas Hu
%}

function decode(infile, outfile)
    load(infile);
    
    D = zeros(dim);
    
    C = (double(C) * maxC / 255) + minC;
    D(1:size(C, 1), 1:size(C, 2)) = C;
    
    imwrite(uint8(255 * idct2(D)), outfile);
end