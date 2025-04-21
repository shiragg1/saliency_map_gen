clc;
clear;
close all;

addpath(genpath("/media/Data/Attention_NN/matlab_models/GBVS"))

totalTime = 0;
totalSamples = 0;

% Define input and output directories
inputDir = '/media/Data/Attention_NN/matlab_models/imagenette2-320/train/';
outputDir = '/media/Data/Attention_NN/matlab_models/GBVS_maps_320/';

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

    % make some parameters
    params = makeGBVSParams;


    % Process each image
    for j = 1:length(imageFiles)
        imageName = imageFiles(j).name;
        inputImagePath = fullfile(inputSubDirPath, imageName);
        
        % if the image is grayscale, skip it!
        if checkGrayscale(inputImagePath)
            continue
        end
        
        % Modify the output filename to include "GBVS"
        [~, name, ext] = fileparts(imageName); % Extract filename and extension
        newImageName = strcat(name, '_GBVS', ext); % Append "_GBVS" before the extension
        outputImagePath = fullfile(outputSubDirPath, newImageName); % Construct new output path

        % Check if saliency map already exists
        if exist(outputImagePath, 'file')
            fprintf('Skipped (already exists): %s\n', outputImagePath);
            continue;
        end

        % Start measuring time
        tic;

        img = imread(inputImagePath);
        out{i} = gbvs(img);
        saliency_map = imresize( out{i}.master_map , sz , 'bicubic' );
        normalizedSalMap = mat2gray(saliency_map);

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
modelName = "GBVS"; % This will be added as a column in the CSV
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