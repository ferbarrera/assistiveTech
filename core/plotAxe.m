function [ ] = plotAxe( R, t )
%this function plot 3 axis from a rotation matrix and
%coordinate

quiver3(t(1), t(2), t(3), R(2,1), R(2,2), R(2,3), 1000, '-g');
quiver3(t(1), t(2), t(3), R(1,1), R(1,2), R(1,3), 1000, '-b');
quiver3(t(1), t(2), t(3), R(3,1), R(3,2), R(3,3), 1000, '-r');
          
end
