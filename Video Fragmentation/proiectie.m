function [A] = proiectie(A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[n,m] = size(A);

for (i=1:n)
    for(j=1:m)
    
    if(A(i,j) < 0)
        A(i,j) = 0;
    end
    
    end

end