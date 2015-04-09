% Set the number of repeating
iteration = 200;
MSE_train1_train = [];
MSE_train1_valid = [];
MSE_test1 = [];
MSE_train2_train = [];
MSE_train2_valid = [];
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
    
    X_train1_train = X(1:80,:);
    X_train1_valid = X(81:100,:);
    y_train1_train = y(1:80,:);
    y_train1_valid = y(81:100,:);
    
    X_train2_train = X(1:8,:);
    X_train2_valid = X(9:10,:);
    y_train2_train = y(1:8,:);
    y_train2_valid = y(9:10,:);
    
    X_test = X(101:600,:);
    y_test = y(101:600,:);
    
    % Generate Gamma
    IndexofLamda = -6:1:3;
    Lamda = 10.^IndexofLamda;
    [k,~] = size(Lamda');
    
    % Compute training set and test set mean squared errors for all Gamma
    for j = 1:k
        w_star1 = (X_train1_train'*X_train1_train + Lamda(j)*80*eye(10)) \ (X_train1_train'*y_train1_train);
        MSE_train1_train(i,j) = (y_train1_train - X_train1_train*w_star1)' * (y_train1_train - X_train1_train*w_star1) / 80;
        MSE_train1_valid(i,j) = (y_train1_valid - X_train1_valid*w_star1)' * (y_train1_valid - X_train1_valid*w_star1) / 20;
        MSE_test1(i,j) = (y_test - X_test*w_star1)' * (y_test - X_test*w_star1) / 500;
        
        w_star2 = (X_train2_train'*X_train2_train + Lamda(j)*8*eye(10)) \ (X_train2_train'*y_train2_train);
        MSE_train2_train(i,j) = (y_train2_train - X_train2_train*w_star2)' * (y_train2_train - X_train2_train*w_star2) / 8;
        MSE_train2_valid(i,j) = (y_train2_valid - X_train2_valid*w_star2)' * (y_train2_valid - X_train2_valid*w_star2) / 2;
        MSE_test2(i,j) = (y_test - X_test*w_star2)' * (y_test - X_test*w_star2) / 500;
    end
    
    [~,J] = min(MSE_train1_valid(i,:));
    BestLamda1(i) = IndexofLamda(J); %find the best Gamma
    w_star1 = (X_train1'*X_train1 + (10^BestLamda1(i))*100*eye(10)) \ (X_train1'*y_train1);
    y_test_hat = X_test*w_star1; %Prediction of test set
    SD_test1(i) = sqrt(MSE_test1(i,J) - (mean(y_test-y_test_hat))^2); %Calculate standard deviation
    MSE_test1_best(i) = MSE_test1(i,J); %Calculate test error
    
    [~,J] = min(MSE_train2_valid(i,:));
    BestLamda2(i) = IndexofLamda(J); %find the best Gamma
    w_star2 = (X_train2'*X_train2 + (10^BestLamda2(i))*10*eye(10)) \ (X_train2'*y_train2);
    y_test_hat = X_test*w_star2; %Prediction of test set
    SD_test2(i) = sqrt(MSE_test2(i,J) - (mean(y_test-y_test_hat))^2); %Calculate standard deviation
    MSE_test2_best(i) = MSE_test2(i,J); %Calculate test error
    
end

MSE_train1_train = mean(MSE_train1_train);
MSE_train2_train = mean(MSE_train2_train);
MSE_train1_valid = mean(MSE_train1_valid);
MSE_train2_valid = mean(MSE_train2_valid);
MSE_test1 = mean(MSE_test1);
MSE_test2 = mean(MSE_test2);
BestLamda1 = mean(BestLamda1);
BestLamda2 = mean(BestLamda2);

SD_test1 = mean(SD_test1);
SD_test2 = mean(SD_test2);
MSE_test1_best = mean(MSE_test1_best);
MSE_test2_best = mean(MSE_test2_best);

% Plot MSE of training and test set
subplot(1,2,1);
hold on;
plot(IndexofLamda, MSE_train1_train,'b');
plot(IndexofLamda, MSE_train1_valid,'g');
plot(IndexofLamda, MSE_test1,'r');

subplot(1,2,2);
hold on;
plot(IndexofLamda, MSE_train2_train,'b');
plot(IndexofLamda, MSE_train2_valid,'g');
plot(IndexofLamda, MSE_test2,'r');

