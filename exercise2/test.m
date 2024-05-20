close all;
clear ;
clc;
load('data21.mat');
load('data22.mat');

% X2D = reshape(X_n(:,1),28,28);
% imshow(X2D);

N = 400

; % number of pixels that we keep
T = [eye(N) zeros(N,784-N)]; % trasformation

n = 1; % number of X_n's collumn(image) that is used

X_ideal = X_i(:,n);
X_ideal_2D = reshape(X_ideal,28,28);
figure;
imshow(X_ideal_2D);

X_given = X_n(1:N,n);
X_given = [X_given;zeros(784-N,1)];
X_given_2D = reshape(X_given,28,28);
figure;
imshow(X_given_2D);


% Gradient Descent's Parameters
iter = 1e4; % number of algorithm's iterations
m = 1e-3; % step-size
L = 0.1; % smoothing factor(on Adam)
C = 1e-200; % a really small number to avoid devision with 0(on adam)


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
            norm2 = norm2 + (X_given(k) - X_gan_tranformed(k))^2;
            Cost1 = N*log(norm2);
        end

        for d = 1:10
            Cost2 = Cost2 + Z0(d)^2;
        end
        Cost(i) = Cost1 + Cost2;


%         G = zeros(784,1);
%         for k = 1:N
%             G(k) = 1/norm2 *(-2) * ((X_given(k) - X_gan_tranformed(k))) ; % (v2) gradient of log((norm(Xn-T*X))^2) with respect of X 
%         end

        
        U2 = -2*T'*(X_n(1:N,n) - T*X)/norm2; % gradient of log((norm(Xn-T*X))^2) with respect of X 
        V2 = U2 .* diff_sigmoid(W2);
        U1 = A_2' * V2;
        V1 = U1 .* diff_Relu(W1);
        U0 = A_1' * V1;     %    gradient of log((norm(Xn-T*X))^2) with respect of Z

        diff_Cost = N*U0 + 2*Z0;
    

        if (i==1 && j==1)
            P = diff_Cost .^ 2;  % initiation of Adams normalization
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
figure;
imshow(X_gan_finds_2D);
figure;
plot(Best_Cost);


% X_all = [X_ideal;X_given;X_gan_finds];
% X_all_2D = reshape(X_all,28,28*3);

X_all_2D = [X_ideal_2D,ones(28,2),X_given_2D,ones(28,2),X_gan_finds_2D];

figure;
subplot(1,3,1);
imshow(X_ideal_2D)
subplot(1,3,2);
imshow(X_given_2D);
subplot(1,3,3);
imshow(X_gan_finds_2D);

figure;
imshow(X_all_2D);