% Takes an input image (non-HDR) and bins the pixels into 3 and 5 bins, based on its intensity values

[fname, pthname]=uigetfile('*.jpg;*.png;*.tif;*.bmp','Select the Asset Image'); %select image 

inp_img = imread([pthname fname]);
color_img_3 = zeros([size(inp_img) 3],'uint8');
color_img_5 = zeros([size(inp_img) 3],'uint8');

[m, n] = size(inp_img);

tic
i_loop_var = m;
j_loop_var = n;

for i = 1:i_loop_var
    for j = 1:j_loop_var
        pxl_val = getPixel(inp_img, i, j);
        if pxl_val <= 50
            cat = 1;
            color_img_5(i, j, 1) = 0;
            color_img_5(i, j, 2) = 0;
            color_img_5(i, j, 3) = 0;
        elseif pxl_val <= 100
            cat = 2;
            color_img_5(i, j, 1) = 255;
            color_img_5(i, j, 2) = 0;
            color_img_5(i, j, 3) = 0;
        elseif pxl_val <= 150
            cat = 3;
            color_img_5(i, j, 1) = 0;
            color_img_5(i, j, 2) = 255;
            color_img_5(i, j, 3) = 0;
        elseif pxl_val <= 200
            cat = 4;
            color_img_5(i, j, 1) = 0;
            color_img_5(i, j, 2) = 0;
            color_img_5(i, j, 3) = 255;
        else
            cat = 5;
            color_img_5(i, j, 1) = 255;
            color_img_5(i, j, 2) = 255;
            color_img_5(i, j, 3) = 255;
        end
        
        
        if pxl_val <= 60
            cat = 1;
            color_img_3(i, j, 1) = 255;
            color_img_3(i, j, 2) = 0;
            color_img_3(i, j, 3) = 0;
        elseif pxl_val <= 150
            cat = 2;
            color_img_3(i, j, 1) = 0;
            color_img_3(i, j, 2) = 255;
            color_img_3(i, j, 3) = 0;
        else
            cat = 3;
            color_img_3(i, j, 1) = 0;
            color_img_3(i, j, 2) = 0;
            color_img_3(i, j, 3) = 255;
        end
    end
end
toc

% figure
% ax1 = subplot(1,3,1); imshow(color_img_3);
% ax2 = subplot(1,3,2); imshow(color_img_5);
% ax3 = subplot(1,3,3); imshow(inp_img);
% linkaxes([ax1 ax2 ax3],'xy');

figure
ax1 = subplot(1,1,1); imshow(color_img_3);
figure
ax2 = subplot(1,1,1); imshow(color_img_5);

linkaxes([ax1 ax2],'xy');

figure
imhist(inp_img)
out_fname_5 = sprintf('data/output/color_5/color_%s', fname);
out_fname_3 = sprintf('data/output/color/color_%s', fname);
imwrite(color_img_5, out_fname_5); % Save output Image
imwrite(color_img_3, out_fname_3); % Save output Image

function pixel = getPixel(mat, i, j)
    pixel = mat(i, j);
end