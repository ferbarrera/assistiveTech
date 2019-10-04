function [ R ] = anav_generateRotationX( plane_normal )
%This function generate a rotation matrix given a normal vector and a point

[ normal ] = plane_normal/norm(plane_normal);   % vector normalization

% x axis is the same that the camera
[ x_axis ] = [1 0 0];

% build plane coordinate system
plane_y_axis = cross( normal, x_axis);      
plane_y_axis = plane_y_axis/norm(plane_y_axis);   % vector normalization
plane_x_axis = cross(plane_y_axis, normal );   % 

R = [plane_x_axis; normal ; plane_y_axis ];

end

