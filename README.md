## Instructions for downloading ImageNette images

Download images: `wget "https://s3.amazonaws.com/fast-ai-imageclas/imagenette2.tgz"`
Unzip file: `tar -xvzf imagenette2.tgz`

## Instructions for running MATLAB saliency models

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
# Note: need to install unrar with sudo!

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
    `wget https://github.com/rbgirshick/voc-dpm/archive/refs/heads/master.zip`
    `unzip master.zip`
    (note: changed findObjectFeatures->detect() to gdetect() to be compatible with new version)

4) Viola Jones Face detector:
    `wget https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/19912/versions/1/download/zip`
    `mkdir ViolaJonesFaceDetector`
    `mv zip ViolaJonesFaceDetector/`
    `cd ViolaJonesFaceDetector/`
    `unzip zip`

5) LabelMe Toolbox:
    `wget https://github.com/CSAILVision/LabelMeToolbox/archive/master.zip`
    `unzip master.zip`
