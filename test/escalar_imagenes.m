    
im_counter = 0;

seq_name = 'ima_calibracion';
seq_name_scale = 'ima_calibracion_scala';
seq_path = strcat('../dataset/', seq_name, '/');
seq_path_scale = strcat('../dataset/', seq_name_scale, '/');

while (true)

    % color and depth images
    color_im = strcat( seq_path ,'im_color_', num2str(im_counter), '.png');
    
    % exist the image
    exist_col_im = exist(color_im, 'file' ) == 2;
    
    if ( exist_col_im ) 
        
        color = imread( color_im );
        color_scale = imresize(color, [512 424]);
        
        color_im = strcat( seq_path_scale ,'im_color_', num2str(im_counter), '.png');
        imwrite(color_scale, color_im);
        
    end
   
    im_counter = im_counter +1;
    
    fprintf('frame %d \n', im_counter);
    
end