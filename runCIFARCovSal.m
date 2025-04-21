clc;
clear;
close all;

addpath(genpath("/media/Data/Attention_NN/matlab_models/CovSal"))

% options for saliency estiomation
options.size = 512;                     % size of rescaled image
options.quantile = 1/10;                % parameter specifying the most similar regions in the neighborhood
options.centerBias = 1;                 % 1 for center bias and 0 for no center bias
options.modeltype = 'CovariancesOnly';  % 'CovariancesOnly' and 'SigmaPoints' 
                                        % to denote whether first-order statistics
                                        % will be incorporated or not

totalTime = 0;
totalSamples = 0;


% Define input and output directories
inputDir = '/media/Data/Attention_NN/matlab_models/padded_and_dilated_cifar/';
outputDir = '/media/Data/Attention_NN/matlab_models/CIFAR_CovSal_maps/';

% Create output directory if it doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Iterate over each subdirectory
for i = 1:length(inputDir)
    
    % Get list of all image files in the subdirectory
    imageFiles = dir(fullfile(inputDir, '*.png'));

    % Process each image
    for j = 1:length(imageFiles)
        imageName = imageFiles(j).name;
        inputImagePath = fullfile(inputDir, imageName);

        % if the image is grayscale, skip it!
        if checkGrayscale(inputImagePath)
            continue
        end

        % Modify the output filename to include "CovSal"
        [~, name, ext] = fileparts(imageName); % Extract filename and extension
        newImageName = strcat(name, '_CovSal', ext); % Append "_covsal" before the extension
        outputImagePath = fullfile(outputDir, newImageName); % Construct new output path
        
        % Visual saliency estimation with covariances and means
        options.modeltype = 'SigmaPoints';

        % Start measuring time
        tic;

        salmap = saliencymap(inputImagePath, options);
        normalizedSalMap = mat2gray(salmap);

        % Measure elapsed time
        elapsedTime = toc;
        totalTime = totalTime + elapsedTime;
        totalSamples = totalSamples + 1;

        % Resize back to (32 + padding) and then remove padding
        pad_size = 4;
        resizedSalMap = imresize(normalizedSalMap, [32 + pad_size, 32 + pad_size]);
        croppedSalMap = resizedSalMap(pad_size+1:end-pad_size, pad_size+1:end-pad_size);

        imwrite(croppedSalMap, outputImagePath) % save image

        fprintf('Processed and saved: %s\n', outputImagePath);
    end
end

% SAVE STATS

timePerSample = totalTime/totalSamples;

folderName = '/media/Data/Attention_NN/matlab_models/Model_Stats'; % Define folder name to save stats
% Check if the folder exists, if not, create it
if ~exist(folderName, 'dir')
    mkdir(folderName);
end
% Define file name and full path
fileName = 'cifar_stats.csv';
filePath = fullfile(folderName, fileName);
modelName = "CovSal"; % This will be added as a column in the CSV
% Data to save
data = {modelName, totalTime, totalSamples, timePerSample};
% Check if file exists
if exist(filePath, 'file') == 2
    % Append new data to existing file
    writecell(data, filePath, 'WriteMode', 'append');
else
    % Write with header if the file does not exist
    header = ["Model", "TotalTime", "TotalSamples", "TimePerSample"];
    writematrix(header, filePath);
    writecell(data, filePath, 'WriteMode', 'append');
end

disp('Processing complete.');

function isGray = checkGrayscale(imagePath)
    % Read the image
    img = imread(imagePath);
    
    % Check if the image has a single channel
    isGray = (size(img, 3) == 1);
end