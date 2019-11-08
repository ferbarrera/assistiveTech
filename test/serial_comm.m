%%
% monitor: https://sites.google.com/site/terminalbpp/1
% driver usb-to-TTL: http://www.ifamilysoftware.com/news37.html
%

s_puerto = '/dev/tty.usbmodemFA131';
s_baudRate = 28800;
matrix_cols = 3;
matrix_rows = 2;


%% main

% objeto comunicacion serial
s = serial(s_puerto, 'BaudRate', s_baudRate);
keep_comm = true;
fopen(s); %Abrir puerto serial

map_2d = zeros(matrix_rows, matrix_cols, 'uint8' );
map_2d(1,2) = 250;
map_2d(2,1) = 100;
map_2d(2,3) = 250;
while keep_comm

    a = input('Press 1 to send message, 0 to exit');
    
    map_2d_tx = map_2d';
    
    % send command to arduino
    fwrite(s,map_2d_tx(:));

    if (a==0)
        keep_comm = false;
    end
end

fclose(s);
delete(s);
clear s;