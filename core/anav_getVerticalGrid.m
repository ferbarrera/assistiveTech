function [ map , grid ] = anav_getVerticalGrid( plane_model, floor_centroid, X_scene, voxel_number, voxel_size, voxel_distance, voxel_occ_th )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % generate floor rotation (or floor coordinate system)
    [ plane_normal, d_sign ] = anav_flipNormalTowardCamera( plane_model.Normal, floor_centroid );
    [ plane_R ] = anav_generateRotationX( plane_normal );
        
    % camera projection onto floor plane (robot position)
    [ camera_dist ] = plane2pointDist( plane_normal, d_sign*plane_model.Parameters(4), [0 0 0] );
    [ camera_proj ] = projectPoint2Plane( plane_normal, camera_dist, [0 0 0]);

    p1 = camera_proj + (voxel_distance * plane_R(3,:));
    
    % generate grid (centered)
    [ grid ] = anav_generateGrid3d( voxel_number, voxel_size);
    
    % rotate to align to plane (the grid it is not over )
    grid = (grid * plane_R) + repmat( [0,-1*voxel_number(2)*voxel_size(2)/2,voxel_number(3)*voxel_size(3)/2], size(grid,1), 1 );
    yoffset = max(grid(2,:));
    grid = grid - repmat( [0,yoffset,0], size(grid,1), 1 );
    grid = grid + repmat(p1, size(grid,1), 1 );
    
    % valor de 
    step = 255/(voxel_number(3)+1);
    occ_values = uint8( voxel_number(3)*step:-step:step );
    
    begin_ind_layer = 1;
    end_ind_layer = (voxel_number(1)+1)*(voxel_number(2)+1)*2;
    step_ind_layer = (voxel_number(1)+1)*(voxel_number(2)+1);
    occ_map = zeros(voxel_number(2),voxel_number(1),voxel_number(3),'uint16');
    scaled_occ_map = zeros(voxel_number(2),voxel_number(1),voxel_number(3),'uint8');
    
    X_valid = true( 1, size(X_scene,2) );
    
    for c = 1:voxel_number(3)
        %scatter3(grid(begin_ind_layer:end_ind_layer,1),grid(begin_ind_layer:end_ind_layer,2),grid(begin_ind_layer:end_ind_layer,3),'MarkerEdgeColor','k','MarkerFaceColor',[0.5 0.1 .1]);
        
        [ occ_map(:,:,c), X_valid ] = anav_occupancyGrid( grid(begin_ind_layer:end_ind_layer,:), voxel_number, X_scene, X_valid );
        scaled_occ_map(:,:,c) = uint8(uint8(occ_map(:,:,c)>voxel_occ_th)*occ_values(c));
     
        begin_ind_layer = begin_ind_layer + step_ind_layer;
        end_ind_layer = end_ind_layer + step_ind_layer;
    end
    
    map = uint8(max(scaled_occ_map,[],3));
    
end
