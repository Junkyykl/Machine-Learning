close all;
clear;
clc;
load("data33.mat");

X= [X(1,:);X(2,:);X(1,:).^2 + X(2,:).^2];

% figure;
% title("mystery information");
% 
% scatter3(X(1,1:100),X(2,1:100),X(3,1:100),'r','.');  
% hold on;
% scatter3(X(1,101:200),X(2,101:200),X(3,101:200),'b','.'); 
% hold off;
% 
% figure;
% title("unclusterd");
% 
% scatter3(X(1,:),X(2,:),X(3,:),'r','.');

Xmax = max(abs(X(1,:)));
Ymax = max(abs(X(2,:)));
Zmax = max(X(3,:));
% Zmax = 10;

Z1 = [-Xmax + 2*Xmax*rand;-Ymax + 2*Ymax*rand;Zmax*rand];
Z2 = [-Xmax + 2*Xmax*rand;-Ymax + 2*Ymax*rand;Zmax*rand];

N=15;   % number of times that we run K-Means 
Cost = zeros(1,N);


for k = 1:N
    C1=[];
    C2=[];

    for i = 1:200

        dist1 = (X(1,i)-Z1(1,1))^2 + (X(2,i)-Z1(2,1))^2 + (X(3,i)-Z1(3,1))^2;
        dist2 = (X(1,i)-Z2(1,1))^2 + (X(2,i)-Z2(2,1))^2 + (X(3,i)-Z2(3,1))^2;
        
        if dist1 < dist2
            C1(:,end+1) = X(:,i);
        elseif dist1 > dist2
            C2(:,end+1) = X(:,i);
        elseif rand>0
            C1(:,end+1) = X(:,i);
        else
            C2(:,end+1) = X(:,i);
        end

    end

    N1 = length(C1(1,:));
    N2 = length(C2(1,:));

    for j = 1:N1           
        Cost(k) = Cost(k) + (C1(1,j)-Z1(1,1))^2 + (C1(2,j)-Z1(2,1))^2 + (C1(3,j)-Z1(3,1))^2 ;
    end

     for j = 1:N2           
        Cost(k) = Cost(k) + (C2(1,j)-Z2(1,1))^2 + (C2(2,j)-Z2(2,1))^2 + (C2(3,j)-Z2(3,1))^2;
    end


    Z1 = zeros(3,1);
    Z2 = zeros(3,1);

    for i = 1:N1 
        Z1 = Z1 + C1(:,i); 
    end

    for i = 1:N2
        Z2 = Z2 + C2(:,i);
    end

    Z1 = Z1./N1;
    Z2 = Z2./N2;

end

figure;
plot(Cost);

count1=0;
count2=0;
for i = 1:N1
    for j = 1:100
        if C1(:,i)==X(:,j)
            count1 = count1 +1;
        end
    end
end
for i = 1:N2
    for j = 101:200
        if C2(:,i)==X(:,j)
            count1 = count1 +1;
        end
    end
end

for i = 1:N2
    for j = 1:100
        if C2(:,i)==X(:,j)
            count2 = count2 +1;
        end
    end
end

for i = 1:N1
    for j = 101:200
        if C1(:,i)==X(:,j)
            count2 = count2 +1;
        end
    end
end

Cluster_Error = min([1-count1/200 1-count2/200]);

%     PLOTTING
figure;
% mystic information
scatter3(X(1,1:100),X(2,1:100),X(3,1:100),'r','.','DisplayName','Real/Hidden Team 1');  
hold on;
scatter3(X(1,101:200),X(2,101:200),X(3,101:200),'b','.','DisplayName','Real/Hidden Team 2'); 
hold off;
% Kmeans clustering
if count2>count1
    hold on;
    scatter3(C2(1,:),C2(2,:),C2(3,:),'r','o','DisplayName','Clustered Team 1');  
    hold off;
    hold on;
    scatter(C1(1,:),C1(2,:),C1(3,:),'b','o','DisplayName','Clustered Team 2');
    hold off;
    hold on;
    scatter3(Z2(1,1),Z2(2,1),Z2(3,1),100,'r','^','filled','DisplayName','Cluster 1 Representer');
    hold off;
    hold on;
    scatter3(Z1(1,1),Z1(2,1),Z1(3,1),100,'b','^','filled','DisplayName','Cluster 2 Representer');
    hold off;

else   
    hold on;
    scatter3(C2(1,:),C2(2,:),C2(3,:),'b','o','DisplayName','Clustered Team 2');
    hold off;
    hold on;
    scatter3(C1(1,:),C1(2,:),C1(3,:),'r','o','DisplayName','Clustered Team 1');
    hold off;
    hold on;
    scatter3(Z2(1,1),Z2(2,1),Z2(3,1),100,'b','^','filled','DisplayName','Cluster 2 Representer');
    hold off;
    hold on;
    scatter3(Z1(1,1),Z1(2,1),Z1(3,1),100,'r','^','filled','DisplayName','Cluster 1 Representer');
    hold off;
end


legend;



