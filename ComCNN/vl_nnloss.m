function [Y,diff] = vl_nnloss(X,c,net1,dzdy,diff_bac,varargin)

% --------------------------------------------------------------------
% pixel-level L2 loss
% --------------------------------------------------------------------

gpu = 0;

if nargin <= 3 || (isempty(dzdy) && isempty(diff_bac))

    addpath('im_temp');
    X= gather(X);
    diff = zeros(20, 20, 1, 128,'single');
    input = zeros(40, 40, 1, 128,'single');
    img = zeros(20, 20, 1, 128,'single');
    
    for i = 1:1:128
        imwrite(im2uint8(X(:,:,1,i)),fullfile('im_temp',sprintf('%3d.jpg',i)),'Quality',30);
    end
    ext = {'*.jpg'};
    filepaths =  [];
    for i = 1 : length(ext)
        filepaths = cat(1,filepaths, dir(fullfile('im_temp', ext{i})));
    end
    for i = 1:1:length(filepaths)
        img(:,:,1,i) = im2single(imread(fullfile('im_temp',filepaths(i).name)));
        input(:,:,1,i) = imresize(img(:,:,1,i),[40,40],'bicubic');
    end 
	
	if gpu:
        input = gpuArray(input);
	end
    
    res   = my_vl_simplenn(net1,input,[],[],'conserveMemory',true,'mode','test');
    outputs = input - res(end).x;
    
    t = ((outputs-c).^2)/2;
    Y = sum(t(:))/size(outputs,4);
    diff1 = outputs - c;
    diff1 = gather(diff1);
    for i = 1 : 128
        diff(:,:,1,i) = imresize(diff1(:,:,1,i),[20,20],'bicubic');
    end
	
	if gpu:
        diff = gpuArray(diff);
	end

else
    Y = diff_bac.*dzdy;
    diff = diff_bac;
end

