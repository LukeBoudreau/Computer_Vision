function [ ratio ] = calcIntersection( Hm, Hi )
%CALCINTERSECTION Calculates the intersection between
% two image histograms.
% 

len = min(length(Hm),length(Hi));
total = 0;
model_sum = 0;
for i = 1:len
    intersection = min(Hm(i),Hi(i));
    total = total + intersection;
    model_sum = model_sum + Hm(i);
end

ratio = total/model_sum;

end