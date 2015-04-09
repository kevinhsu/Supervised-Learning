% Set the number of repeating
iteration = 200;
MSE_train1 = [];
MSE_test1 = [];
MSE_train2 = [];
MSE_test2 = [];

for i = 1:iteration
    
    % Generate random numbers which satisfy standard distribution.
    w = randn(10,1);
    X = randn(600,10);
    n = randn(600,1);
    y = X * w + n;
    
    % Split the date set into training set and test set.
    X_train1 = X(1:100,:);
    y_train1 = y(1:100,:);
    
    X_train2 = X(1:10,:);
    y_train2 = y(1:10,:);
    
    X_test = X(101:600,:);
    y_test = y(101:600,:);
    
    % Generate Gamma
    IndexofLamda = -6:1:3;
    Lamda = 10.^IndexofLamda;
    [k,~] = size(Lamda');
    
    % Compute training set and test set mean squared errors for all Gamma
    for j = 1:k
        w_star1 = (X_train1'*X_train1 + Lamda(j)*100*eye(10)) \ (X_train1'*y_train1);
        MSE_train1(i,j) = (y_train1 - X_train1*w_star1)' * (y_train1 - X_train1*w_star1) / 100;
        MSE_test1(i,j) = (y_test - X_test*w_star1)' * (y_test - X_test*w_star1) / 500;
        
        w_star2 = (X_train2'*X_train2 + Lamda(j)*10*eye(10)) \ (X_train2'*y_train2);
        MSE_train2(i,j) = (y_train2 - X_train2*w_star2)' * (y_train2 - X_train2*w_star2) / 10;
        MSE_test2(i,j) = (y_test - X_test*w_star2)' * (y_test - X_test*w_star2) / 500;
    end
    
    [~,J] = min(MSE_train1(i,:));
    BestLamda1(i) = IndexofLamda(J);
    w_star1 = (X_train1'*X_train1 + (10^BestLamda1(i))*100*eye(10)) \ (X_train1'*y_train1);
    y_train1_hat = X_train1*w_star1;
    y_test_hat = X_test*w_star1;
    SD_test1(i) = sqrt(MSE_test1(i,J) - (mean(y_test-y_test_hat))^2);
    MSE_test1_best(i) = MSE_test1(i,J);
    
    [~,J] = min(MSE_train2(i,:));
    BestLamda2(i) = IndexofLamda(J);
    w_star2 = (X_train2'*X_train2 + (10^BestLamda2(i))*10*eye(10)) \ (X_train2'*y_train2);
    y_train2_hat = X_train2*w_star2;
    y_test_hat = X_test*w_star2;
    SD_test2(i) = sqrt(MSE_test2(i,J) - (mean(y_test-y_test_hat))^2);
    MSE_test2_best(i) = MSE_test2(i,J);
end

MSE_train1 = mean(MSE_train1);
MSE_train2 = mean(MSE_train2);
MSE_test1 = mean(MSE_test1);
MSE_test2 = mean(MSE_test2);

SD_test1 = mean(SD_test1);
SD_test2 = mean(SD_test2);
MSE_test1_best = mean(MSE_test1_best);
MSE_test2_best = mean(MSE_test2_best);

% Plot MSE of training and test set
subplot(1,2,1);
hold on;
plot(IndexofLamda, MSE_train1,'b');
plot(IndexofLamda, MSE_test1,'r');

subplot(1,2,2);
hold on;
plot(IndexofLamda, MSE_train2,'b');
plot(IndexofLamda, MSE_test2,'r');


