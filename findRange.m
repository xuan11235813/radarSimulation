function [heightStart, heightEnd, widthStart, widthEnd] = findRange(M)

[height, width] = size(M);

heightTestArray = sum(M,2);
widthTestArray = sum(M,1);

heightStart = 0;
heightEnd = 0;
widthStart = 0;
widthEnd = 0;

for i = 1:height
    if heightTestArray(i) ~= 0
        heightStart = i;
        break;
    end
end

for i = height:-1:1
    if heightTestArray(i) ~= 0
        heightEnd = i;
        break;
    end
end

for i = 1:width
    if widthTestArray(i) ~= 0
        widthStart = i;
        break;
    end
end

for i = width:-1:1
    if widthTestArray(i) ~= 0
        widthEnd = i;
        break;
    end
end
