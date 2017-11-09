function value = calculateCurrent( n, unitL, I0, k, incidentAngle)
value = zeros(n,1);
lambda = 2*pi/k;
if incidentAngle == 0
    value = ones(n,1)*I0;
else
    lambdaNew = lambda/sin(incidentAngle);
    for i = 1:n
       angle = (i - 1) * unitL / lambdaNew;
       angle = angle - floor(angle);
       current = exp(1j * angle) * I0;
       value(i) = current;
    end
end

