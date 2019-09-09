function [ h_qx, h_qy, h_qz ] = plotAxe( ax, R, t )
%this function plot 3 axis from a rotation matrix and
%coordinate

h_qx = quiver3(ax, t(1), t(2), t(3), R(2,1), R(2,2), R(2,3), 1000, '-g');
h_qy = quiver3(ax, t(1), t(2), t(3), R(1,1), R(1,2), R(1,3), 1000, '-b');
h_qz = quiver3(ax, t(1), t(2), t(3), R(3,1), R(3,2), R(3,3), 1000, '-r');
          
end
