function [X_cluster, center, U, obj_fcm] = FCMCluster(data, cluster_n)
% FCM
% Input:
%   data        ---- Dataset
%   cluster_n   ---- Number of cluster centers
% Output£º
%   X_cluster   ---- Cluster results
%   center      ---- Cluster centers
%   U           ---- Membership Value Matrix
%   obj_fcm     ---- Objective function value of FCM
%% Parameter setting
options = [2;1000;1e-5;0];
expo = options(1);         % Fuzzier
max_iter = options(2);     % Number of iteration
min_impro = options(3);    % Minimum variation of fitness function
display = options(4);      % If display in each iteration

%% Initialization
obj_fcm = zeros(max_iter, 1); % Initialization for obj_fcm
data_n = size(data, 1);       % Number of samples
U = initfcm(cluster_n, data_n);     % TODO: How to initialize U
%% Main loop
for i = 1:max_iter
    % TODO: How to update 
    [X_cluster, U, center, obj_fcm(i)] = stepfcm(data, U, cluster_n, expo);
    if display
       fprintf('FCM:Iteration count = %d, obj. fcm = %f\n', i, obj_fcm(i));
    end
    % If stop
    if i>1
      if abs(obj_fcm(i) - obj_fcm(i-1)) < min_impro
            break;
      end
    end
end
 
end

 
% Subfunction 1: How to initialize U
function U = initfcm(cluster_n, data_n)
% Initialization for membership value matrix
% Input:
%   cluster_n   ---- Number of cluster centers
%   data_n      ---- Number of samples
% Output£º
%   U           ---- Membership Value Matrix
U = rand(cluster_n, data_n);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :); % Normalization
end
 
 
% Subfunction 2: How to update
function [X_cluster, U_new, center, obj_fcm] = stepfcm(data, U, cluster_n, expo)
% Updation for membership value matrix
% Input£º
%   data        ---- Dataset
%   U           ---- Membership Value Matrix
%   cluster_n   ---- Number of cluster centers
%   expo        ---- Fuzzier                    
% Êä³ö£º
%   U_new       ---- New membership value matrix after each iteration
%   center      ---- Cluster center after each iteration
%   obj_fcm     ---- Objective function value after each iteration
mf = U.^expo;
center = mf*data./((ones(size(data, 2), 1)*sum(mf'))');
dist = distfcm(center, data); % TODO: How to calculate the distance
[~,X_cluster] = min(dist);
X_cluster = X_cluster';
obj_fcm = sum(sum((dist.^2).*mf));
tmp = dist.^(-2/(expo-1));    
U_new = tmp./(ones(cluster_n, 1)*sum(tmp));
 
end
 
 
% Subfunction 2: How to calculate the distance
function out = distfcm(center, data)
% Calculate the distance between data and center
% Input£º
%   center     ---- Cluster centers
%   data       ---- Dataset
% Êä³ö£º
%   out        ---- Distance
out = zeros(size(center, 1), size(data, 1));
  for k = 1:size(center, 1) 
    % Distance between all samples and each center
    out(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
  end
end
