function [B] = cross_validation(persons,top)
Accuracy = zeros((top+1)/2,2);
B = zeros((top+1)/2,2,size(persons,2)*10);
count = 1;
for k = persons
    [eigenvalues_normal_all, eigenvalues_abnormal_all] = windowedFanny(k, 128, 1, 0.1 );
    for n=1:10
        [train,train_labels,test,test_labels]=classifier_initFanny(eigenvalues_normal_all, eigenvalues_abnormal_all,0.8);
        X = train;
        Y = train_labels;
        for num = 1:2:top
            Mdl = fitcknn(X,Y,'NumNeighbors',num);
            p =predict(Mdl,test);
            err = 1- sum((p-test_labels).^2)/(size(p,1));
            Accuracy((num+1)/2,2)=err;
            Accuracy((num+1)/2,1)=num;
        end
        B(:,:,count)=Accuracy;
        count = count +1;
    end
end
mean(B,3)
plot(ans(:,2))