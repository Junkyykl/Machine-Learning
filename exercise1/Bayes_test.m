clc
clear all;
X0 = randn(10^6,2); % pdf0
X1 = zeros(10^6,2); % pdf1

for i = 1:10^6
    for j = 1:2
        if randn()>=0
            X1(i,j) = -1 + randn();
        else
            X1(i,j) = 1 + randn();
        end
    end
end
save("X0train","X0");
save("X1train","X1");

figure;
histogram(X0);
figure;
histogram(X1);

count1 = 0;
for i = 1:10^6
    if pdf1(X0(i,1),X0(i,2)) > pdf0(X0(i,1),X0(i,2))
        count1 = count1 +1;
    elseif pdf1(X0(i,1),X0(i,2)) == pdf0(X0(i,1),X0(i,2))
        if rand() > 0.5
            count1 = count1 + 1;
        end
    end
end

count2 = 0;
for i = 1:10^6
    if pdf1(X1(i,1),X1(i,2)) < pdf0(X1(i,1),X1(i,2)) 
        count2 = count2 +1;
    elseif pdf1(X1(i,1),X1(i,2)) == pdf0(X1(i,1),X1(i,2)) 
        if rand() > 0.5
            count2 = count2 + 1;
        end

    end
end

Bayes_test_error = 0.5*(count1/(10^6)) + 0.5*(count2/(10^6));
