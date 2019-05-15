function [accuracy] = validate(train,train_labels,reconstructed_lambda)
    x = train;
    y = train_labels;
    m1 = fitcknn(x,y,'NumNeighbors',3);
    test1 = reconstructed_lambda;
    labels = zeros(size(test1,1),1);
    p1 = predict(m1,test1); 
    err1 = sum((p1-labels).^2);
    accuracy = (length(p1)-err1)/length(p1);
end
