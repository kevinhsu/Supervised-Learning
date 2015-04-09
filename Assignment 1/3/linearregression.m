function [MSE_train, MSE_test, SD_train, SD_test] = linearregression(X, y, Div)

% X: all attributes
% y: all target

% Split the data into 2/3 and 1/3
if nargin == 2
    Div = 2/3;
end

[M,N] = size(X);
l = ceil(Div * M);

X_train = [X(1:l,:),ones(l,1)];
X_test = [X((l+1):M,:),ones(M-l,1)];
y_train = y(1:l,:);
y_test = y((l+1):M,:);

% Linear regression
for j = 0:N+1
    
    y_train_hat = [];
    y_test_hat = [];
    w = [];
    
    if j == 0
        
        w = (X_train(:,N+1)' * X_train(:,N+1)) \ X_train(:,N+1)' * y_train;
        for i = 1:M % Calculate prediction of target
            if i <= l
                y_train_hat(i) = 0;
                y_train_hat(i) = X_train(i,N+1)*w;
            else
                y_test_hat(i-l) = 0;
                y_test_hat(i-l) = X_train(i-l,N+1)*w;
            end
        end
        
    elseif 0 < j && j < N+1
        
        w = ([X_train(:,j),X_train(:,N+1)]' * [X_train(:,j),X_train(:,N+1)]) \ [X_train(:,j),X_train(:,N+1)]' * y_train;
        for i = 1:M
            if i <= l
                y_train_hat(i) = 0;
                y_train_hat(i) = [X_train(i,j),X_train(i,N+1)]*w;
            else
                y_test_hat(i-l) = 0;
                y_test_hat(i-l) = [X_test(i-l,j),X_train(i-l,N+1)]*w;
            end
        end
        
    elseif j == N+1
        
        w = (X_train' * X_train) \ X_train' * y_train;
        for i = 1:M
            if i <= l
                y_train_hat(i) = 0;
                y_train_hat(i) = X_train(i,:)*w;
            else
                y_test_hat(i-l) = 0;
                y_test_hat(i-l) = X_test(i-l,:)*w;
            end
        end
    end
    
    y_train_hat = y_train_hat';
    y_test_hat = y_test_hat';
    MSE_train(j+1) = mean((y_train-y_train_hat).^2);
    MSE_test(j+1) = mean((y_test-y_test_hat).^2);
    SD_train(j+1) = sqrt(MSE_train(j+1) - (mean(y_train-y_train_hat))^2);
    SD_test(j+1) = sqrt(MSE_test(j+1) - (mean(y_test-y_test_hat))^2);
    
end

MSE_train = MSE_train';
MSE_test = MSE_test';
SD_train = SD_train';
SD_test = SD_test';