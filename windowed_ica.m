function [p_normal_all, p_abnormal_all] = windowed_ica(pn, Fs, t, deg )
% windowed
%   Calculates powers for several windows.
%
% INPUT
%   n   : Patient number n
%   Fs  : Sampling frequency/ amount of data per second
%   t   : Window length in seconds
%   deg : Degree of window overlap
%
% OUTPUT
%   p_normal_all   : matrix containing powers of the normal data
%   p_abnormal_all : matrix containing powers of the abnormal data

% Getting the validation sests
[ndata, abndata] = pickDaset(pn);

% Initilaising window parameters
wl = t*Fs;  % Window length in samples
ov = floor(deg*wl); % Overlap of the windows

% Calculating eigenvalues of the normal data
p_normal_all = cell(size(ndata,2),1);

% The loop always leaves a few data points at the end, when they're not
% fitting to the last window
for k = 1:size(ndata,2)
    data = ndata{k};
    l = size(data,2); %length of data
    n = floor((l-wl)/(wl-ov)+1); % amount of windows
    
    ps = zeros(n,14);
    for i=0:n-1
        % Getting data points for the specific window
        if i==0
            x=data(:,1:wl);
        else
            x=data(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        % Calculate powers
        [p,order]=ordered_ica(x);
        ps(i+1,:) = p;
    end
    p_normal_all{k}=ps;
end

% Calculating eigenvalues of the abnormal data
p_abnormal_all = cell(size(abndata,2),1);

% The loop always leaves a few data points at the end, when they're not
% fitting to the last window
for k = 1:size(abndata,2)
    data = abndata{k};
    l = size(data,2); %%length of data
    n = floor((l-wl)/(wl-ov)+1);
    
    ps = zeros(n,14);
    for i=0:n-1
        % Getting data points for the specific window
        if i==0
            x=data(:,1:wl);
        else
            x=data(:,i*(wl-ov):i*(wl-ov)+wl);
        end
        % Calculate powers
        [p,order]=ordered_ica(x);
        ps(i+1,:) = p;
    end
    p_abnormal_all{k}=ps;
end

p_normal_all = cell2mat(p_normal_all);
p_abnormal_all = cell2mat(p_abnormal_all);

end
