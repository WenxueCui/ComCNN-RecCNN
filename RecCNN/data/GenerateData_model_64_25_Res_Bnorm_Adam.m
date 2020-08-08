
%%% Generate the training data.

clear;close all;

addpath(genpath('./.'));


JPEG_Quality = 30;
batchSize      = 128;        %%% batch size
max_numPatches = batchSize*500; 
modelName      = 'QP_30';

%%% training and testing
folder_train  = 'Train400';  %%% training
folder_test   = 'Test/Set68';%%% testing
size_input    = 40;          %%% training
size_label    = 40;          %%% testing
stride_train  = 80;          %%% training
stride_test   = 80;          %%% testing
val_train     = 0;           %%% training % default
val_test      = 1;           %%% testing  % default

%%% training patches
[inputs, labels, set]  = patches_generation(JPEG_Quality,size_input,size_label,stride_train,folder_train,val_train,max_numPatches,batchSize);
%%% testing  patches
[inputs2,labels2,set2] = patches_generation(JPEG_Quality,size_input,size_label,stride_test,folder_test,val_test,max_numPatches,batchSize);

inputs   = cat(4,inputs,inputs2);      clear inputs2;
labels   = cat(4,labels,labels2);      clear labels2;
set      = cat(2,set,set2);            clear set2;

if ~exist(modelName,'file')
    mkdir(modelName);
end

%%% save data
save(fullfile(modelName,'imdb_QP30'), 'inputs','labels','set','-v7.3')

