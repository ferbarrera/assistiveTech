% ----------------------------------------------
% - Save color and depth images 
% ----------------------------------------------

%% parameters

% {year}{month}{day}_{hour}-{minutes}_{wheelchair | visuallyImpaired}
% 20180112_13-00_wheelchair
% 20180112_13-00_visuallyImpaired
dataset_name = '20190911_14-00_visuallyImpaired';

%%

% ckeck if exist dataset then make directory
dataset_path = strcat('../dataset/', dataset_name, '/');
fprintf('%s\n', dataset_path);
if (exist( dataset_path ,'dir') == 7)
    error('directory already exists');
else
    mkdir(dataset_path);
    fprintf('%s\n','directory created');
end


info =  imaqhwinfo('kinect');   % informaci?n del sensor
info.DeviceInfo(1)              % acceso a la c?mara
s = 0;

colorVid = videoinput('kinect',1,'RGB_1920x1080'); %activa c?mara RGB video
depthVid = videoinput('kinect',2,'Depth_512x424'); %activa c?mara depth video
    
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
    imwrite(imgColor, strcat(dataset_path,'im_color_',str_1,'.png'));
    imwrite(imgDepth, strcat(dataset_path,'im_depht_',str_1,'.png'), 'BitDepth', 16, 'Mode', 'lossless' );
    
    s = s+1;

end

release(colorVid);
release(depthVid);
