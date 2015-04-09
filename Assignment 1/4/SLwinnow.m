function complexity = SLwinnow

% Winnow Algorithm: (basic version)
%
% 1. Initialize the weights w_1, ..., w_n of the variables to 1.
%
% 2. Given an example x = (x_1, ..., x_n), output + if
% 	w_1x_1 + w_2x_2 + ... + w_nx_n >= n,
%    else output -.
%
% 3. If the algorithm makes a mistake:
%
%   (a) If the algorithm predicts negative on a positive example, then
%   for each x_i equal to 1, double the value of w_i.
%
%   (b) If the algorithm predicts positive on a negative example, then
%   for each x_i equal to 1, cut the value of w_i in half.
%
% 4. repeat (goto 2)

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
            
            for i = 1:size(X,1)
                for j = 1:size(X,2)
                    if X(i,j) == -1
                        X(i,j) = 0;
                    end
                end
                
                if Y(i) == -1
                    Y(i) = 0;
                end
            end
            
            % init weight vector
            w = ones(n,1);
            
            for iteration = 1:5
                for i = 1:size(X,1)
                    if X(i,:)*w >= n
                        Y_hat(i) = 1;
                    else
                        Y_hat(i) = 0;
                    end
                    if Y_hat(i) ~= Y(i)
                        for j = 1:size(X,2)
                            w(j) = w(j)*2^((Y(i)-Y_hat(i))*X(i,j));
                        end
                    end
                end
            end
            
            data_test = sign(rand(2*m,n) - 0.5);
            X_test = data_test(1:2*m,1:n);
            Y_test = data_test(1:2*m,1);
            
            for i = 1:size(X_test,1)
                for j = 1:size(X_test,2)
                    if X_test(i,j) == -1
                        X_test(i,j) = 0;
                    end
                end
                
                if Y_test(i) == -1
                    Y_test(i) = 0;
                end
            end
            
            count = 0;
            for i = 1:size(X_test,1)
                if X_test(i,:)*w >= n
                    Y_test_hat(i) = 1;
                else
                    Y_test_hat(i) = 0;
                end
                if Y_test_hat(i) ~= Y_test(i)
                    count = count + 1;
                end
            end
            
            error_rate = count/size(X_test,1);
        end
        
        complexity(ii,n-1)= m;
    end
end

complexity = mean(complexity)';

plot(2:100,complexity,'b');

