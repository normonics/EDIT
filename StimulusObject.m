classdef StimulusObject
    
    properties
       location = [0,0] % in pixel values with respect to (approximate) center
       nFrames = 2 % number of frames
       frameRate = 2 % Hz
    end
    
    methods
        function [] = preview(obj)
            frames = generate(obj);
            
            for frame = 1:obj.nFrames
                
                imagesc(frames(:,:,frame))
                colormap('gray')
                pause(1/obj.frameRate)
            end
            
        end
        
    end
    
    
    
end