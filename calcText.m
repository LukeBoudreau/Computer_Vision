function [ feature_vector ] = calcText( image )
%calcText - Calculate the 
L5 = [1 4 6 4 1];
E5 = [-1 -2 0 2 1];
S5 = [-1 0 2 0 -1];
R5 = [1 -4 6 -4 1];

feature_vector = zeros([1 9]);

% L5E5, E5L5
f = mean2(abs(filter2(L5'*E5,image,'valid')))+mean2(abs(filter2(E5'*L5,image,'valid')))/2;
feature_vector(1) = f;

% L5R5, R5L5
f = mean2(abs(filter2(L5'*R5,image,'valid')))+mean2(abs(filter2(R5'*L5,image,'valid')))/2;
feature_vector(2) = f;

% L5S5, S5L5
f = mean2(abs(filter2(L5'*S5,image,'valid')))+mean2(abs(filter2(S5'*L5,image,'valid')))/2;
feature_vector(3) = f;

% E5R5, R5E5
f = mean2(abs(filter2(E5'*R5,image,'valid')))+mean2(abs(filter2(R5'*E5,image,'valid')))/2;
feature_vector(4) = f;

% E5S5, S5E5
f = mean2(abs(filter2(E5'*S5,image,'valid')))+mean2(abs(filter2(S5'*E5,image,'valid')))/2;
feature_vector(5) = f;

% S5R5, R5S5
f = mean2(abs(filter2(S5'*R5,image,'valid')))+mean2(abs(filter2(R5'*S5,image,'valid')))/2;
feature_vector(6) = f;

%E5E5
f = mean2(abs(filter2(E5'*E5,image,'valid')));
feature_vector(7) = f;

%R5R5
f = mean2(abs(filter2(R5'*R5,image,'valid')));
feature_vector(8) = f;

%S5S5
f = mean2(abs(filter2(S5'*S5,image,'valid')));
feature_vector(9) = f;
end

