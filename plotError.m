y = zeros(numel(18:2:62),1);

for i = 18:2:62
    target = strcat('gen00' , num2str(i));
    matFile = strcat(target, '.mat');
    cstFile = strcat(target, '.txt');
    disp(matFile)
    disp(cstFile)
    y((i - 18)/2 + 1) = errorBetweenCSTMATLAB( cstFile, matFile );
end
plot((0.18:0.02:0.62)*2, y)