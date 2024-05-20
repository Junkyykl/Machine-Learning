function y = Kernel(x,h)
    y = 1/sqrt(2*pi*h) * exp((-1/(2*h))*x^2);
end