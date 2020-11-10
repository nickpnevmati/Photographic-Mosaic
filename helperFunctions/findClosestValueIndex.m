function [index] = findClosestValueIndex(array, val)

closest = abs(array(1) - val);
index = 1;
for i = 1 : length(array)
    temp = abs(array(i) - val);
    if(temp < closest)
        index = i;
        closest = temp;
    end
end
        