function [ dist ] = loadCameraDistortion( id )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dist = NaN;

intrinsic_calib_path = '../dataset/cameraParameters/';

dist_file = strcat( intrinsic_calib_path, id, '.mat');
exist_k_file = exist( dist_file ,'file') == 2;

sub_id = strsplit(id, '_');

if ( exist_k_file )
    dist = cell2mat(struct2cell(load( dist_file )));
else
    if ( strcmp(sub_id{1}, 'kinectV1') )
        % kinect v1
        dist = [0 0 0 0 0 0];
    end
    if ( strcmp(sub_id{1}, 'kinectV2'))
        % kinect v2
        dist = [0 0 0 0 0 0];
    end
    
    sprintf('working with default parameters');
end

end