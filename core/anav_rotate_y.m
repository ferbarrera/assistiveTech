function [ P ] = anav_rotate_y( points, theta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

R = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];

P = anav_applyT( points, R, [0 0 0] );

end

