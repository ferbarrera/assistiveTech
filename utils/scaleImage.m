function [ s_im ] = scaleImage( image, numrows , numcols )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (size(image,1) ~= numrows) || ( size(image,2) ~= numcols)
    s_im = imresize(image,[numrows numcols],'nearest');
end

end

