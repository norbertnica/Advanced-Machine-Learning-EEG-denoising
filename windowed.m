function [eigenvalues_normal_all, eigenvalues_abnormal_all] = windowed(pn, Fs, t, deg )
% windowed
%   Calculates eigenvalues for several windows.
%
% INPUT
%   n   : Patient number n
%   Fs  : Sampling frequency/ amount of data per second
%   t   : Window length in seconds
%   deg : Degree of window overlap
%
% OUTPUT
%   eigenvalues_normal_all   : matrix containing eigenvalues of the normal data
%   eigenvalues_abnormal_all : matrix containing eigenvalues of the abnormal data

% Getting the data sets
[ndata, abndata] = pickDataSet(pn);

% Initilaising window parameters
wl = t*Fs;  % Window length in samples
ov = floor(deg*wl); % Overlap of the windows

% Calculating eigenvalues of the normal data
eigenvalues_normal_all = cell(size(ndata,2),1);

% The loop always leaves a few data points at the end, when they're not
% fitting to the last window
for k = 1:size(ndata,2)
    data = ndata{k};
    l = size(data,2); %length of data
    n = floor((l-wl)/(wl-ov)+1); % amount of windows
    
    eigenvalues = zeros(n,13);
    for i=0:n-1
        % Getting data points for the specific window
        if i==0
            x=data(:,1:wl);
        else
            x=data(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        % Calculate eigenvalues
        [~,~,lambda]=pca(x,'Economy','on');
        eigenvalues(i+1,:) = lambda;
    end
    eigenvalues_normal_all{k}=eigenvalues;
end

% Calculating eigenvalues of the abnormal data
eigenvalues_abnormal_all = cell(size(abndata,2),1);

% The loop always leaves a few data points at the end, when they're not
% fitting to the last window
for k = 1:size(abndata,2)
    data = abndata{k};
    l = size(data,2); %%length of data
    n = floor((l-wl)/(wl-ov)+1);
    
    eigenvalues = zeros(n,13);
    for i=0:n-1
        % Getting data points for the specific window
        if i==0
            x=data(:,1:wl);
        else
            x=data(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        % Calculate eigenvalues
        [~,~,lambda]=pca(x,'Economy','on');
        eigenvalues(i+1,:) = lambda;
    end
    eigenvalues_abnormal_all{k}=eigenvalues;
end

eigenvalues_normal_all = cell2mat(eigenvalues_normal_all);
eigenvalues_abnormal_all = cell2mat(eigenvalues_abnormal_all);

end
