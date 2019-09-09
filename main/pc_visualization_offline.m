% ----------------------------------------------
% - Visualize a set of Point Clouds from disk
% ----------------------------------------------

clear all;
close all;

%% Parameters

seq_path = '../dataset/20180112_13-00_wheelchair/';
camera_k_mat = 'kinect_v1_color_k_2018';        % kinectV2_ref 
camera_dist_mat = 'kinect_v1_color_dist_2018';  % kinectV2_ref 
im_counter = 0;

% point cloud limits
xlimits = [-3000 3000];
ylimits = [-3000 3000];
zlimits = [50 7000];

% plane detection algorithm
maxDistance = 100;
referenceNormal = [0,1,0.1];
maxAngularDistance = 5;

% voxel size
voxel_size = [50 50 50];
voxel_number = [80 1 100];


%% code

% load camera parameters
[ K ] = loadCameraIntrinsic( camera_k_mat );
[ dist ] = loadCameraDistortion( camera_dist_mat );

% player setup 
player = pcplayer(xlimits,ylimits,zlimits);
xlabel(player.Axes,'X (mm)');
ylabel(player.Axes,'Y (mm)');
zlabel(player.Axes,'Z (mm)');
hold(player.Axes,'on');
camproj(player.Axes,'perspective')

% 2D 
figure('Name', '3D to 2D mapping');
mapping2Daxe = axes;

while isOpen(player) 
    
    % color and depth images
    color_im = strcat( seq_path ,'im_color_', num2str(im_counter), '.png');
    depth_im = strcat( seq_path ,'im_depht_', num2str(im_counter), '.png');

    % exist the image
    exist_col_im = exist(color_im, 'file' ) == 2;
    exist_depth_im = exist(depth_im, 'file' ) == 2;
    
    if ( exist_col_im && exist_depth_im )
        
        % reading images
        color = imread( color_im );
        depth = imread( depth_im );
        
        % getting 3d information
        [ X, X_valid, valid_depth_mask ] = anav_getXfromDepthmap( depth, K, dist );
        
        % getting colors
        C = reshape(color, numel(color)/3, 3);
        C_valid = C(valid_depth_mask,:);
        
        % colored point cloud
        ptCloud = pointCloud( X_valid(1:3,:)', 'Color', C_valid );
        
        % compute floor plane
        [ floor_normal, floor_centroid, plane_model ] = getFloorPlane( ptCloud, ...
            maxDistance, referenceNormal, maxAngularDistance);
                
        % generate floor rotation (or floor coordinate system)
        [ plane_normal, d_sign ] = anav_flipNormalTowardCamera( floor_normal, floor_centroid );
        [ plane_R ] = anav_generateRotation( plane_normal );
        
        % viewer
        view(player, ptCloud);
        % delete previous plots
        plot_handles = get(player.Axes,'Children');
        if (numel(plot_handles)>1)
            delete(plot_handles(1:end-1));
        end
        % add new plots
        plotAxe( player.Axes, plane_R, floor_centroid ); % draw plane axe
        
        % plot mapping 3d-to-2d
        [ map ] = anav_generateMapping( plane_model, floor_centroid, X, voxel_number, voxel_size );
        imagesc( mapping2Daxe, map );        
        
    else
        % stop = true;
        im_counter = 0;
    end
    
    im_counter = im_counter + 1;
    
end


fprintf('Closing ...\n');