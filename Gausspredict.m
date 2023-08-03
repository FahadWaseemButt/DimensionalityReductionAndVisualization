function [error,prediction] = Gausspredict(mu,covar_mat,DATA)
   % Initialize with zeros
    verify=zeros(2500,10);
    prediction=zeros(2500,1);
    for i=1:10
        % Subtract mu from each data point
        XX = DATA(:,1:end-1)-mu(i,:);
        fact1=((2*pi)^(size(DATA(:,1:end-1),2)/2)*sqrt(det(covar_mat(:,:,i))));
        fact2 = diag(XX*pinv(covar_mat(:,:,i))*XX');
        y(:,i) = 1/fact1 * exp(-0.5*fact2);
    end    
    for i=1:size(DATA(:,1:end-1),1)
        prediction(i)=find(y(i,:)==max(y(i,:)),1);
    end
    % Determining Error
    LABEL=DATA(:,end);
    prediction=prediction-1;            % Index adjustment (counter from 1~10), digits 0~9
    verify = (prediction(:,1)==LABEL);  % Search for correct predictions
    total_correct = sum(verify);
    total_error=size(prediction,1)-total_correct;
    error=(total_error/size(DATA(:,1:end-1),1))*100;
end
