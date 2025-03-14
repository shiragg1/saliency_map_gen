clc;
clear;
close all;

addpath(genpath("/media/Data/Attention_NN/matlab_models/LDS"))

totalTime = 0;
totalSamples = 0;

% Define input and output directories
inputDir = '/media/Data/Attention_NN/matlab_models/imagenette2/train/';
outputDir = '/media/Data/Attention_NN/matlab_models/LDS_maps/';

% Create output directory if it doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Get list of all subdirectories in input directory
subDirs = dir(inputDir);
subDirs = subDirs([subDirs.isdir]); % Keep only directories
subDirs = subDirs(~ismember({subDirs.name}, {'.', '..'})); % Remove '.' and '..'

% Iterate over each subdirectory
for i = 1:length(subDirs)
    subDirName = subDirs(i).name;
    inputSubDirPath = fullfile(inputDir, subDirName);
    outputSubDirPath = fullfile(outputDir, subDirName);

    % Create corresponding output subdirectory if it doesn't exist
    if ~exist(outputSubDirPath, 'dir')
        mkdir(outputSubDirPath);
    end

    % Get list of all image files in the subdirectory
    imageFiles = dir(fullfile(inputSubDirPath, '*.JPEG'));

    load('model.mat'); % Chose a fast model
        lab_pca_book = load('LAB_pca.mat');

    % Process each image
    for j = 1:length(imageFiles)
        imageName = imageFiles(j).name;
        inputImagePath = fullfile(inputSubDirPath, imageName);
        % Modify the output filename to include "LDS"
        [~, name, ext] = fileparts(imageName); % Extract filename and extension
        newImageName = strcat(name, '_LDS', ext); % Append "_LDS" before the extension
        outputImagePath = fullfile(outputSubDirPath, newImageName); % Construct new output path

        % Start measuring time
        tic;

        [sm] = GetSaliencyMap(inputImagePath,x,lab_pca_book);
        normalizedSalMap = mat2gray(sm);

        % Measure elapsed time
        elapsedTime = toc;
        totalTime = totalTime + elapsedTime;
        totalSamples = totalSamples + 1;

        imwrite(normalizedSalMap, outputImagePath) % save image

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
fileName = 'stats.csv';
filePath = fullfile(folderName, fileName);
modelName = "LDS"; % This will be added as a column in the CSV
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