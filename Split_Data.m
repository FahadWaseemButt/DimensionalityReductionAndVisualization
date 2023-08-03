clc; close all;
clear all;
load digits.mat
RP = randperm(size(digits,1));
train_data = digits(RP(1:2500),:);
test_data = digits(RP(2501:end),:);
train_labels = labels(RP(1:2500),:);
test_labels = labels(RP(2501:end),:);
save data train_data test_data train_labels test_labels

% Check data
i = 10; % Select data index to verify our result
I = train_data(i,:);
figure(1);
imagesc(reshape(I,20,20));
colormap(gray);
axis image;
train_labels(i)

I = test_data(i,:);
figure(2)
imagesc( reshape(I,20,20));
colormap(gray);
axis image;
test_labels(i)