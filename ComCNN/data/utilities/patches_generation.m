function [inputs, labels, set] = patches_generation(size_input,size_label,stride,folder,mode,max_numPatches,batchSize)

inputs  = zeros(size_input, size_input, 1, 1,'single');
labels  = zeros(size_label, size_label, 1, 1,'single');
count = 0;
% count_label = 0;

ext               =  {'*.jpg','*.png','*.bmp'};
filepaths           =  [];

for i = 1 : length(ext)
    filepaths = cat(1,filepaths, dir(fullfile(folder, ext{i})));
end

for i = 1 : length(filepaths)
    image = imread(fullfile(folder,filepaths(i).name)); % uint8
    %[~, name, exte] = fileparts(filepaths(i).name);
    if size(image,3) == 3
        image = rgb2gray(image); % uint8
    end
    
     for j = 1:8
        image_aug = data_augmentation(image, j);  % augment data
        im_label  = im2single(image_aug); % single
        [hei,wid] = size(im_label);
        im_input  = im_label; % single
        
%         im_label = imresize(im_label,1/scale,'bicubic');  %down-sampling
        
        for x = 1 : stride : (hei-size_input+1)
            for y = 1 :stride : (wid-size_input+1)
                subim_input = im_input(x : x+size_input-1, y : y+size_input-1);
                count = count+1;
                inputs(:, :, 1, count)   = subim_input ;
                labels(:, :, 1, count) = subim_input;
            end
        end
%         count = count - (hei-(size_input/2))/stride ;
%         for p = 1 : stride/scale : ((hei/scale)-size_label+1)
%             for q = 1 :stride/scale : ((wid/scale)-size_label+1)
% %                 subim_input = im_input(x : x+size_input-1, y : y+size_input-1);
% %                 subim_label = im_label(x+padding : x+padding+size_label-1, y+padding : y+padding+size_label-1);
%                 subim_label = im_label(p : p+size_label-1, q : q+size_label-1);
%                 count_label       = count_label  + 1;
% %                 inputs(:, :, 1, count)   = subim_input + single(sigma/255*randn(size(subim_input)));
% %                 inputs(:, :, 1, count)   = subim_input ;
%                 labels(:, :, 1, count_label) = subim_label;
%             end
%         end
        
     end
end

inputs = inputs(:,:,:,1:(size(inputs,4)-mod(size(inputs,4),batchSize)));
labels = labels(:,:,:,1:(size(labels ,4)-mod(size(labels ,4),batchSize)));
% labels = shave(inputs,[padding,padding])-labels; %%% residual image patches; pay attention to this!!!

order  = randperm(size(inputs,4));
inputs = inputs(:, :, 1, order);
labels = labels(:, :, 1, order);

set    = uint8(ones(1,size(inputs,4)));
if mode == 1
    set = uint8(2*ones(1,size(inputs,4)));
end

disp('-------Original Datasize-------')
disp(size(inputs,4));

subNum = min(size(inputs,4),max_numPatches);
inputs = inputs(:,:,:,1:subNum);
labels = labels(:,:,:,1:subNum);
set    = set(1:subNum);

disp('-------Now Datasize-------')
disp(size(inputs,4));















