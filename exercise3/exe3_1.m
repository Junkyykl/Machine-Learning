close all;
clear;
clc;

N = 1000;
Y = rand(N,1);

x = -8:0.01:8;

figure;
hold on;
for h = [0.1 0.01 0.001]
    plot(x,pdf_estim(x,Y,N,h));
end
hold off;
legend('h=0.1','h=0.01','h=0.001');


figure;
hold on;
for h = [0.0001 0.00001]
    plot(x,pdf_estim(x,Y,N,h));
end
hold off;
legend('h=0.0001','h=0.00001');

