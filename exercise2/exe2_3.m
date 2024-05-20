close all;
clear ;
clc;
load('data21.mat');
load('data23.mat');

N = 49; %proccesed image's number of pixel (7x7resolution)
% Modeling of the Trasformation Array (T)
T = zeros(49,784);
Tdiag = zeros(7,112);
count = 0;

for i = 1:7
    for j = 0:3
        for k = 1+count:4+count
            Tdiag(i,j*28+k) = 1/16;
        end     
    end
    count = k;  
end

for i = 0:6
    
    T(i*7+1 :(i+1)*7 , i*112+1 :(i+1)*112) = Tdiag;

end

% % Test to confirm that the Trasnformation Array is correct.
% 
% % X_transformed = T*X_ideal;
% % X_transformed_2D = reshape(X_transformed,7,7);
% % X_transformed_2D = kron(X_transformed_2D,ones(4,4));
% % figure;
% % imshow(X_transformed_2D);

n = 4; % number of X_n's collumn(image) that is used
X_ideal = X_i(:,n);
X_ideal_2D = reshape(X_ideal,28,28);
% figure;
% imshow(X_ideal_2D);

X_given = X_n(:,n);
X_given_2D = reshape(X_given,7,7);
X_given_2D = kron(X_given_2D,ones(4,4));
% figure;
% imshow(X_given_2D);



% Gradient Descent's Parameters
m = 1e-2; % step-size
L = 0.1; % smoothing factor
C = 1e-20; % a really small number to avoid devision with 0
iter = 2*1e3;


Best_Cost = Inf(1,iter);

for j = 1:10

    Cost = zeros(1,iter);
    
    Z0 = randn(10,1); % Gaussian input , mean 0 , covariance 1

    for i = 1:iter
        Cost1 = 0;
        Cost2 = 0;
        norm2 = 0;
        
        W1 = A_1 * Z0 + B_1;
        Z1 = max(W1,0);        % ReLU
        W2 = A_2 * Z1 + B_2;
        X = 1./(1 + exp(W2)); % Sigmoid given
        
        X_gan_tranformed = T*X;

        % calculation of main cost
        
        for k = 1:N
            norm2 = norm2 + (X_given(k) - X_gan_tranformed(k))^2; % norm2 = (second_norm)^2
            Cost1 = N*log(norm2);
        end

        for d = 1:10
            Cost2 = Cost2 + Z0(d)^2;
        end
        Cost(i) = Cost1 + Cost2;

        
        U2 = -2*T'*(X_n(1:N,n) - T*X)/norm2; % gradient of log((norm(Xn-T*X))^2) with respect of X
        V2 = U2 .* diff_sigmoid(W2);
        U1 = A_2' * V2;
        V1 = U1 .* diff_Relu(W1);
        U0 = A_1' * V1;            % Gradient of log((norm(Xn-T*X))^2) with respect of Z

        diff_Cost = N*U0 + 2*Z0;   % Gradient of J(z) 
    

        if (i==1 && j==1)
            P = diff_Cost .^ 2;   % initiation of Adams normalization
        else
            P = (1-L) * P_old + L * (diff_Cost).^2; 
        end
        
        P_old = P;
      
        Z0 = Z0 - m * diff_Cost ./ sqrt(C + P);        
    
    end

    if Best_Cost(iter) > Cost(iter) 
        Z0_Best = Z0;
        Best_Cost = Cost;
    end

end


W1 = A_1 * Z0_Best + B_1;
Z1 = max(W1,0);        % ReLU
W2 = A_2 * Z1 + B_2;
X = 1./(1 + exp(W2)); % Sigmoid given

X_gan_finds = X;
X_gan_finds_2D = reshape(X_gan_finds,28,28);
% figure;
% imshow(X_gan_finds_2D);
figure;
plot(Best_Cost);


% X_all_2D = [X_ideal_2D,ones(28,2),X_given_2D,ones(28,2),X_gan_finds_2D];

figure;
subplot(1,3,1);
imshow(X_ideal_2D)
subplot(1,3,2);
imshow(X_given_2D);
subplot(1,3,3);
imshow(X_gan_finds_2D);

% figure;
% imshow(X_all_2D);

