function current = calculateDipoleCurrent( length, k, I0, num )

unitLength = length/num;
current = zeros(floor(num/2)*2,1);

N = numel(current);
length = N * unitLength;
for i = 1:N
    
end