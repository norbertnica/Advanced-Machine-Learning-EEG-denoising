function [A] = procedure2(person_numbers)

A = zeros(length(person_numbers),2);
it = 1;

%% initialize window parameters
Fs = 128; % sampling frequency
t = 1; % window length in seconds
deg = 0.1; %degree of overlap of windows
wl = t*Fs;  % window length in samples
ov = floor(deg*wl); % overlap of the windows
percentTrain = 0.8;

%% leave-one-out approach
% out - patient that stays out of the training set;
%in - patients in the training set

for out = person_numbers
    %eigenvalues for all patients
    E_normal = [];
    E_abnormal = [];
    
    %determine 'in' vector
    in = person_numbers;
    in(in==out) = [];
    %% get eigenvaleues from all patients
    for pn = in
        [eigenvalues_normal_all, eigenvalues_abnormal_all] = windowed(pn, Fs, t, deg );
        E_normal = [E_normal;eigenvalues_normal_all];
        E_abnormal = [E_abnormal;eigenvalues_abnormal_all];
    end
    %% prepare trainig and test data
    [train, train_labels, test, test_labels] = classifier_init(E_normal, E_abnormal, percentTrain);
    %% evaluate the 'out' patient
    tmp = num2str(out)+".edf";
    [~,y]=edfread(tmp);
    data = y(1:end-1,:);
    
    %window parameters
    l = size(data,2); % length of data
    n = floor((l-wl)/(wl-ov)+1); % amount of windows
    
    %% Reconstruct data through sliding window using PCA and KNN
    [data_reconstructed] = reconstruct(data, train, train_labels, n);
    
    %% reconstructed data PCA
    
    l = size(data_reconstructed,2); % length of data
    n = floor((l-wl)/(wl-ov)+1); % amount of windows
    eigenvalues_reconstructed = zeros(n,13);
    for i=0:n-1
        % Picking out window of data
        if i==0
            x=data_reconstructed(:,1:wl);
        else
            x=data_reconstructed(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        
        % Do a PCA on data
        [~,~,lambda]=pca(x,'Economy','on');
        eigenvalues_reconstructed(i+1,:) = lambda;
    end
    %% validate on unseen healthy data
    acc = validate(test,test_labels,eigenvalues_reconstructed);
    A(it,:) = [out,acc];
    it=it+1;
end
