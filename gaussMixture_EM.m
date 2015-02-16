% Cansu Sen
% The EM algorithm for Gaussian Mixtures

clear all;
clc;
close all;

k = 3;     %Component count, cluster count
T = 100;   %Iteration count

%% Load fisher iris data
load fisheriris;
data = meas;
n = size(data,1);

%% Initialize membership weights, Row totals should be equal to 1
%memWeights = rand(n,1);
%memWeights(:,2) = 1-memWeights;
memWeights = gamrnd(ones(n,k),1);
memWeights = memWeights ./ repmat(sum(memWeights,2),1,k);

%% Visualize the initial random labeling
[tmp labels] = max(memWeights,[],2);
figure;
pcomp = princomp(data);
gscatter(data*pcomp(:,1),data*pcomp(:,2),labels);


%% After initializing weights, conduct an M step
[mu,sigma,alpha] = maximizationStep(data,memWeights);


%% EM steps for T iterations
for i = 2:T
    memWeights = expectationStep(data,alpha,mu,sigma);
    [mu,sigma,alpha] = maximizationStep(data,memWeights);
end


%% Final guesses
[m labels] = max(memWeights,[],2);
figure;
pcomp = princomp(data);
gscatter(data*pcomp(:,1),data*pcomp(:,2),labels);

