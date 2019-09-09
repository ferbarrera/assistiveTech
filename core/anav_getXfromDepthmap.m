function [ X, X_valid, depth_valid ] = anav_getXfromDepthmap( depthMap, K, distortion, mask )
%XAW_GETXFROMDEPTHMAP
%

if (nargin<4)
    mask = true(size(depthMap));
end

% mapping image coordinates
[nr, nc, nb] = size(depthMap);
[px, py] = meshgrid(0:nc-1, 0:nr-1);
px = px( mask(:) );
py = py( mask(:) );
x = anav_projNormalization( inv(K) * anav_projAddDim( [px'; py'] ) );
xd = anav_applyDistortion( x, distortion );

mdepthMap = depthMap( mask );
X = xd .* repmat( double( mdepthMap( : )' ), 3, 1);
X = anav_projAddDim( X );

if nargout > 1
    depth_valid = X(3,:) > 0;
    X_valid = X( :, depth_valid);
end

% 
% multiply y-axis by -1 for Silberman's nomenclature
end
