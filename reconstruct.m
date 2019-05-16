function [data_reconstructed] = reconstruct(data, train, train_labels, n, wl, ov)
% reconstruct
%   Saves the eigenvalues and reconstructs the data through sliding window 
%   using PCA and KNN
%
% INPUT
%   data         : All the data points
%   train        : The training set containing normal and abnormal eigenvalues.
%   train_labels : The labels of the data in train, 0=normal and 1=abnormal.
%   n            : Amount of windows
%
% OUTPUT
%   data_reconstructed : The reconstructed data 

data_reconstructed = zeros(size(data));

for i=0:n-1
    % Picking out window of data
    if i==0
        x=data(:,1:wl);
    else
        x=data(:,i*(wl-ov):i*(wl-ov)+wl);
    end
    
    % Make PCA on data
    [coeff,score,lambda]=pca(x,'Economy','on');
    
    n_eigen = classifier(train,train_labels,lambda');
    
    if n_eigen > 0 %Eigenvalue(s) classified as abnormal
        x_new = score(:,n_eigen+1:end)*coeff(:,n_eigen+1:end)'+mean(x,1);
    else
        x_new = x;
    end
    
    % Save the reconstructed data.
    if i==0
        data_reconstructed(:,1:wl) = x_new;
    else
        data_reconstructed(:,i*(wl-ov):i*(wl-ov)+wl) = x_new;
    end
    
end