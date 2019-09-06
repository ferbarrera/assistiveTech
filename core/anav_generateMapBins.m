function [ map, x_bins, z_bins ] = anav_generateMapBins( voxel_number, grid )

map = zeros(voxel_number(3), voxel_number(1));

z_bins = grid(1:voxel_number(3)+1, 3);
x_bins = grid(1:voxel_number(3)+1:size(grid,1), 1);

end

