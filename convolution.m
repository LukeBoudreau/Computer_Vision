function [ g ] = convolution( image, mask, i, j )
%CONVOLUTION Summary of this function goes here
%   INPUTS
%   image: the original image, assumed square
%   mask: the mask, assumed square
%   i,j: the row/column of point for convolution

    index = floor(length(mask)/2);
    new_value = 0.0;
    [mask_row, mask_col] = size(mask);
    N_mask = mask_row;
    M_col = mask_col;
    [N M] = size(image);
    
    for k = -index:index
       for l = -index:index
           cur_row = i-k;
           cur_col = j-l;
           if cur_row < 1 || cur_row > N || cur_col < 1 || cur_col > M
               point = 0;
           else
               point = cast(image(i-k,j-l),'double');
           end
           cur_mask = mask(mask_row,mask_col);
           new_value = new_value + (point*cur_mask);
           mask_col = mask_col - 1;
       end
       mask_col = M_col;
       mask_row = mask_row - 1;
    end
    
    g = new_value;
end

