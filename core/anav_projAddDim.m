function [x_homogeneous] = anav_projAddDim(x)
%ANAV_PROJADDDIM

x_homogeneous = [x ; ones(1,size(x,2)) ];

end