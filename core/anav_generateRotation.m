function [ R ] = anav_generateRotation( plane_normal )
%This function generate a rotation matrix given a normal vector and a point

[ normal ] = plane_normal/norm(plane_normal);   % vector normalization

% x axis is the same that the camera
[ x_axis ] = [1 0 0];

% build plane coordinate system
plane_x_axis = cross( normal, x_axis);      
plane_x_axis = plane_x_axis/norm(plane_x_axis);   % vector normalization
plane_y_axis = -1*cross(plane_x_axis, normal );   % 

R = [plane_x_axis; normal; plane_y_axis];
end

