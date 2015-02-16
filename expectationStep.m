function memWeights = expectationStep(data,alpha,mu,sigma)
% Expectation step. 
% Returns membership weights

%% Variables 
n = size(data,1);
d = size(data,2);
k = size(mu, 2);
memWeights = zeros(n,k);
sqrt_det_sigma = zeros(1,k);
inverse_sigma = zeros(d,d,k);
pi = 3.1415;

% Calculate necessary factors and variables
factor = (2*pi)^(0.5*d);

for i = 1:k
    sqrt_det_sigma(i) = sqrt(det(sigma(:,:,i)));
    inverse_sigma(:,:,i) = inv(sigma(:,:,i));
end



%% Calculations

for i = 1:n,
    for j = 1:k,
        temp1 = data(i,:) - mu(:,j)';
        temp2 = exp(-0.5*temp1*inverse_sigma(:,:,j)*temp1')/...
            (factor*sqrt_det_sigma(j));
        memWeights(i,j) = alpha(j)*temp2;
    end
    memWeights(i,:) = memWeights(i,:)/sum(memWeights(i,:));
end


