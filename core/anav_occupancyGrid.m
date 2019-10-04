function [ img ] = anav_occupancyGrid( grid, voxel_number, X_scene )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

voxel_occ_th = 10;

img = zeros(voxel_number(2),voxel_number(1),'uint8');

for c = 0:1:(voxel_number(1)-1)
    l_inf = (1+voxel_number(2))*c+1;
    l_sup = (1+voxel_number(2))*(c+1) -1;
    x_coor_inf = grid(l_inf:l_sup,1);
    y_coor_inf = grid(l_inf:l_sup,2);
    z_coor_inf = grid(l_inf:l_sup,3);

    d = voxel_number(1)+2+c;
    l_inf = (1+voxel_number(2))*d+1 + 1;
    l_sup = (1+voxel_number(2))*(d+1);
    x_coor_sup = grid(l_inf:l_sup,1);
    y_coor_sup = grid(l_inf:l_sup,2);
    z_coor_sup = grid(l_inf:l_sup,3);

    for j = 1:numel(x_coor_sup)
        
        in_z = (z_coor_inf(j) < X_scene(3,:)) & (X_scene(3,:) < z_coor_sup(j));
        in_y = (y_coor_inf(j) > X_scene(2,:)) & (X_scene(2,:) > y_coor_sup(j)); 
        in_x = (x_coor_inf(j) < X_scene(1,:)) & (X_scene(1,:) < x_coor_sup(j));
        
        img(j,c+1) = sum(sum(in_z & in_y & in_x));
        
%       for i = 1:size(X_scene,2)
%                
%             if ((z_coor_inf(j) < X_scene(3,i)) && (X_scene(3,i) < z_coor_sup(j)))
%                 if ((x_coor_inf(j) < X_scene(1,i)) && (X_scene(1,i) < x_coor_sup(j)))
%                     if ((y_coor_inf(j) > X_scene(2,i)) && (X_scene(2,i) > y_coor_sup(j)))
%                         
%                         img(j,c+1) = img(j,c+1) + 1;
%                         
%                         if  img(j,c+1) > voxel_occ_th
%                             break;
%                         end
%                         
%                     end
%                 end
%             end
%        
%        end
    end
end

img = flipud( img );

end

