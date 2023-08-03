%% Q1: Principal Component Analysis
clc;
clear all;
close all;
load data.mat
TD=test_data;
TrD=train_data;
TL=test_labels;
TrL=train_labels;
m=20;
[U, Z] = pca(TrD,'Algorithm','eig','NumComponents',m);
C=cov(TrD); 
[e, index]=sort(eig(C),'descend');
figure(1);
plot(e,'k.-');grid;
title('Eigenvalues in descending order');
xlabel('Principal Component Number');
ylabel('Eigenvalue');axis tight;
% Finding sample mean [Find mean of columns of data]
samp_mean=mean(TrD,1);
figure(2);
imagesc(reshape(samp_mean,20,20));
title("Sample Mean")
colormap(gray);
axis image;
% Also display the bases (eigenvectors) that you chose as images
[evec, eval] = eig(C);
Vk = evec(:,((400-(m-1)):400));
F = TrD*Vk;
TrD_k = F*Vk';
sample=20;

for i=1:1:m
    I=U(:,i);
    figure();
    imagesc(reshape(I,20,20));
    title(strcat('Bases (eigenvectors):',num2str(i)));
    colormap(gray);
    axis image;
end
% Training and Classification
m=200;          % Find a larger chunk of bases
[COEFF, SCORE] = pca(TrD,'Algorithm','svd','NumComponents',m);
z=1;
k=1;
x=[1:5:50,100:5:145,150:5:195]; % Selecting 30 different subspace dimensions (from 200)
while k<=30
    kk=x(k);
    mu = zeros(10,kk);               % Initialize mu and covar_mat with zeroes 
    covar_mat = zeros(kk,kk,10);      % and appropriate dimension
    ProjTest = TD * COEFF(:,1:kk);   % Project Training data
    ProjTrain = TrD * COEFF(:,1:kk); % Project Test data
    for i=1:10
        % Loop to search for digits (Labels) 0~9 in Training set
        temp = ProjTrain(TrL== i-1,:);
        mu(i,:) = mean(temp,1);     % Find mean of columns
        XX = temp - mu(i,:);        % Subtract mean value
        covar_mat(:,:,i) = (XX' * XX)/size(temp,1);       
    end
    testError(z) = Gausspredict(mu,covar_mat,[ProjTest,TL]);
    trainError(z) = Gausspredict(mu,covar_mat,[ProjTrain,TrL]);
    z=z+1;
    k=k+1;
end

figure
plot(x,trainError,'O-',x,testError,'*-');title('Classification error plot using PCA'); 
xlabel('Principal Component Number'); ylabel('Classification Error (%)');
legend('Train Error','Test Error');grid;axis tight;
