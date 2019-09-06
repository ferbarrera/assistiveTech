function [ K ] = loadCameraIntrinsic( id )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

K = NaN;

intrinsic_calib_path = '../dataset/cameraParameters/';

k_file = strcat( intrinsic_calib_path, id, '.mat');
exist_k_file = exist( k_file ,'file') == 2;

sub_id = strsplit(id, '_');

if ( exist_k_file )
    K = cell2mat(struct2cell(load( k_file )));
else
    if ( strcmp(sub_id{1}, 'kinectV1') )
        % kinect v1
        K = [528 0 320; 0 528 240; 0 0 1];
    end
    if ( strcmp(sub_id{1}, 'kinectV2'))
        % kinect v2
        K = [528 0 960; 0 528 540; 0 0 1];
    end
    
    sprintf('working with default parameters');
end

end
