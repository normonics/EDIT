clear;clc

x = ExperimentalDesign;

x.stimulus = 'MotionQuartet';

x.conditions = {'nFrames', 'verticalDistance', 'horizontalDistance';...
    [2 10], [8 20], [10, 12, 16]};

preview(x)