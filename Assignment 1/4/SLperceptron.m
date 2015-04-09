function complexity = SLperceptron

complexity = [];

for ii = 1:50
    for n = 2:100
        
        m = ceil(sqrt(n))-1;
        error_test = 1;
        
        while error_test > 0.1
            
            m = m + 1;
            
            %Generate data
            data = sign(rand(m,n) - 0.5);
            X = data(1:m,1:n);
            Y = data(1:m,1);
            
            % init weight vector
            w = zeros(n,1);
            
            % call perceptron
            for iteration = 1:50  %in practice, use some stopping criterion!
                for i = 1:size(X,1)         %cycle through training set
                    if sign(X(i,:)*w) ~= Y(i) %wrong decision?
                        w = w + X(i,:)' * Y(i);   %then add (or subtract) this point to w
                    end
                end
            end
            
            data_test = sign(rand(2*m,n) - 0.5);
            X_test = data_test(1:2*m,1:n);
            Y_test = data_test(1:2*m,1);
            
            error_test = sum(sign(X_test*w)~=Y_test)/size(X_test,1);   %test error rate
        end
        
        complexity(ii,n-1)= m;
    end
end

complexity = mean(complexity)';

plot(2:100,complexity,'b');




