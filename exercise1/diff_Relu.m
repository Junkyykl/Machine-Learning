function y = diff_Relu(u)
    y = zeros(1,length(u));
    for i = 1:length(u)
        if u(i) > 0
            y(i) = 1;
        elseif u(i) < 1
            y(i) = 0;
        end
    end
    y = y';
end