function [ map, grid ] = anav_generateMapping( plane_model, floor_centroid, X_scene, voxel_number, voxel_size )

    % minimun distance from floor to voxelation
    dmin = 100;

    % generate floor rotation (or floor coordinate system)
    [ plane_normal, d_sign ] = anav_flipNormalTowardCamera( plane_model.Normal, floor_centroid );
    [ plane_R ] = anav_generateRotation( plane_normal );
        
    % camera projection onto floor plane (robot position)
    [ camera_dist ] = plane2pointDist( plane_normal, d_sign*plane_model.Parameters(4), [0 0 0] );
    [ camera_proj ] = projectPoint2Plane( plane_normal, camera_dist, [0 0 0]);
        
    % Proyect all the point cloud to plane
    [ pp_dist ] = plane2pointDist( plane_normal, d_sign*plane_model.Parameters(4), X_scene(1:3,:)' );
    valid_proj = pp_dist>dmin; % 10 cm above floor
    obstacles = X_scene(1:3,valid_proj)';
    [obstacles_proj] = projectPoint2Plane( plane_normal, pp_dist(valid_proj), obstacles);
    
    % Rotate and translate obstacles
    [ obstacles_2d ] = anav_applyT( obstacles_proj, plane_R, camera_proj );
    [ obstacles_2d ] = anav_rotate_y( obstacles_2d, -pi/2 );
        
    % generate grid
    [ grid ] = anav_generateGrid( voxel_number, voxel_size);
    [ map ] = anav_occupancy_grid_map(voxel_number, grid, obstacles_2d);
    map = map>0;
    
    grid = anav_applyT( grid, plane_R, camera_proj );
    grid = anav_rotate_y( grid, -pi/2 );
end

