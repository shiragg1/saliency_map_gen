
addpath(genpath('/media/Data/Attention_NN/matlab_models/LDS/external'));

load('model.mat'); % Chose a fast model.       |
lab_pca_book = load('LAB_pca.mat');

imgpath = 'Image_17.png';
tic;
[sm] = GetSaliencyMap(imgpath,x,lab_pca_book);
normalizedSalMap = mat2gray(sm);
toc;
imwrite(sm,'/media/Data/Attention_NN/matlab_models/LDS/salmap.png');
imwrite(normalizedSalMap,'/media/Data/Attention_NN/matlab_models/LDS/normalized_salmap.png');

