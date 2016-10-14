function [array] = AssignValue(array, value)
    n = length(array);

    for i=1:n
        array(i,:) = value;
    end
end