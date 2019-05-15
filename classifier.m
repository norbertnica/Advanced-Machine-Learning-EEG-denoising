function [n_eigen] = classifier(train,train_labels,v)
% classifier
%   This function classifies first 3 biggest eigenvalues to be either normal or abnormal.
%
% INPUT
%   train        : The training set containing normal and abnormal eigenvalues.
%   train_labels : The labels of the data in train, 0=normal and 1=abnormal.
%   v            : The data that will be classified.
%
% OUTPUT
%   n_eigen      : How many pca's to remove

k = 1;
tmp = true;

while tmp
    x = train(:,k);
    y = train_labels;
    model = fitcknn(x,y,'NumNeighbors',3);
    z = predict(model,v(:,k));
    
    if z == 1 % z is classified as abnormal.
        k = k+1;
        if k>3
            tmp = false;
        end
    else % z is classified as normal.
        tmp = false;
    end
end
n_eigen = k-1;

end
