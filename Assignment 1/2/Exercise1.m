iteration = 200;
MSE_table = [];
MSE_train1 = [];
MSE_test1 = [];
MSE_train2 = [];
MSE_test2 = [];

for i = 1:iteration
    
    w = randn(1,1);
    X = randn(600,1);
    n = randn(600,1);
    y = X * w + n;
    
    X_train1 = X(1:100,:);
    y_train1 = y(1:100,:);
    
    X_train2 = X(1:10,:);
    y_train2 = y(1:10,:);
    
    X_test = X(101:600,:);
    y_test = y(101:600,:);
    
    w_star1 = (X_train1'*X_train1) \ (X_train1'*y_train1);
    MSE_train1(i) = (y_train1 - X_train1*w_star1)' * (y_train1 - X_train1*w_star1) / 100;
    MSE_test1(i) = (y_test - X_test*w_star1)' * (y_test - X_test*w_star1) / 500;
    
    w_star2 = (X_train2'*X_train2) \ (X_train2'*y_train2);
    MSE_train2(i) = (y_train2 - X_train2*w_star2)' * (y_train2 - X_train2*w_star2) / 10;
    MSE_test2(i) = (y_test - X_test*w_star2)' * (y_test - X_test*w_star2) / 500;
end

MSE_table(1,1) = mean(MSE_train1);
MSE_table(1,2) = mean(MSE_test1);
MSE_table(2,1) = mean(MSE_train2);
MSE_table(2,2) = mean(MSE_test2);
MSE_table