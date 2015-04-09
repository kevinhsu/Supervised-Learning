function data = SLgeneratedata(m,n)

% random samples
data = rand(m,n) - 0.5;
for i = 1:m
    for j = 1:n
        if data(i,j) < 0
            data(i,j) = -1;
        else
            data(i,j) = 1;
        end
    end
end
