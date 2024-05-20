close all;
clear ;
clc;
load('data21.mat');

X2D_100 = zeros(280,280);
% N = 300;
for j = 0:9
    for i = 0:9

    Z0 = randn(10,1); % Gaussian , mean 0 , covariance 1
    W1 = A_1 * Z0 + B_1;
    Z1 = max(W1,0);        % ReLU
    W2 = A_2 * Z1 + B_2;
    X = 1./(1 + exp(W2));  % Sigmoid
    
    X2D = reshape(X,28,28);
%     T = [eye(N) zeros(N,784-N)];
%     Y2D = T*X;
%     Y2D = reshape([Y2D;zeros(784-N,1)],28,28);
%     imshow(Y2D);
    X2D_100(28*j+1:28*j+28,28*i+1:28*i+28) = X2D;
%     imshow(X2D);

    end
end

imshow(X2D_100);

