function y = Mercer(x,y,h)
    y = exp(-1/h * ( (x(1)-y(1))^2 + (x(2)-y(2))^2 ) );
end