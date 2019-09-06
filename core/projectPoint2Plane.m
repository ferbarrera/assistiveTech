function [ p ] = projectPoint2Plane( normal, distance, point )
% point is a R^3 point 
% normal is the plane normal
% d is the order zero term in plane equation ax + by + cz + d

normal = normal / norm(normal);

% p = normal*d + points
%     [1x3][1]    nx3
% p = normal*d + points
%
p = point - repmat(reshape(normal,[1,3]), size(point,1), 1 ) .* repmat(distance, 1,3);

end