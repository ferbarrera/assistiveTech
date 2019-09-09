function [ depthmap ] = anav_getDepthmapfromX( X, dim_X )
%UNTITLED2 Summary of this function goes here
%   X is 3xN or 4xN

depthmap = zeros(dim_X(1), dim_X(2), 3);

for j = 1:3
    depthmap(:,:,j) = reshape( X(j,:), dim_X(1), dim_X(2)); 
end
