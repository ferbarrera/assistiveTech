% ----------------------------------------------
% - Save color and depth images 
% ----------------------------------------------

info =  imaqhwinfo('kinect');   % informaci?n del sensor
info.DeviceInfo(1)              % acceso a la c?mara
s = 0;

colorVid = videoinput('kinect',1,'RGB_640x480'); %activa c?mara RGB video
depthVid = videoinput('kinect',2,'Depth_640x480'); %activa c?mara depth video
    
% Set Frames per trigger. Bigger number means more frames when triggered.
colorVid.FramesPerTrigger = 1;
depthVid.FramesPerTrigger = 1;

% Set the trigger repeat for both devices to Inf
colorVid.TriggerRepeat = Inf;
depthVid.TriggerRepeat = Inf;

% Set triggers to manual so it is possible to work with them
triggerconfig([colorVid depthVid],'manual');

% Start both video objects
start([colorVid depthVid]);

%% recording loop
while s>=0

    % Trigger both objects.
    trigger([colorVid depthVid]);
    
     % Get the acquired frames and metadata.
    [imgColor, ts_color, metaData_Color] = getdata(colorVid);
    [imgDepth, ts_depth, metaData_Depth] = getdata(depthVid);
    
    % filename
    str_1 = num2str(s);
    imwrite(imgColor, strcat('im_color_',str_1,'.png'));
    imwrite(imgDepth, strcat('im_depht_',str_1,'.png'), 'BitDepth', 16, 'Mode', 'lossless' );
    
    s = s+1;

end

release(colorVid);
release(depthVid);
