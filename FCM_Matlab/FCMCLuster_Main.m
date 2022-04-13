% Main() for FCM
%% Empty
clear;
clc;
close all;
%% Load data
load fisheriris
% data = load('Wine.txt');
% feat = data(:, 2:end);
% label = data(:, 1);

% data = importdata('SRBCT.mat');
% data = data(:,end)+1;

%% FCM
cluster_n = 3;
[X_cluster, center, U, obj_fcm] = FCMCluster(meas, cluster_n);
[maxU,index]=max(U);
index1 = find(index ==1);
index2 = find(index ==2);
index3 = find(index ==3);
