function [inputs, labels, set] = patches_generation(JPEG_Quality,size_input,size_label,stride,folder,mode,max_numPatches,batchSize)

inputs  = zeros(size_input, size_input, 1, 1,'single');
labels  = zeros(size_label, size_label, 1, 1,'single');
count   = 0;
useGPU = 0;
padding = abs(size_input - size_label)/2;

ext               =  {'*.jpg','*.png','*.bmp'};
filepaths           =  [];

load(fullfile('model','CRCNN-epoch-20.mat'));

net.layers = net.layers(1:end-1);

if useGPU
    net = vl_simplenn_move(net, 'gpu') ;
end

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
        input1 = im_label;
        if useGPU
        input1 = gpuArray(input1);
        end
        res  = test_vl_simplenn(net,input1,[],[],'conserveMemory',true,'mode','test');
        im_input = res(end).x;
        if useGPU
            im_input = gather(im_input);
        end
		imwrite(im2uint8(im_input),'im_JPEG.jpg','jpg','Quality',JPEG_Quality);
		im_compressed = im2double(imread('im_JPEG.jpg'));
		im_input = imresize(im_compressed,[hei,wid],'bicubic');
        %im_input  = im_label; % single
        for x = 1 : stride : (hei-size_input+1)
            for y = 1 :stride : (wid-size_input+1)
                subim_input = im_input(x : x+size_input-1, y : y+size_input-1);
                subim_label = im_label(x+padding : x+padding+size_label-1, y+padding : y+padding+size_label-1);
                count       = count+1;
                if mod(count,3000)==0
                    disp(['count = ',num2str(count)]);
                end
				inputs(:, :, 1, count)   = im2single(subim_input);
                labels(:, :, 1, count) = im2single(subim_label);
            end
        end
    end
end

inputs = inputs(:,:,:,1:(size(inputs,4)-mod(size(inputs,4),batchSize)));
labels = labels(:,:,:,1:(size(labels ,4)-mod(size(labels ,4),batchSize)));
labels = shave(inputs,[padding,padding])-labels; %%% residual image patches; pay attention to this!!!

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















