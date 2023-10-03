function [X] = stfunction(X, param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[n,m] = size(X);

for i=1:n
    for j=1:m
        
        if (X(i,j) > param )
             X(i,j) =X(i,j) - param;
         end

         if ( abs( X(i,j) ) <= param )
             X(i,j) = 0 ;
         end

         if (X(i,j) < -param )
             X(i,j) =X(i,j) + param;
         end

    end 
end
end