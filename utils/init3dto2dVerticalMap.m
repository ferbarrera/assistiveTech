function [ image_pointer ] = init3dto2dVerticalMap( mapping2Daxe, voxel_number, voxel_size)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

initPattern = zeros(voxel_number(2), voxel_number(1));
%initPattern(1,1) = 1;
clims = [0 255];

image_pointer = imagesc( mapping2Daxe, initPattern);
set( mapping2Daxe,'CLim',clims);
set( mapping2Daxe,'CLimMode', 'manual');
colorbar

xlabel(mapping2Daxe,'X (cm)');
ylabel(mapping2Daxe,'Y (cm)');

mapping2Daxe.XTick = (0:10:voxel_number(1)); 
x_low = voxel_number(1)/2:-10:0;
x_high = x_low(end):+10:voxel_number(1)/2;
xTickLable = strsplit(num2str(voxel_size(1)/10*[x_low x_high(2:end)]));
mapping2Daxe.XTickLabel= xTickLable;

mapping2Daxe.YTick = (0:10:voxel_number(2)); 
ytick = voxel_number(2):-10:0;
xTickLable = strsplit(num2str(voxel_size(2)/10*ytick));
mapping2Daxe.YTickLabel= xTickLable;

end