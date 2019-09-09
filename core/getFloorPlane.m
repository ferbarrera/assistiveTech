function [ normal, centroid, model ] = getFloorPlane( ptCloud, ...
    maxDistance, referenceVector, maxAngularDistance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[model, inlierIndices, outlierIndices] = pcfitplane(ptCloud,...
    maxDistance,referenceVector, maxAngularDistance);
plane_X = select(ptCloud, inlierIndices);

normal = model.Normal;
centroid = mean(plane_X.Location,1);

end

