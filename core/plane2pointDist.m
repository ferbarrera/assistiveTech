function [ p ] = plane2pointDist( normal, d, point )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

normal = normal / norm(normal);

% p = points x normal + d
%      nx3       3x1

p = point*normal(:) + d;

end

