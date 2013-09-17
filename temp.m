clear;clc

x = ExperimentalDesign;

x.stimulus = 'MotionQuartet';

x.saveFile = 'temp';

x.shuffleMode = 'block';

x.responseStructure = {'any', 'any'};

x.conditions = {'nFrames', 'verticalDistance', 'horizontalDistance';...
                [4],        [40 80],            [40 80]};

x.nRepetitions = 1;

run(x)