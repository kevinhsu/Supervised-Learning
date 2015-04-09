function Alpha = kridgereg(K, y, Lamda)

[l,~] = size(K);
Alpha = (K(1:l,1:l) + Lamda * l * eye(l)) \ y(1:l);
