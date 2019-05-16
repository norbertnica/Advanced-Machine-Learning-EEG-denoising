function [B,I,U,M,s] = ordered_ica(x)
    evalc('[weights,spheres] = runica(x)');
    %weights
    %spheres
    U = weights*spheres;
    M = inv(U);
    s = U*x;
    powers = sum(abs(s).^2,2);
    [B,I]=sort(powers,'descend');
    
end