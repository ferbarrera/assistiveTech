function [ index ] = anav_getBin( bin, value )

index = 1;

while true    
    
    if (numel(bin) == index)
        % value is not within any bin
        index = -1;
        break;
    end

    if ((bin(index) <= value) && (value < bin(index+1)))
        break;
    end

    index = index+1;
    
end

end

