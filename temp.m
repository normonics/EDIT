clear;clc

x = ExperimentalDesign;

x.stimulus = 'MotionQuartet';

x.conditions = {'nFrames', 'verticalDistance', 'horizontalDistance';...        
    [4], [40 80],[40 80]};

x.nRepetitions = 2;


run(x)                                                                                                                      