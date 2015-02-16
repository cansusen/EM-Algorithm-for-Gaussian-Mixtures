function [mu,sigma,alpha] = maximizationStep(data,memWeights)
% Maximizatin step
% Returns parameters

%% Variables
k = size(memWeights,2);
n = size(data,1); %Data size
d = size(data,2); %Feature size
N_k = zeros(1,k);
mu = zeros(d,k);
alpha = ones(1,k);
sigma = zeros(d,d,k);


%% Calculations

% First calculate new alphas
for i = 1:k,
    for j = 1:n,
        alpha(i) = alpha(i) + memWeights(j,i);  
    end
end
alpha = alpha/n;


% Second calculate new mu's
for i = 1:k, 
    for j = 1:n,
        N_k(i) = N_k(i) + memWeights(j,i);
        mu(:,i) = mu(:,i) + memWeights(j,i)*data(j,:)';
    end
    mu(:,i) = mu(:,i)/N_k(i);
end


% Thirs calculate new sigma's
for i = 1:k,
    for j = 1:n,
        temp1 = data(j,:)- mu(:,i)';
        sigma(:,:,i) = sigma(:,:,i) + memWeights(j,i).*(temp1'*temp1);
    end
    sigma(:,:,i) = sigma(:,:,i)/N_k(i);
end


