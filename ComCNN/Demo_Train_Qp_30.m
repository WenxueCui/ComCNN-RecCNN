
%%% Note: run the 'GenerateData_model_64_25_Res_Bnorm_Adam.m' to generate
%%% training data first.
run('F:\matconvnet-1.0-beta23\matlab\vl_setupnn.m');

%%%-------------------------------------------------------------------------
%%% configuration
%%%-------------------------------------------------------------------------
opts.modelName        = 'Qp_30'; %%% model name
opts.learningRate     = [logspace(-4,-5,20) logspace(-5,-5,10)];%%% you can change the learning rate
opts.batchSize        = 128; %%% default
opts.gpus             = []; %%% this code can only support one GPU!

%%% solver
opts.solver           = 'Adam';

opts.gradientClipping = false; %%% Set 'true' to prevent exploding gradients in the beginning.
opts.expDir      = fullfile('data', opts.modelName);
opts.imdbPath    = fullfile(opts.expDir, 'imdb.mat');

%%%-------------------------------------------------------------------------
%%%   Initialize model and load data
%%%-------------------------------------------------------------------------
%%%  model
load(fullfile('RecCNN_model','model_QP_30-epoch-30.mat'));
net1.layers = net.layers(1:end-1);
if opts.gpus
    net1 = vl_simplenn_move(net1, 'gpu') ;
end

net  = feval(['ComCNN_init_',opts.modelName]);

%%%  load data
imdb = load(opts.imdbPath) ;

%%%-------------------------------------------------------------------------
%%%   Train 
%%%-------------------------------------------------------------------------

[net, info] = ComCNN_train(net,net1, imdb, ...
    'expDir', opts.expDir, ...
    'learningRate',opts.learningRate, ...
    'solver',opts.solver, ...
    'gradientClipping',opts.gradientClipping, ...
    'batchSize', opts.batchSize, ...
    'modelname', opts.modelName, ...
    'gpus',opts.gpus) ;






