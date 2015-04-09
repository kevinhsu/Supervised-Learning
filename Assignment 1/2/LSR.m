
function [MSE_train, MSE_test] = LSR(l, M, N)
% l: size of training set
% M: size of data set
% N: dimension of weight vector

% Generate random w, X and n, use randn
w = randn(N,1);
X = randn(M,N);
n = randn(M,1);
y = X * w + n;

% Split the data set into a training set of size l and a test set of size
% M-l
X_train = X(1:l,:);
X_test = X((l+1):M,:);
y_train = y(1:l,:);
y_test = y((l+1):M,:);

% Compute MSE on the training and testing set
w_star = (X_train'*X_train) \ X_train' * y_train;
MSE_train = (1/l) * (w_star'*X_train'*X_train*w_star - 2*y_train'*X_train*w_star + y_train'*y_train);
MSE_test = (1/(M-l)) * (w_star'*X_test'*X_test*w_star - 2*y_test'*X_test*w_star + y_test'*y_test);


