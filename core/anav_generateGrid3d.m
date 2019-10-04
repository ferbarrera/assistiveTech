function [ Xa ] = anav_generateGrid3d( number_voxel, voxel_size )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% generate voxels
[x,y,z] = meshgrid(0:1:number_voxel(1), 0:1:number_voxel(2), 0:1:number_voxel(3));

% transformation initial
t0 = [number_voxel(1)*voxel_size(1)/2 number_voxel(2)*voxel_size(2)/2 number_voxel(3)*voxel_size(3)/2];

% generate grid
Xa = [x(:)*voxel_size(1) y(:)*voxel_size(2) z(:)*voxel_size(3)] - repmat(t0, numel(x), 1);


end
