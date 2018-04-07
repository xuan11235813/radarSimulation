function [normal, alpha, previous, direction] = findIndex( arrayOrigin, number )

direction = -1;
[height, width] = size(arrayOrigin);

if height >1 && width >1
    if numel(unique(arrayOrigin(:,1))) == 1
        % variance at different width
        direction  = 2;
    end
    if numel(unique(arrayOrigin(1,:))) == 1
        % variance at different height
        direction  = 1;
    end
end

minValue = min(arrayOrigin(:));
maxValue = max(arrayOrigin(:));

normal = 0;

previous = 1;
latter = 2;
if minValue <= number && maxValue >= number
    array = unique(arrayOrigin);
    flag = -1;
    
    for i = 1:numel(array)
        if flag == 1
            break;
        elseif flag == 0
            if array(i) >= number
                flag = 1;
                previous = i - 1;
                latter = i;
            end
        else
            if array(i) <= number
                flag = 0;
            end
        end
    end
    alpha = 1 - (number - array(previous))/(array(latter) - array(previous));
%     o1 = arrayOrigin == array(previous);
%     o2 = arrayOrigin == array(latter);
%     arrayOutput = ((o1 + o2) > 0);
    
else
    normal = 1;
    alpha = 0;
%     arrayOutput = -1;
end
