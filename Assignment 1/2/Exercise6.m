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
    
    % Differently split the date set into training set and test set for 5 times.
    for f = 1:5
        
        num_of_fold = 20;
        if f == 1
            X_train1_valid = X(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            X_train1_train = X((f*num_of_fold+1):100,:);
            y_train1_valid = y(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            y_train1_train = y((f*num_of_fold+1):100,:);
        elseif 1 < f && f < 5
            X_train1_train = X(1:((f-1)*num_of_fold),:);
            X_train1_valid = X(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            X_train1_train = [X_train1_train; X((f*num_of_fold+1):100,:)];
            y_train1_train = y(1:((f-1)*num_of_fold),:);
            y_train1_valid = y(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            y_train1_train = [y_train1_train; y((f*num_of_fold+1):100,:)];
        elseif f == 5
            X_train1_train = X(1:(100-num_of_fold),:);
            X_train1_valid = X((100-num_of_fold+1):100,:);
            y_train1_train = y(1:(100-num_of_fold),:);
            y_train1_valid = y((100-num_of_fold+1):100,:);
        end
        
        num_of_fold = 2;
        if f == 1
            X_train2_valid = X(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            X_train2_train = X((f*num_of_fold+1):10,:);
            y_train2_valid = y(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            y_train2_train = y((f*num_of_fold+1):10,:);
        elseif 1 < f && f < 5
            X_train2_train = X(1:((f-1)*num_of_fold),:);
            X_train2_valid = X(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            X_train2_train = [X_train2_train; X((f*num_of_fold+1):10,:)];
            y_train2_train = y(1:((f-1)*num_of_fold),:);
            y_train2_valid = y(((f-1)*num_of_fold+1):(f*num_of_fold),:);
            y_train2_train = [y_train2_train; y((f*num_of_fold+1):10,:)];
        elseif f == 5
            X_train2_train = X(1:(10-num_of_fold),:);
            X_train2_valid = X((10-num_of_fold+1):10,:);
            y_train2_train = y(1:(10-num_of_fold),:);
            y_train2_valid = y((10-num_of_fold+1):10,:);
        end
        
        X_test = X(101:600,:);
        y_test = y(101:600,:);
        
        % Generate Gamma
        IndexofLamda = -6:1:3;
        Lamda = 10.^IndexofLamda;
        [k,~] = size(Lamda');
        
         % Compute training set and test set mean squared errors for all Gamma
        for j = 1:k
            w_star1 = (X_train1_train'*X_train1_train + Lamda(j)*80*eye(10)) \ (X_train1_train'*y_train1_train);
            MSE_train1_train(f,i,j) = (y_train1_train - X_train1_train*w_star1)' * (y_train1_train - X_train1_train*w_star1) / 80;
            MSE_train1_valid(f,i,j) = (y_train1_valid - X_train1_valid*w_star1)' * (y_train1_valid - X_train1_valid*w_star1) / 20;
            MSE_test1(f,i,j) = (y_test - X_test*w_star1)' * (y_test - X_test*w_star1) / 500;
            
            w_star2 = (X_train2_train'*X_train2_train + Lamda(j)*8*eye(10)) \ (X_train2_train'*y_train2_train);
            MSE_train2_train(f,i,j) = (y_train2_train - X_train2_train*w_star2)' * (y_train2_train - X_train2_train*w_star2) / 8;
            MSE_train2_valid(f,i,j) = (y_train2_valid - X_train2_valid*w_star2)' * (y_train2_valid - X_train2_valid*w_star2) / 2;
            MSE_test2(f,i,j) = (y_test - X_test*w_star2)' * (y_test - X_test*w_star2) / 500;
        end
        
    end
    MSE_train1_valid_temp = reshape(mean(MSE_train1_valid),i,k);
    [~,J] = min(MSE_train1_valid_temp(i,:));
    BestLamda1(i) = IndexofLamda(J);
    w_star1 = (X_train1_train'*X_train1_train + (10^BestLamda1(i))*80*eye(10)) \ (X_train1_train'*y_train1_train);
    y_test_hat = X_test*w_star1;
    MSE_test1_temp = reshape(mean(MSE_test1),i,k);
    SD_test1(i) = sqrt(MSE_test1_temp(i,J) - (mean(y_test-y_test_hat))^2);
    MSE_test1_best(i) = MSE_test1_temp(i,J);    
    
    MSE_train2_valid_temp = reshape(mean(MSE_train2_valid),i,k);
    [~,J] = min(MSE_train2_valid_temp(i,:));
    BestLamda2(i) = IndexofLamda(J);
    w_star2 = (X_train2_train'*X_train2_train + (10^BestLamda2(i))*8*eye(10)) \ (X_train2_train'*y_train2_train);
    y_test_hat = X_test*w_star2;
    MSE_test2_temp = reshape(mean(MSE_test2),i,k);
    SD_test2(i) = sqrt(MSE_test2_temp(i,J) - (mean(y_test-y_test_hat))^2);
    MSE_test2_best(i) = MSE_test2_temp(i,J);
    
end

MSE_train1_train = reshape(mean(mean(MSE_train1_train)),1,10);
MSE_train2_train = reshape(mean(mean(MSE_train2_train)),1,10);
MSE_train1_valid = reshape(mean(mean(MSE_train1_valid)),1,10);
MSE_train2_valid = reshape(mean(mean(MSE_train2_valid)),1,10);
MSE_test1 = reshape(mean(mean(MSE_test1)),1,10);
MSE_test2 = reshape(mean(mean(MSE_test2)),1,10);
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