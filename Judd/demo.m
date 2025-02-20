% Sample script to run the saliency function on a sample image


folders = { ...
    '/media/Data/Attention_NN/matlab_models/Judd/FelzenszwalbDetectors', ...
    '/media/Data/Attention_NN/matlab_models/Judd/horizon code', ...
    '/media/Data/Attention_NN/matlab_models/Judd/LabelMeToolbox-master' ...
    '/media/Data/Attention_NN/matlab_models/Judd/matlabPyrTools-master', ...
    '/media/Data/Attention_NN/matlab_models/Judd/SaliencyToolbox-main', ...
    '/media/Data/Attention_NN/matlab_models/Judd/ViolaJonesFaceDetector' ...
    '/media/Data/Attention_NN/matlab_models/Judd/voc-dpm-master' ...
};

for k = 1:length(folders)
    addpath(genpath(folders{k}));
end

% Define the sample image file
sample_image = 'sampleImage.jpeg'; 

% Run the saliency function
saliencyMap = saliency(sample_image);

% Display the saliency map
figure;
subplot(1,2,1); imshow(imread(sample_image)); title('Original Image');
subplot(1,2,2); imshow(saliencyMap); title('Saliency Map');

saveas(gcf,"/media/Data/Attention_NN/matlab_models/Judd/demo_fig.jpg")