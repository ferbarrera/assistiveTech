% ----------------------------------------------
% - Visualize a set of Point Clouds from disk
% ----------------------------------------------

clear all;
close all;

%% Parameters

seq_path = '../dataset/20180112_13-00_wheelchair/';
camera_k_mat = 'kinect_v1_color_k_2018';        % kinectV2_ref 
camera_dist_mat = 'kinect_v1_color_dist_2018';  % kinectV2_ref 
im_counter = 279;

% point cloud limits
xlimits = [-3000 3000];
ylimits = [-3000 3000];
zlimits = [50 7000];

% floor detection
maxDistance = 50;   % Set the maximum point-to-plane distance [cm]

% voxel size
voxel_size = [50 50 50];
voxel_number = [80 1 100];

%% code

% 2d mapping
fig_mapping = figure('Name','2D mapping');

% load camera parameters
[ K ] = loadCameraIntrinsic( camera_k_mat );
[ dist ] = loadCameraDistortion( camera_dist_mat );

stop = false;

% player setup 
player = pcplayer(xlimits,ylimits,zlimits);
xlabel(player.Axes,'X (mm)');
ylabel(player.Axes,'Y (mm)');
zlabel(player.Axes,'Z (mm)');

while ( ~stop )
    
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
        [ X ] = anav_getXfromDepthmap( depth, K, dist );
        
        % getting colors
        C = reshape(color, numel(color)/3, 3);
        
        % colored point cloud
        ptCloud = pointCloud( X(1:3,:)', 'Color', C );
        
        % viewer
        view(player, ptCloud);
        
        %
        %[ map ] = anav_generateMapping( plane_model, floor_centroid, X, voxel_number, voxel_size );
        %imagesc( map );        
        
    else
        % stop = true;
        im_counter = 0;
    end
    
    im_counter = im_counter + 1;
    
end
