function complexity = SLleastsquares

complexity = [];


for ii = 1:50
    for n = 2:100
        
        m = ceil(sqrt(n))-1;
        error_rate = 1;
        
        while error_rate > 0.1
            
            m = m + 1;
            
            % split data
            data = sign(rand(m,n) - 0.5);
            X = data(1:m,1:n);
            Y = data(1:m,1);
            
            w = pinv(X) * Y;
            
            data_test = sign(rand(2*m,n) - 0.5);
            X_test = data_test(1:2*m,1:n);
            Y_test = data_test(1:2*m,1);
            
            error_rate = sum(sign(X_test*w)~=Y_test)/size(X_test,1);
            %show misclassification rate
            
        end
        
        complexity(ii,n-1)= m;
    end
end
complexity = mean(complexity)';

plot(2:100,complexity,'b');

