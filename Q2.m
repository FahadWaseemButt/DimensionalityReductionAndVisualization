%% Q2: Linear Discriminant Analysis
clc;
clear all;
close all;
load data.mat;
TD=test_data;
TrD=train_data;
TL=test_labels;
TrL=train_labels;

testError=zeros(9,1);
trainError=zeros(9,1);
k=1;
while k<=9
    [ldaMAP,ldaBASES]=lda([TrD;TD],[TrL;TL],k);
    trainLDA=ldaMAP(1:2500,:);
    testLDA=ldaMAP(2501:5000,:);
    
    mu = zeros(10,k);
    covar_mat = zeros(k,k,10);
    for i=1:10
        temp = trainLDA(TrL== i-1,:);
        mu(i,:) = mean(temp,1);
        XX = temp - mu(i,:);
        covar_mat(:,:,i) = (XX' * XX)/size(temp,1);
    end
    trainError(k)=Gausspredict(mu,covar_mat,[trainLDA,TrL]);
    testError(k)=Gausspredict(mu,covar_mat,[testLDA,TL]);
    k=k+1;
end

% Display bases as images
for i=1:9
    I=ldaBASES.M(:,i);
    figure, imagesc(reshape(I,20,20));
    title(strcat('Base=',num2str(i)))
    colormap(gray);
    axis image;
end

% Plotting Errors
figure
y=1:1:9;
plot(y,trainError,'O-',y,testError,'*-');title('Classification error plot using LDA'); 
xlabel('Dimension of subspace'); ylabel('Classification Error (%)');
legend('Train Error','Test Error');grid; axis tight;

