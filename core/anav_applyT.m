function [ P ] = anav_applyT( points, R, t )

%this function applies a rotation and traslation to a point cloud

P = ([R(1:3,1:3) t(:) ; 0 0 0 1])*[ points'; ones(1, size(points,1) )];

P = P(1:3,:)';

end

