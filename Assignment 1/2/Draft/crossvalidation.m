function [MSE_t, MSE_v, BestLamda] = crossvalidation(X, y, Lamda, Method, Folds)

[M_Lamda, N_Lamda] = size(Lamda);
if M_Lamda < N_Lamda
    M_Lamda = N_Lamda;
end

if nargin == 4
    Folds = 5;
end
    
[M,N] = size(X);

% Generate random w, X and n, use randn
num_of_fold = ceil(M/Folds);

for k = 1:Folds
    
    X_v = [];
    X_t = [];
    y_v = [];
    y_t = [];
    
    if k == 1
        X_v = X(((k-1)*num_of_fold+1):(k*num_of_fold),:);
        X_t = X((k*num_of_fold+1):M,:);
        y_v = y(((k-1)*num_of_fold+1):(k*num_of_fold),:);
        y_t = y((k*num_of_fold+1):M,:);
    elseif 1 < k && k < Folds
        X_t = X(1:((k-1)*num_of_fold),:);
        X_v = X(((k-1)*num_of_fold+1):(k*num_of_fold),:);
        X_t = [X_t; X((k*num_of_fold+1):M,:)];
        y_t = y(1:((k-1)*num_of_fold),:);
        y_v = y(((k-1)*num_of_fold+1):(k*num_of_fold),:);
        y_t = [y_t; y((k*num_of_fold+1):M,:)];
    elseif k == Folds
        X_t = X(1:(M-num_of_fold),:);
        X_v = X((M-num_of_fold+1):M,:);
        y_t = y(1:(M-num_of_fold),:);
        y_v = y((M-num_of_fold+1):M,:);
    end
    
    for i = 1:M_Lamda
        w_star = (X_t'*X_t + Lamda(i)*(M-num_of_fold)*eye(N)) \ X_t' * y_t;
        MSE_t(k,i) = (1/(M-num_of_fold)) * (w_star'*X_t'*X_t*w_star - 2*y_t'*X_t*w_star + y_t'*y_t);
        MSE_v(k,i) = (1/(num_of_fold)) * (w_star'*X_v'*X_v*w_star - 2*y_v'*X_v*w_star + y_v'*y_v);
    end
    
    if Method == 2
        break;
    end
end

if Method == 3
    MSE_t = mean(MSE_t)';
    MSE_v = mean(MSE_v)';
else
    MSE_t = MSE_t';
    MSE_v = MSE_v';
end

[~,J] = min(MSE_v);
BestLamda = Lamda(J);




