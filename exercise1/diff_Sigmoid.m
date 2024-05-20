function y = diff_Sigmoid(u)
    y = zeros(1,length(u));
    for i = 1:length(u)
        y(i) = ( 1 - Sigmoid(u(i)) ) * Sigmoid(u(i));
    end
    y = y';
end