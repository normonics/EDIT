clear;clc

x = ExperimentalDesign;

x.stimulus = 'MotionQuartet';

x.conditions = {'nFrames', 'verticalDistance';...
    [2 10], [8 20]};

x.nRepetitions = 2;


run(x)