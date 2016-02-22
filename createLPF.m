function [ H ] = createLPF( N, D_0, n )
%CREATELPF Creates a Butterworth LPF.

s = N;
H = zeros(s);
k_0 = floor(s/2);
l_0 = floor(s/2);

for k = 1:s
    for l = 1:s
        diff = ((k-k_0)^2+(l-l_0)^2)/(D_0^2);
        H(k,l) = 1/(1+(diff)^n);
    end
end

%Normalize
H = H./(N^2);
end

