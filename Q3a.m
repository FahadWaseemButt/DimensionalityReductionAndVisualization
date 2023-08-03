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

% Set Sammon algo options 
opts                = sammon;
opts.Display        = 'iter';
opts.TolFun         = 1e-6;
opts.Initialisation = 'pca';
opts.MaxHalves      = 20;
opts.MaxIter        = 500;
opts.Initialisation = 'random';

tic
[y, E] = sammon(All_Data, 2, opts);
toc
%% plot results

figure(1);
plot(y(All_Labels == 0,1), y(All_Labels == 0,2), 'r.', ...
     y(All_Labels == 1,1), y(All_Labels == 1,2), 'b.', ...
     y(All_Labels == 2,1), y(All_Labels == 2,2), 'g.', ...
     y(All_Labels == 3,1), y(All_Labels == 3,2), 'r+', ...
     y(All_Labels == 4,1), y(All_Labels == 4,2), 'b+', ...
     y(All_Labels == 5,1), y(All_Labels == 5,2), 'g+', ...
     y(All_Labels == 6,1), y(All_Labels == 6,2), 'ro', ...
     y(All_Labels == 7,1), y(All_Labels == 7,2), 'bo', ...
     y(All_Labels == 8,1), y(All_Labels == 8,2), 'go', ...
     y(All_Labels == 9,1), y(All_Labels == 9,2), 'r^');
     title('Sammon Mapping');grid;
legend('0','1', '2', '3','4','5','6','7','8','9');