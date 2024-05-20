function y = pdf_estim(x,Y,N,h)
    y = zeros(1,length(x));
    for i = 1:length(x)
        for j = 1:N
            y(i) = y(i) + Kernel(x(i)-Y(j),h);            
        end
        y(i) = y(i)/N;
    end
end