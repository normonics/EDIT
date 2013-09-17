clear; clc

x = MotionQuartet;
x.horizontalDistance = 100
x.verticalDistance = 80
x.elementSize = 10
x.nFrames = 10
x.frameRate = 2

%preview(x)
run(x)