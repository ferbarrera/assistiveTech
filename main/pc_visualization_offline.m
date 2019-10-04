% ----------------------------------------------
% - Visualize a set of Point Clouds from disk
% ----------------------------------------------

clear all;
close all;

%% Parameters

seq_name = '20190924_14-00_visuallyImpaired';
camera_k_mat = 'kinect_v2_color_k_2019';        % kinectV2_ref 
camera_dist_mat = 'kinect_v2_color_dist_2019';  % kinectV2_ref 
im_counter = 0;

% point cloud limits
xlimits = [-2500 2500];
ylimits = [-2500 2500];
zlimits = [0 6000];

% plane detection algorithm
maxDistance = 150;
referenceNormal = [0,1,0.1];
maxAngularDistance = 10;

% voxel size
voxel_size = [50 50 50];
voxel_number = [80 1 100];


%% code

seq_path = strcat('../dataset/', seq_name, '/');

% load camera parameters
[ K ] = loadCameraIntrinsic( camera_k_mat );
[ dist ] = loadCameraDistortion( camera_dist_mat );

% player setup 
player = pcplayer(xlimits,ylimits,zlimits,'VerticalAxis','Y','VerticalAxisDir','Down');
xlabel(player.Axes,'X (mm)');
ylabel(player.Axes,'Y (mm)');
zlabel(player.Axes,'Z (mm)');
hold(player.Axes,'on');

%view
%camtarget(player.Axes,[0 0 2000]);
%campos(player.Axes,[0 -2000 -2000]);

%view
campos(player.Axes,[31.19 -42.38 -5.75]);
camtarget(player.Axes,[0 0 3025]);
%view(player.Axes,52.35,-75.25);

%view
%campos(player.Axes,[2800 -1550 1930]);
%camtarget(player.Axes,[0 0 3525]);

% 2D 
figure('Name', '3D to 2D mapping');
mapping2Daxe = gca;
init3dto2dFloorMap( mapping2Daxe, voxel_number, voxel_size);

stop = false;

while (isOpen(player) && not(stop))
    
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
        
        % scale depth image
        [depth] = scaleImage(depth, size(color,1), size(color,2));
        
        % getting 3d information
        [ X, X_valid, valid_depth_mask ] = anav_getXfromDepthmap( depth, K, dist );
        
        % getting colors
        C = reshape(color, numel(color)/3, 3);
        C_valid = C(valid_depth_mask,:);
        
        % colored point cloud
        ptCloud = pointCloud( X_valid(1:3,:)', 'Color', C_valid );
        
        % compute floor plane
        [ floor_normal, floor_centroid, plane_model, inlierIndices, outlierIndices ] = getFloorPlane( ptCloud, ...
            maxDistance, referenceNormal, maxAngularDistance);
        
        % highlight detected floor
        if (inlierIndices > 0)
            ptCloud.Color(inlierIndices,3) = 255;         
        end
                
        % generate floor rotation (or floor coordinate system)
        [ plane_normal, d_sign ] = anav_flipNormalTowardCamera( floor_normal, floor_centroid );
        [ plane_R ] = anav_generateRotation( plane_normal );
        
        
        % plot mapping 3d-to-2d
        [ map , grid ] = anav_generateMapping( plane_model, floor_centroid, X_valid(:,outlierIndices), voxel_number, voxel_size);
        imagesc( mapping2Daxe, 'CData', map ); 
        drawnow;
        
        % viewer
        view(player, ptCloud);
        % delete previous plots
        plot_handles = get(player.Axes,'Children');
        if (numel(plot_handles)>1)
            delete(plot_handles(1:end-1));
        end
        
        % add new plots
        plotAxe( player.Axes, plane_R, floor_centroid ); % draw plane axe
        
        ind_first_layer=(voxel_number(1)+1)*(voxel_number(3)+1);
        scatter3(player.Axes,grid(1:16:ind_first_layer,1),grid(1:16:ind_first_layer,2),grid(1:16:ind_first_layer,3),'MarkerEdgeColor','k','MarkerFaceColor',[.9 0.1 .1]);
        
        drawnow;
    else
        %stop = true;
        %im_counter = 0;
    end
    
    im_counter = im_counter + 1;
    fprintf('frame %d \n', im_counter);
    
end


fprintf('Closing ...\n');