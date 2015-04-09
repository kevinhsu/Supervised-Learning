function [BestLamda, BestSigma] = crossvalidation(X, y, Sigma, Lamda, Folds)

% Default: Five-folds Cross-validation
if nargin ~= 5
    Folds = 5;
end

[M_Sigma,N_Sigma] = size(Sigma);
if M_Sigma < N_Sigma
    M_Sigma = N_Sigma;
end

[M_Lamda,N_Lamda] = size(Lamda);
if M_Lamda < N_Lamda
    M_Lamda = N_Lamda;
end

[M,~] = size(X);
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
    
    for i = 1:M_Sigma
        K_train_t = kerneltrick(X_t, X_t, Sigma(i));
        K_train_v = kerneltrick(X_v, X_t, Sigma(i));
        for j = 1:M_Lamda
            MSE(k,i,j) = dualcost(K_train_v, y_v, kridgereg(K_train_t, y_t, Lamda(j)));
        end
    end
    
end

if Folds ~= 1
    MSE = mean(MSE);
    
    for i = 1:M_Sigma
        for j = 1:M_Lamda
            Z_axis(i,j) = MSE(1,i,j);
        end
    end
    
    MSE = [];
    MSE = Z_axis;
end
[X_axis, Y_axis] = meshgrid(Sigma, Lamda);

surf(log2(X_axis), log2(Y_axis), Z_axis');

[~,J] = min(MSE(:));
[I,J] = ind2sub(size(MSE),J);
BestSigma = Sigma(unique(I));
BestLamda = Lamda(unique(J));


