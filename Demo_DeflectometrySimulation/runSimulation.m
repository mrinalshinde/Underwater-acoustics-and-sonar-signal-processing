%% Important Note:
%  The working directory must be set to the directory of this script.
%  GOMsim-Profiles are not used.

close all

% init
% GOMsimDirectory = '..\..';
GOMsimDirectory = '/Users/mrinalshinde/Desktop/BIAS/GOMsim';
addpath([GOMsimDirectory, '\Applications'])
addpath(genpath([GOMsimDirectory, '\functions']))
addpath(genpath([GOMsimDirectory, '\GOMlib']))
addpath([GOMsimDirectory, '\config\Plot']) % plot style template. DONT add the whole config directory! 
                                           % You will never know if you are loading the correct parameter 
                                           % files or the defaults stored in GOMsim!


% set general properties
initStruct = struct;
initStruct.GOMsimDirectory = GOMsimDirectory;
initStruct.targetDirectory = pwd;   % current workspace directory, must contain this script
initStruct.calibFolderName = 'Parameters';
initStruct.measurementName = 'Sphere';
initStruct.absPhaseImageFolderName = 'Results\absPhaseImages';
initStruct.maskImageFolderName = 'Results\absPhaseImages';
initStruct.saveFringeImages = false;
initStruct.savePhaseImages = false;
initStruct.saveAbsPhaseImages = true;
initStruct.saveMaskImage = true;
initStruct.saveIntersections = false;
initStruct.saveFPConfigFile = true;
initStruct.saveFPCalibrationFile = true;

% create general Simulation object
sim = Simulation(initStruct);

% calibration mirror orientation 1
sim.measurementNumber = 1;
sim.mainConfigFile = 'main';
sim.run;
sim.record;