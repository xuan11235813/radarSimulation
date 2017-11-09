r = 5;
x = -r:0.07:r;
y = -r:0.07:r;
[xMesh, yMesh] = meshgrid(x,y);
S = (xMesh.^2 + yMesh.^2 < r^2);
N = numel(S(:));
disp(N)
X = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

p = 1;

for i  = 1:numel(x)
    for j = 1:numel(y)
      if (x(i)^2 + y(j)^2) < r^2
          x0 = x(i);
          y0 = y(j);
          z0 = sqrt(r^2 - x0^2 - y0^2);
          theta = acos(z0/r);
          phi = atan2(y0, x0);
          I0 = 0.5;
          k = 200;
          l = 0.01;
          [Er, ETheta, HPhi] = hertzianDipoleElectromag(I0, r, theta, k, l);
          r1 = sqrt(abs(Er)^2 + abs(ETheta)^2);
          z1 = r1 * cos(theta);
          x1 = r1 * sin(theta) * cos(phi);
          y1 = r1 * sin(theta) * sin(phi);
          X(p) = x1;
          Y(p) = y1;
          Z(p) = z1;
          p = p + 1;
      end
    end
end

plot3(X,Y,Z)
axis equal
