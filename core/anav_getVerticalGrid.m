function [ grid , map ] = anav_getVerticalGrid( plane_model, floor_centroid, X_scene, voxel_number, voxel_size )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % 
    d = 1000;

    % generate floor rotation (or floor coordinate system)
    [ plane_normal, d_sign ] = anav_flipNormalTowardCamera( plane_model.Normal, floor_centroid );
    [ plane_R ] = anav_generateRotationX( plane_normal );
        
    % camera projection onto floor plane (robot position)
    [ camera_dist ] = plane2pointDist( plane_normal, d_sign*plane_model.Parameters(4), [0 0 0] );
    [ camera_proj ] = projectPoint2Plane( plane_normal, camera_dist, [0 0 0]);

    p1 = camera_proj + (d * plane_R(3,:));
    
     % generate grid (centered)
    [ grid ] = anav_generateGrid3d( voxel_number, voxel_size);
    
    % rotate to align to plane (the grid it is not over )
    grid = (grid * plane_R) + repmat( [0,-1*voxel_number(2)*voxel_size(2)/2,voxel_number(3)*voxel_size(3)/2], size(grid,1), 1 );
    yoffset = max(grid(2,:));
    grid = grid - repmat( [0,yoffset,0], size(grid,1), 1 );
    grid = grid + repmat(p1, size(grid,1), 1 );
    
    [ map ] = anav_occupancyGrid( grid, voxel_number, X_scene );
    
end
