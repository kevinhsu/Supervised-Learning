
function [MSE_t, MSE_v, MSE_te, MSE_train, MSE_test, SD_train, SD_test, BestLamda] = RR2(l, M, N, Lamda, Method)

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
[M_Lamda,N_Lamda] = size(Lamda');
if M_Lamda < N_Lamda
    M_Lamda = N_Lamda;
end

% Minimize the training error to find out the best Lamda
if Method == 1
    for i = 1:M_Lamda
        w_star = (X_train'*X_train + Lamda(i)*l*eye(N)) \ X_train' * y_train;
        MSE_train(i) = (1/l) * (w_star'*X_train'*X_train*w_star - 2*y_train'*X_train*w_star + y_train'*y_train);
    end
    [~,J] = min(MSE_train);
    BestLamda = Lamda(J);
    MSE_t = [];
    MSE_v = [];
end

% Minimize the validation error to find out the best Lamda 
% Minimize the 5-fold cross validation to find out the best Lamda
if Method == 2 || Method == 3
    [MSE_t, MSE_v, BestLamda] = crossvalidation(X_train, y_train, Lamda, Method);
end

for i = 1:M_Lamda
    w = (X_train'*X_train + Lamda(i)*l*eye(N)) \ X_train' * y_train;
    MSE_te(i) = (1/(M-l)) * (w'*X_test'*X_test*w - 2*y_test'*X_test*w + y_test'*y_test);
end
MSE_te = MSE_te';

w_star = (X_train'*X_train + BestLamda*l*eye(N)) \ X_train' * y_train;
MSE_train = (1/l) * (w_star'*X_train'*X_train*w_star - 2*y_train'*X_train*w_star + y_train'*y_train);
MSE_test = (1/(M-l)) * (w_star'*X_test'*X_test*w_star - 2*y_test'*X_test*w_star + y_test'*y_test);
MSE_train = MSE_train';
MSE_test = MSE_test';

%Standard Deviation
y_train_hat = X_train*w_star;
y_test_hat = X_test*w_star;

SD_train = sqrt(MSE_train - (mean((y_train-y_train_hat)))^2);
SD_test = sqrt(MSE_test - (mean((y_test-y_test_hat)))^2);

