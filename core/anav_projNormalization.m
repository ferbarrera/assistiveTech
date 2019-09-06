function [ X ] = anav_projNormalization( X )
%ANAV_PROJNORMALIZATION

X = X./repmat(X(end,:),size(X,1),1);

end
