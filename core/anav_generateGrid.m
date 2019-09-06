function [ Xa ] = anav_generateGrid( number_voxel, voxel_size)
%
%

% generate voxels
[x,z] = meshgrid(0:1:number_voxel(1), 0:1:number_voxel(3) );
y = repmat(0, size(x) );

% transformation initial
t0 = [number_voxel(1)*voxel_size(1)/2 0 0];

% generate grid
Xa = [x(:)*voxel_size(1) y(:)*voxel_size(1) z(:)*voxel_size(1)] - repmat(t0, numel(x), 1);

end

