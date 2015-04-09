function [MSE_train, MSE_test, SD_train, SD_test] = Bostonhousing(attributes, target, iteration)

if nargin == 2
    iteration = 20;
end

for j = 1:iteration
    
    [M,~] = size(attributes);
    order = randperm(M);
    
    for i = 1:M
        X(i,:) = attributes(order(i),:);
        y(i,:) = target(order(i),:);
    end
    
    [MSE_train_l, MSE_test_l, SD_train_l, SD_test_l] = linearregression(X, y);
    [MSE_train_r, MSE_test_r, SD_train_r, SD_test_r] = ridgeregression(X, y);
    MSE_train(:,j) = [MSE_train_l; MSE_train_r];
    MSE_test(:,j) = [MSE_test_l; MSE_test_r];
    SD_train(:,j) = [SD_train_l; SD_train_r];
    SD_test(:,j) = [SD_test_l; SD_test_r];
end

if iteration ~= 1
    MSE_train = mean(MSE_train')';
    MSE_test = mean(MSE_test')';
    SD_train = mean(SD_train')';
    SD_test = mean(SD_test')';
end

