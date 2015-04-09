function MSE = dualcost(K, y, Alpha)

[l,N] = size(K);
MSE = (1/l) * (K(1:l,1:N) * Alpha - y(1:l))' * (K(1:l,1:N) * Alpha - y(1:l));


