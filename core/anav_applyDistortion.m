function [xd] = anav_applyDistortion( x , distortion )
% ANAV_APPLYDISTORTION
% distortion [r1 r2 t1 t2 r3]

% Add distortion:
r2 = sum(x(1:2,:).^2);
r4 = r2.^2;
r6 = r2.^3;

% Radial distortion:
cdist = 1 + distortion(1) * r2 + distortion(2) * r4 + distortion(5) * r6;

xd1 = x(1:2,:) .* repmat(cdist,2,1);

% tangential distortion:
a1 = 2.*x(1,:).*x(2,:);
a2 = r2 + 2*x(1,:).^2;
a3 = r2 + 2*x(2,:).^2;

delta_x = [distortion(3)*a1 + distortion(4)*a2 ; distortion(3)*a3 + distortion(4)*a1];

xd = xd1 + delta_x;

if (size(x,1)==3)
   xd = anav_projAddDim( xd );
end

end