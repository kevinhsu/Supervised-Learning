function [MSE_table, SD_table, Mean_BestLamda] = RRregularisationparameter2

% Exercise 4: Method == 1
% Exercise 5: Method == 2
% Exercise 6: Method == 3
Method = 3;
M = 600;
N = 10;
IndexofLamda = -6:1:3;
Lamda = 10.^IndexofLamda;
iteration = 200;

if Method == 1
    [MSE_table, SD_table, Mean_BestLamda] = RRregularisationparameter;
end
      
if Method == 2 || Method == 3

    for i = 1:iteration
        l = 100;
        [MSE_t(i,:), MSE_v(i,:), MSE_te(i,:), MSE_train(i), MSE_test(i), SD_train(i), SD_test(i), BestLamda(i)] = RR2(l, M, N, Lamda, Method);
    end
    
    MSE_t = mean(MSE_t);
    MSE_v = mean(MSE_v);
    MSE_te = mean(MSE_te);
    
    subplot(1,2,1);
    hold on;
    plot(log10(Lamda),MSE_t,'b');
    plot(log10(Lamda),MSE_v,'r');
    plot(log10(Lamda),MSE_te,'g');
    
    MSE_train = mean(MSE_train')';
    MSE_test = mean(MSE_test')';
    SD_train = mean(SD_train')';
    SD_test = mean(SD_test')';
    MSE_table(1,1) = MSE_train;
    MSE_table(1,2) = MSE_test;
    SD_table(1,1) = SD_train;
    SD_table(1,2) = SD_test;
    Mean_BestLamda(1,1) = mean(BestLamda);

    for i = 1:iteration
        l = 10;
        [MSE_t(i,:), MSE_v(i,:), MSE_te(i,:), MSE_train(i), MSE_test(i), SD_train(i), SD_test(i), BestLamda(i)] = RR2(l, M, N, Lamda, Method);
    end
    
    MSE_t = mean(MSE_t);
    MSE_v = mean(MSE_v);
    MSE_te = mean(MSE_te);
    
    subplot(1,2,2);
    hold on;
    plot(log10(Lamda),MSE_t,'b');
    plot(log10(Lamda),MSE_v,'r');
    plot(log10(Lamda),MSE_te,'g');
    
    MSE_train = mean(MSE_train')';
    MSE_test = mean(MSE_test')';
    SD_train = mean(SD_train')';
    SD_test = mean(SD_test')';
    MSE_table(2,1) = MSE_train;
    MSE_table(2,2) = MSE_test;
    SD_table(2,1) = SD_train;
    SD_table(2 ,2) = SD_test;
    Mean_BestLamda(1,2) = mean(BestLamda);
end



