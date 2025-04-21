clc;
clear;
close all;

% Define input and output directories
inputDir = '/media/Data/Attention_NN/matlab_models/cifar-10-batches-mat/';
outputDir = '/media/Data/Attention_NN/matlab_models/padded_and_dilated_cifar/';

% Create output directory if it doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Get list of all .mat batch files in the input directory
matFiles = dir(fullfile(inputDir, 'data_batch_*.mat'));

% Define padding size and target dilation size
edge_pad = 4;
dilated_size = [256, 256];

% Iterate over each .mat file
for i = 1:length(matFiles)
    matFilePath = fullfile(inputDir, matFiles(i).name);
    batchData = load(matFilePath);
    images = batchData.data;  % CIFAR-10 stores images as N x 3072 matrix
    labels = batchData.labels;
    
    % Reshape images to 32x32x3
    images = reshape(images', [32, 32, 3, size(images, 1)]);
    images = permute(images, [2, 1, 3, 4]); % Swap dimensions to correct orientation
    
    % Process each image
    for j = 1:size(images, 4)
        img = images(:, :, :, j);
        label = labels(j);
        
        % Ensure uint8 format
        img = uint8(img);
        
        % Apply padding (replicate edges) before resizing
        img_padded = padarray(img, [edge_pad, edge_pad], 'replicate', 'both');
        
        % Resize to target dilation size
        resizedImg = imresize(img_padded, dilated_size);
        
        % Save as PNG to preserve structure
        newImagePath = fullfile(outputDir, sprintf('%s_dilated_cifar_%d.png', matFiles(i).name(1:end-4), j));
        imwrite(resizedImg, newImagePath, 'png');
    end
end

disp('Processing complete.');