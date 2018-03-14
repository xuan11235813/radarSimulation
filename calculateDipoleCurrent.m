function current = calculateDipoleCurrent( N, unitL, I0, k)

current = zeros(N,1);
length = N * unitL;
for i = 1:N
    coord = (i - 0.5) * unitL - length/2;
    if coord >= 0
        current(i) = I0 * exp(1i *(pi/2 - (k *(length/2 - coord))));
    else
        current(i) = I0 * exp(1i *(pi/2 - (k *(length/2 + coord))));
    end
    
end
current  = real(current);