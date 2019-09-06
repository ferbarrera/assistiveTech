function [ ] = anav_plotPointCloud( X ,windowTitle )

if nargin<2
    windowTitle = '';
end

% sample3d
POINT_SAMPLE = 5;

figure( 'Name',windowTitle, 'NumberTitle', 'off'); 
grid on; hold all; xlabel('X'); ylabel('Y'); zlabel('Z');
set( gcf,'color','w' ); cameratoolbar( 'SetMode','orbit' ); 
cameratoolbar('SetCoordSys','x');

plot3( X( 1,1:POINT_SAMPLE:end ) , X( 2,1:POINT_SAMPLE:end ) , X( 3,1:POINT_SAMPLE:end ) , '.b');

%view( [1, 1, 1] );
view( 100,-35 );
axis('equal');
grid on

end
