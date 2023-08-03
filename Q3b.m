clc;
clear all;
close all;
load data.mat
TD=test_data;
TrD=train_data;
TL=test_labels;
TrL=train_labels;
All_Data=[TrD;TD];
All_Labels=[TrL;TL];
%function ydata = tsne(X, labels, no_dims, initial_dims, perplexity)
mappedX = tsne(All_Data, All_Labels,2,[],50);