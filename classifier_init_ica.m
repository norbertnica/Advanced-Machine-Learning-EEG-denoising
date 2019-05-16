function [train,train_labels,test,test_labels] = classifier_init_ica(p_normal_all, p_abnormal_all,percentTrain)
% classifier_init
%   Makes the training sets
%
% INPUT
%   p_normal_all   : matrix containing powers of the normal data
%   p_abnormal_all : matrix containing powers of the abnormal data
%   percentTrain             : The percentage of the data set that will be used 
%                               for training.
%
% OUTPUT
%   train        : The training set containing normal and abnormal powers
%   train_labels : The labels of the data in train, 0=normal and 1=abnormal.
%   test         : The test set containing normal and abnormal powers.
%   test_labels  : The labels of the data in test, 0=normal and 1=abnormal.

nsize = size(p_normal_all,1);
abnsize = size(p_abnormal_all,1);

% Class imbalance removed
if  abnsize >= nsize
    ind1 = randperm(abnsize,nsize); 
    abn = p_abnormal_all(ind1,:);
    ind2 = randperm(nsize);
    n = p_normal_all(ind2,:);
else
    ind1 = randperm(nsize,abnsize);
    n = p_normal_all(ind1,:);
    ind2 = randperm(abnsize);
    abn = p_abnormal_all(ind2,:);
end
    
nsize = size(n,1);
% Size of training and test set
trainsize = floor(percentTrain*nsize);
testsize = nsize-trainsize;

% Dividing the normal and abnormal data into train and test sets
n_train = n(1:trainsize,:);
n_test = n(trainsize+1:end,:);
abn_train = abn(1:trainsize,:);
abn_test = abn(trainsize+1:end,:);

% Collecting the data to one test and one training set
train = [n_train;abn_train];
test = [n_test;abn_test];
% Labels for the train and test data 
train_labels = [zeros(trainsize,1);ones(trainsize,1)];
test_labels = [zeros(testsize,1);ones(testsize,1)];

end
