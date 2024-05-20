X0 = randn(10^6,2); % pdf0
Xz = zeros(10^6,2); % pdf1

for i = 1:10^6
    for j = 1:2
        Xz(i,j) = 5+ randn();
    end
end

figure;
histogram(X0);
figure;
histogram(Xz);

count1 = 0;
for i = 1:10^6
    if pdfz(X0(i,1),X0(i,2)) > pdf0(X0(i,1),X0(i,2))
        count1 = count1 +1;
    elseif pdfz(X0(i,1),X0(i,2)) == pdf0(X0(i,1),X0(i,2))
        if rand() > 0.5
            count1 = count1 + 1;
        end
    end
end

count2 = 0;
for i = 1:10^6
    if pdfz(Xz(i,1),Xz(i,2)) < pdf0(Xz(i,1),Xz(i,2)) 
        count2 = count2 +1;
    elseif pdfz(Xz(i,1),Xz(i,2)) == pdf0(Xz(i,1),Xz(i,2)) 
        if rand() > 0.5
            count2 = count2 + 1;
        end
    end
end

Bayes_test_error = 0.5*(count1/(10^6)) + 0.5*(count2/(10^6));