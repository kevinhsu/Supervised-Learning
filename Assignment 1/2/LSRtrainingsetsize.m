function [MSE_table] = LSRtrainingsetsize
% Given size of training set, size of data set and dimension of weight
% vector.
M = 600;
N = 1;
iteration = 200;
MSE_table = zeros(2,2);

% 100 element-size training set with 1 dimension. Repeat 200 times.
for i = 1:iteration
    l = 100;
    [MSE_train(i), MSE_test(i)] = LSR(l, M, N);
end
MSE_table(1,1) = mean(MSE_train);
MSE_table(1,2) = mean(MSE_test);

% 10 element-size training set with 1 dimension. Repeat 200 times.
for i = 1:iteration
    l = 10;
    [MSE_train(i), MSE_test(i)] = LSR(l, M, N);
end
MSE_table(2,1) = mean(MSE_train);
MSE_table(2,2) = mean(MSE_test);
