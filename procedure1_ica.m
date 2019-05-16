person_numbers = [1];
A = zeros(length(person_numbers),2);
it=1;
for number = person_numbers
    pn = number; %person number
    tmp = num2str(pn)+".edf";
    [metadata,y]=edfread(tmp);
    data = y(1:end-1,:);
    
    data_reconstructed = zeros(size(data));
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
    [p_normal_all, p_abnormal_all] = windowed_ica(pn, Fs, t, deg );
    [train, train_labels, test, test_labels] = classifier_init_ica(p_normal_all, p_abnormal_all, percentTrain);
    size(train,1)
    size(test,1)
    %% Reconstruct data through sliding window using ICA and KNN

    for i=0:n-1
        % Picking out window of data
        if i==0
            x=data(:,1:wl);
        else
            x=data(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        
        % Make PCA on data
        [p,order,U,M,s]=ordered_ica(x);
        
        n_pows = classifier(train,train_labels,p');
        
        if n_pows > 0 %Power(s) classified as abnormal
            ind=order(1:n_eigen);
            s(ind,:)=s(ind,:).*0;
            x_new = M*s;
            
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
    %% reconstructed data ICA
    Fs = metadata.frequency(1); % sampling frequency/ data points per second
    t = 1;      % window length in seconds
    wl = t*Fs;  % window length in samples
    deg = 0.1; %degree of overlap of windows
    ov = floor(deg*wl); % overlap of the windows

    l = size(data_reconstructed,2); % length of data
    n = floor((l-wl)/(wl-ov)+1); % amount of windows
    powers_reconstructed = zeros(n,14);
    for i=0:n-1
        % Picking out window of data
        if i==0
            x=data_reconstructed(:,1:wl);
        else
            x=data_reconstructed(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        
        % Make ICA on data
         [p,order,U,M,s]=ordered_ica(x);
        powers_reconstructed(i+1,:) = p;
    end
    acc = validate(test,test_labels,powers_reconstructed);
    A(it,:) = [pn,acc];
    it=it+1;
end
