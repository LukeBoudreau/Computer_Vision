function [ g ] = convolution( image, mask, i, j )
%CONVOLUTION Summary of this function goes here
%   INPUTS
%   image: the original image, assumed square
%   mask: the mask, assumed square
%   i,j: the row/column of point for convolution

    index = floor(length(mask)/2);
    new_value = 0;
    mask_row = 5;
    mask_col = 5;
    
    
    for k = -index:index
       for l = -index:index
           point = 0;
           if i-k < 1 || i-k > length(image) || j-l < 1 || j-l > length(image)
               point = 0;
           else
               point = image(i-k,j-l);
           end
           new_value = new_value + (point*mask(mask_row,mask_col));
           mask_col = mask_col - 1;
       end
       mask_col = 5;
       mask_row = mask_row - 1;
    end
    
    g = new_value;
end

