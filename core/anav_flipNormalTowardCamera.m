function [ new_normal, d_sign ] = anav_flipNormalTowardCamera( normal, point, sensorCenter )
%This function flips the normal when it is not pointing toward the camera
% new_normal is the reoriented normal
% d_sign is the sign of independient term of equation aX+bY+cZ+d of new
% normal

d_sign = 1;

if nargin == 2
    sensorCenter = [0 0 0];
end

p1 = sensorCenter - point;
p2 = normal;
new_normal = normal;

% Flip the normal vector if it is not pointing towards the sensor.
angle = atan2(norm(cross(p1,p2)),p1*p2');

if angle > pi/2 || angle < -pi/2
       new_normal = -normal;
       d_sign = -1;
end

end

