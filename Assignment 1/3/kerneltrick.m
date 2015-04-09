function K = kerneltrick(X1, X2, Sigma)

[M1,~] = size(X1);
[M2,~] = size(X2);

for i = 1:M1
    for j = 1:M2
        K(i,j) = exp(-(norm(X1(i,:) - X2(j,:))^2) / (2 * Sigma^2));
    end
end

