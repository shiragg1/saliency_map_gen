## Instructions for downloading ImageNette images

Download images: `wget "https://s3.amazonaws.com/fast-ai-imageclas/imagenette2.tgz"`
Unzip file: `tar -xvzf imagenette2.tgz`

## Instructions for downloading CIFAR-10 images

Download images:`wget "https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz"`
Unzip file: `tar -xvzf cifar-10-matlab.tar.gz`

## Instructions for setting up MATLAB saliency models

Referencing MIT/Tuebingen Saliency Benchmark for relevant models: https://saliency.tuebingen.ai/results.html

# CovSal
https://web.cs.hacettepe.edu.tr/~erkut/projects/CovSal/

Download the code: `wget "https://web.cs.hacettepe.edu.tr/~erkut/projects/CovSal/saliency.zip"`
Unzip file: `unzip saliency.zip`
Rename folder: `mv saliency/ CovSal/`
Generate saliency maps by running: `runCovSal.m`

# LDS
https://pkuml.org/resources/code.html

Download the code: `wget http://pkuml.org/wp-content/uploads/2016/04/LDS.rar`
Unzip file: `unrar x LDS.rar`
note: run `mex mexSumOverScales.cc`

# Judd
https://people.csail.mit.edu/tjudd/WherePeopleLook/index.html

Download the code: `wget https://people.csail.mit.edu/tjudd/WherePeopleLook/Code/JuddSaliencyModel.zip`
Unzip file: `unzip JuddSaliencyModel.zip`
Rename folder: `mv JuddSaliencyModel/ Judd/`

Necessary tools:

1) Steerable pyramids code:
    `wget https://github.com/LabForComputationalVision/matlabPyrTools/archive/refs/heads/master.zip`
    `unzip master.zip`

2) Itti and Koch Saliency Toolbox: 
    `wget https://github.com/DirkBWalther/SaliencyToolbox/archive/refs/heads/main.zip`
    `unzip main.zip`


3) Felzenszwalb car and person detectors: 
    `wget --no-check-certificate 'https://cs.brown.edu/people/pfelzens/latent-release3/voc-release3.1.tgz'`
    `tar -xvzf voc-release3.1.tgz`
    then you will need to remake some c++ files with `mex filename.cc`

4) Viola Jones Face detector:
    `wget https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/19912/versions/1/download/zip`
    `mkdir ViolaJonesFaceDetector`
    `mv zip ViolaJonesFaceDetector/`
    `cd ViolaJonesFaceDetector/`
    `unzip zip`

5) LabelMe Toolbox:
    `wget https://github.com/CSAILVision/LabelMeToolbox/archive/master.zip`
    `unzip master.zip`


# GBVS
https://papers.nips.cc/paper_files/paper/2006/hash/4db0f8b0fc895da263fd77fc8aecabe4-Abstract.html

Download the code: `wget 'https://github.com/Pinoshino/gbvs/archive/refs/heads/master.zip'`
Unzip file: `unzip master.zip`
Rename the folder: `mv gbvs-master/ GBVS`


## Instructions for running the saliency models

# ImageNette

Use the MATLAB scripts called `run<SalModelName>.m` to generate maps for each model on Imagenette. Make sure the paths specified are correct.

If the script is interrupted in the middle, when you restart it will skip past images that have already been processed.

# CovSal

Use the MATLAB scripts called `runCIFAR<SalModelName>.m` to generate maps for each model on CIFAR. Make sure the paths specified are correct.

If the script is interrupted in the middle, when you restart it will skip past images that have already been processed.


## Instructions for compressing saliency maps to export

Use `compress_sal_maps_gray.py` to compress saliency maps (make sure to specify the correct path names for each model). Use `compress_images_rgb.py` to compress the ImageNette images. You will need to make separate compressed files for the train and val data. These scripts output HDF5 files which can be decompressed using the function in `decompress_sal_maps.py`.