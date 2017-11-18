function disk = generateDisk( ...
    pattern, ...
    unitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle)

num = floor(length/unitLength);
disk = zeros(num,1);
sparkSize = floor(sparkLength/unitLength);
sparkGlobal = (dutyCycle * length / sparkLength);
sparkNum = sparkGlobal;
semiPara = 0.2;
switch(pattern)
    case('conductor')
        for i = 1:num
            disk(i) = 1;
        end
    case('regularConductSpark')
        step = floor(num/sparkNum);
        for i = 1:sparkNum
            interval = (i-1) * step +1 : (i-1) * step + sparkSize;
            disk(interval) = 1;
        end
    case('randomConductSpark')
        iter = 0;
        while( sparkNum >0 && iter < 1000 )
            startSpark = floor(rand() * num) + 1;
            endSpark = startSpark + sparkSize -1;
            if endSpark <= num
                value = sum(disk(startSpark:endSpark));
                if value == 0
                    sparkNum = sparkNum -1;
                    disk(startSpark:endSpark) = 1;
                end
            end
            iter = iter +1;
        end
        if iter >= 1000
            fprintf('not enough spark inserted, inserted %d', sparkGlobal - sparkNum)
        end
    case('regularSemiConductSpark')
        step = floor(num/sparkNum);
        for i = 1:sparkNum
            interval = (i-1) * step +1 : (i-1) * step + sparkSize;
            disk(interval) = 1;
        end
        disk(disk == 0) = semiPara;
    case('randomSemiConductSpark')
        iter = 0;
        while( sparkNum >0 && iter < 1000 )
            startSpark = floor(rand() * num) + 1;
            endSpark = startSpark + sparkSize -1;
            if endSpark <= num
                value = sum(disk(startSpark:endSpark));
                if value == 0
                    sparkNum = sparkNum -1;
                    disk(startSpark:endSpark) = 1;
                end
            end
            iter = iter +1;
        end
        if iter >= 1000
            fprintf('not enough spark inserted, inserted %d', sparkGlobal - sparkNum)
        end
        disk(disk == 0) = semiPara;
end

