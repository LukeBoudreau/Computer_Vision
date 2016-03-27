function [ distance ] = calcCHI( hi, hj)
%CALCCHI calculate the CHI square distance between 9 dimensional texture
% features.

sum = 0;
for m = 1:9
    top = (hi(m)-hj(m))^2;
    bot = hi(m) + hj(m);
    sum = sum + (top/bot);
end
sum = sum / 2;
distance = sum;
end

