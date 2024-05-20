close all;
clear;
clc;
load("data32.mat");

X = [stars;circles];

N = length(X);
N1 = length(stars);
N2 = length(circles);

h = 10; % kernel h parameter
l = 0.1; %lamda in equation

K = zeros(N);

for i = 1:N
    for j = 1:N
        K(i,j) = Mercer(X(i,:),X(j,:),h);
    end
end

I = eye(42);
y1 = ones(N1,1);
y2 = -ones(N2,1);
Y = [y1;y2];

A = (K + I*l);
B = Y;
C = mldivide(A,B);

                     % Plotting of border
Xmin = min(X(:,1));
Xmax = max(X(:,1));
Ymin = min(X(:,2));
Ymax = max(X(:,2));

x1 = -1.105: 0.005 : 1.09;
y1tst = Ymin : 0.005 : Ymax;

% finding of y1 in y1tst that Phi(x) = 0 (border)
y1 = zeros(1,length(x1));

for i = 1:length(x1)
    smallestKm=inf;
    for j = 1:length(y1tst)        
        Km = zeros(1,N);
        for k = 1:N
        Km(k) = Mercer([x1(i) y1tst(j)],X(k,:),h);
        end
        if smallestKm > abs(Km*C)
           smallestKm = abs(Km*C);
           y1(i) = y1tst(j);
        end
    end
end
        
figure;
scatter(circles(:,1),circles(:,2),'r','o');
hold on;
scatter(stars(:,1),stars(:,2),'b','*');   
plot(x1,y1);
hold off;



