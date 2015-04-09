
function [MSE_train, MSE_test] = RR(l, M, N, Lamda)

% Generate random w, X and n, use randn
w = randn(N,1);
X = randn(M,N);
n = randn(M,1);
y = X * w + n;

% Split the data set into a training set of size l and a test set of size
% M-l
X_train = X(1:l,:);
X_test = X(101:M,:);
y_train = y(1:l,:);
y_test = y(101:M,:);

% Compute MSE on the training and testing set
[M_Lamda,~] = size(Lamda');

for i = 1:M_Lamda
    w_star = (X_train'*X_train + Lamda(i)*l*eye(N)) \ X_train' * y_train;
    MSE_train(i) = (1/l) * (w_star'*X_train'*X_train*w_star - 2*y_train'*X_train*w_star + y_train'*y_train);
    MSE_test(i) = (1/(M-100)) * (w_star'*X_test'*X_test*w_star - 2*y_test'*X_test*w_star + y_test'*y_test);
end

MSE_train = MSE_train';
MSE_test = MSE_test';

