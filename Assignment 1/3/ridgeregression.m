function [MSE_train, MSE_test, SD_train, SD_test] = ridgeregression(X, y, Div)

if nargin == 2
    Div = 2/3;
end

[M,~] = size(X);
l = ceil(Div * M);

X_train = X(1:l,:);
X_test = X((l+1):M,:);
y_train = y(1:l,:);
y_test = y((l+1):M,:);

IndexofLamda = -40:1:-26;
IndexofSigma = 7:0.5:13;

Lamda = 2.^(IndexofLamda);
Sigma = 2.^(IndexofSigma);

% Use five-fold cross-validaiton on the training set.
% Use regression model deriving from training set with best
% cross-validation performance to predict testing dependent values
% given testing set.

[BestLamda, BestSigma] = crossvalidation(X_train, y_train, Sigma, Lamda);

K_train = kerneltrick(X_train, X_train, BestSigma);
K_test = kerneltrick(X_test, X_train, BestSigma);
Alpha = kridgereg(K_train, y_train, BestLamda);
MSE_train = dualcost(K_train, y_train, Alpha);
MSE_test = dualcost(K_test, y_test, Alpha);

y_train_hat = [];
y_test_hat = [];
for i = 1:M
    if i <= l
        y_train_hat(i) = 0;
        for j = 1:l
            y_train_hat(i) = y_train_hat(i) + Alpha(j)*kerneltrick(X_train(j,:), X_train(i,:), BestSigma);
        end
    else
        y_test_hat(i-l) = 0;
        for j = 1:l
            y_test_hat(i-l) = y_test_hat(i-l) + Alpha(j)*kerneltrick(X_train(j,:), X_test(i-l,:), BestSigma);
        end
    end
end

y_train_hat = y_train_hat';
y_test_hat = y_test_hat';
SD_train = sqrt(MSE_train - (mean(y_train-y_train_hat))^2);
SD_test = sqrt(MSE_test - (mean(y_test-y_test_hat))^2);











