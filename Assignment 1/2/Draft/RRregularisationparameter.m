function [MSE_table] = RRregularisationparameter

% Exercise 4
M = 600;
N = 10;
IndexofLamda = -6:1:3;
Lamda = 10.^IndexofLamda;
iteration = 200;

for i = 1:iteration
    l =100;
    [MSE_train(:,i), MSE_test(:,i)] = RR(l, M, N, Lamda);
end

MSE_train = mean(MSE_train')';
MSE_test = mean(MSE_test')';
MSE_table(:,1) = MSE_train;
MSE_table(:,2) = MSE_test;

subplot(1,2,1);
hold on;
plot(IndexofLamda, MSE_train,'b');
plot(IndexofLamda, MSE_test,'r');

for i = 1:iteration
    l =10;
    [MSE_train(:,i), MSE_test(:,i)] = RR(l, M, N, Lamda);
end

MSE_train = mean(MSE_train')';
MSE_test = mean(MSE_test')';
MSE_table(:,3) = MSE_train;
MSE_table(:,4) = MSE_test;

subplot(1,2,2);
hold on;
plot(IndexofLamda, MSE_train,'b');
plot(IndexofLamda, MSE_test,'r');




