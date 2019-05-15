function [A] = procedure1(person_numbers)

A = zeros(length(person_numbers),2);
it=1;
for number = person_numbers
    pn = number; %person number
    tmp = num2str(pn)+".edf";
    [metadata,y]=edfread(tmp);
    data = y(1:end-1,:);
    
    %window parameters
    Fs = metadata.frequency(1); % sampling frequency/ data points per second
    t = 1;      % window length in seconds
    wl = t*Fs;  % window length in samples
    deg = 0.1; %degree of overlap of windows
    ov = floor(deg*wl); % overlap of the windows
    
    l = size(data,2); % length of data
    n = floor((l-wl)/(wl-ov)+1); % amount of windows
    
    percentTrain = 0.8;
    %initialize classifier
    [eigenvalues_normal_all, eigenvalues_abnormal_all] = windowed(pn, Fs, t, deg );
    [train, train_labels, test, test_labels] = classifier_init(eigenvalues_normal_all, eigenvalues_abnormal_all, percentTrain);
    
    %% Reconstruct data through sliding window using PCA and KNN
    [data_reconstructed] = reconstruct(data, train, train_labels, n, wl, ov);
    
    %% reconstructed data PCA
    l_rec = size(data_reconstructed,2); % length of data
    n = floor((l_rec-wl)/(wl-ov)+1); % amount of windows
    eigenvalues_reconstructed = zeros(n,13);
    for i=0:n-1
        % Picking out window of data
        if i==0
            x=data_reconstructed(:,1:wl);
        else
            x=data_reconstructed(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        
        % Make PCA on data
        [~,~,lambda]=pca(x,'Economy','on');
        eigenvalues_reconstructed(i+1,:) = lambda;
    end
    acc = validate(test,test_labels,eigenvalues_reconstructed);
    A(it,:) = [pn,acc];
    it=it+1;
end

