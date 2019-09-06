% ---------------------------------------------
% - Point Cloud extraction and visualization
% ---------------------------------------------

% init color and depth camera
colorDevice = imaq.VideoDevice('kinect',1);
depthDevice = imaq.VideoDevice('kinect',2);

% leer camera parameters
k_file = exist(strcat( intrinsic_calib_path ,'k_test.mat'),'file') == 2;
dist_file = exist(strcat( intrinsic_calib_path ,'dist_test.mat'),'file') == 2;

if ( k_file && dist_file )
    load( strcat( intrinsic_calib_path ,'k_test.mat') );
    load( strcat( intrinsic_calib_path ,'dist_test.mat') );
else
    K = [528 0 320; 0 528 240; 0 0 1];
    dist = zeros(1,5);
    sprintf('working with default parameters');
end

%Inicia las camaras
step(colorDevice);
step(depthDevice);
  
%Graba dispositivos
colorImage = step(colorDevice);
depthImage = step(depthDevice);
  
%Extrae nube de puntos.
ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);

% Inicializar un reproductor para visualizar datos de nube de puntos tridimensionales. El eje es
% Establecido correctamente para visualizar la nube de puntos de Kinect.
player = pcplayer(ptCloud.XLimits, ptCloud.YLimits, ptCloud.ZLimits,...
               'VerticalAxis', 'y', 'VerticalAxisDir', 'down');

xlabel(player.Axes, 'X (m)');
ylabel(player.Axes, 'Y (m)');
zlabel(player.Axes, 'Z (m)');

% Adquirir y ver nube de puntos del kinect.
while isOpen(player)
    colorImage = step(colorDevice);
    depthImage = step(depthDevice);
 
    ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);
 
    view(player, ptCloud);
end
   
% release memory object
release(colorDevice);
release(depthDevice);
  