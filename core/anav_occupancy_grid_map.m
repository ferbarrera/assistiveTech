function [ map ] = anav_occupancy_grid_map( voxel_number, grid, points )

[ map, x_bins, z_bins ] = anav_generateMapBins( voxel_number, grid );

for i = 1:size(points,1)
    [ index_x ] = anav_getBin( x_bins, points(i,1) );
    [ index_z ] = anav_getBin( z_bins, points(i,3) );
    
    if ((index_x ~= -1) && (index_z ~= -1))
        map(index_z,index_x) = map(index_z,index_x) + 1;
    end
    
end

map = flipud( map );

end