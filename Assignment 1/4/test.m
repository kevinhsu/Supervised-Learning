m = 10;
n = 4;
data = SLgeneratedata(m,n);

% split data
[m,n] = size(data);
X = data(1:m,2:n);
Y = data(1:m,1);

record = [];
for i = 1:size(X_test,1)
    if i == 1
        count = 1;
        record(1,:) = X_test(1,:);
    else
        test2 = [];
        for j = 1:size(record,1)
            test2(j) = min(unique(X_test(i,:) == record(j,:))); %?????????
        end
        if max(test2) ~= 1
            count = count + 1;
            record(count,:) = X_test(i,:);
        end
    end
end

sum_G = 0;
Y_test_hat = sign(w'*record');
for j = 1:size(record,1)
    count = 0;
    sum = 0;
    for i = 1:size(X_test,1)
        if min(record(j,:) == X_test(i,:)) ~= 0
            count = count + 1;
            sum = sum + (Y_test_hat(j) ~= Y_test(i));
        end
    end
    sum_G = sum_G + sum/m;
end
error_rate = sum_G;

end








% X_temp = X;
% X_record = [];
% while size(X_temp,1) ~= 0
%     X_record(end+1,:) = X_temp(1,:);
%     for i = 1:size(X_temp);
%         if size(X_temp,1) ~= 0
%             break;
%         end
%         if unique(X_record(end,:) == X_temp(i,:)) == 1
%             X_temp(i,:) = [];
%         end
%     end
% end





% count = 0;
% while size(X,1) ~= 0
%     [M,~] = size(X);
%     count = count + 1;
%     X_s(count,1,:) = X(1,:);
%     Y_s(count,1) = Y(1);
%     if M == 1
%         break;
%     elseif M >= 2
%         for i = 2:M
%             if unique(X(1,:) == X(i,:)) == 1
%                 X_s(count,end+1,:) = X(i,:);
%                 Y_s(count,end+1,:) = Y(i);
%                 X(i,:) = [];
%                 Y(i) = [];
%             end
%         end
%     end
% end