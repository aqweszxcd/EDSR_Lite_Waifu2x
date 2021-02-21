%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rmdir('.div2k/images','s')
mkdir('.div2k/images')
mkdir('.div2k/images/DIV2K_train_HR')
mkdir('.div2k/images/DIV2K_train_LR_bicubic')
mkdir('.div2k/images/DIV2K_train_LR_bicubic/X2')
mkdir('.div2k/images/DIV2K_train_LR_bicubic/X3')
mkdir('.div2k/images/DIV2K_train_LR_bicubic/X4')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataDir = 'dataset';
patch_size = 320;%size
stride = 320;%bu jin
quality = 30;%jpeg compress quality
f_lst = [];
f_lst = [f_lst; dir(fullfile(dataDir, '*.jpg'))];
f_lst = [f_lst; dir(fullfile(dataDir, '*.png'))];
f_lst = [f_lst; dir(fullfile(dataDir, '*.bmp'))];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count = 1;
for f_iter = 1:numel(f_lst)

    f_info = f_lst(f_iter);
    f_path = fullfile(dataDir,f_info.name);
    img_raw = imread(f_path);
    img_size = size(img_raw);
    width = img_size(2);
    height = img_size(1);
    
    x_size = (img_size(2)-patch_size)/stride+1;
    y_size = (img_size(1)-patch_size)/stride+1;
    
    for x = 0:x_size-1
        for y = 0:y_size-1
            
            x_coord = x*stride; y_coord = y*stride; 
            
            patch_1 = imrotate(img_raw(y_coord+1:y_coord+patch_size,x_coord+1:x_coord+patch_size,:), 0);
            patch_png = sprintf('.div2k/images/DIV2K_train_HR/%04d.png',count);
            imwrite(patch_1, patch_png);
            
            patch_2 = imresize(patch_1,1/2,'bicubic');
            patch_jpeg = sprintf('.div2k/images/DIV2K_train_LR_bicubic/X2/%04dx2.jpeg',count);
            patch_png = sprintf('.div2k/images/DIV2K_train_LR_bicubic/X2/%04dx2.png',count);
            imwrite(patch_2, patch_jpeg,'quality',quality);
            patch_compressed = imread(patch_jpeg);
            delete(patch_jpeg)
            imwrite(patch_compressed, patch_png);
            
            patch_3 = imresize(patch_1,1/3,'bicubic');
            patch_jpeg = sprintf('.div2k/images/DIV2K_train_LR_bicubic/X3/%04dx3.jpeg',count);
            patch_png = sprintf('.div2k/images/DIV2K_train_LR_bicubic/X3/%04dx3.png',count);
            imwrite(patch_3, patch_jpeg,'quality',quality);
            patch_compressed = imread(patch_jpeg);
            delete(patch_jpeg)
            imwrite(patch_compressed, patch_png);
            
            patch_4 = imresize(patch_1,1/4,'bicubic');
            patch_jpeg = sprintf('.div2k/images/DIV2K_train_LR_bicubic/X4/%04dx4.jpeg',count);
            patch_png = sprintf('.div2k/images/DIV2K_train_LR_bicubic/X4/%04dx4.png',count);
            imwrite(patch_4, patch_jpeg,'quality',quality);
            patch_compressed = imread(patch_jpeg);
            delete(patch_jpeg)
            imwrite(patch_compressed, patch_png);
            
            count = count + 1;
            
        end
    end
    
    display(count);
    
end
