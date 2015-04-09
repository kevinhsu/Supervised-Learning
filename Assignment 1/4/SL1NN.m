function complexity = SL1NN

warning off;
complexity = [];
for ii = 1:5
    for n = 2:18
        
        m = n^2;
        error_rate = 1;
        
        while error_rate > 0.1
            
            m = ceil(m * (n^(1/n^2))); %tarde-off n^(1/n)
            data = sign(rand(m,n) - 0.5);
            
            % split data
            X = data(1:m,1:n);
            Y = data(1:m,1);
            
            data_test = sign(rand(2*m,n) - 0.5);
            X_test = data_test(1:2*m,1:n);
            Y_test = data_test(1:2*m,1);
            
            Y_test_hat = knnclassify(X_test, X, Y, 1);
            error_rate = sum(Y_test_hat~=Y_test)/size(X_test,1);   %show misclassification rate
            
        end
        complexity(ii,n-1)= m;
    end
 
end
complexity = mean(complexity)';

plot(2:18,complexity,'b');



