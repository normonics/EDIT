classdef MotionQuartet < StimulusObject
    
    properties
       horizontalDistance = 8
       verticalDistance = 8
       luminanceValues = [20 100]
       startOrientation = 0
       elementSize = 3 % assume always odd for now
        
    end
    
    methods
        function frames = generate(obj)
           
            
            gridSize = [obj.verticalDistance+obj.elementSize-1 obj.horizontalDistance+obj.elementSize-1];
            
            frames = zeros(obj.verticalDistance+obj.elementSize-1,...
                obj.horizontalDistance+obj.elementSize-1, obj.nFrames);
            
           
            
           % for frame = 
            
            % define frame 1 luminances at desired locations
            frames(1:obj.elementSize, 1:obj.elementSize, 1) = obj.luminanceValues(1);
            frames(gridSize(1)-obj.elementSize+1:gridSize(1), gridSize(2)-obj.elementSize+1:gridSize(2),1) = obj.luminanceValues(1);
            
            frames(gridSize(1)-obj.elementSize+1:gridSize(1), 1:obj.elementSize, 1) = obj.luminanceValues(2);
            frames(1:obj.elementSize, gridSize(2)-obj.elementSize+1:gridSize(2),1) = obj.luminanceValues(2);
            
            
            % define frame 2 luminances at desired locations
            frames(1:obj.elementSize, 1:obj.elementSize, 2) = obj.luminanceValues(2);
            frames(gridSize(1)-obj.elementSize+1:gridSize(1), gridSize(2)-obj.elementSize+1:gridSize(2),2) = obj.luminanceValues(2);
            
            frames(gridSize(1)-obj.elementSize+1:gridSize(1), 1:obj.elementSize, 2) = obj.luminanceValues(1);
            frames(1:obj.elementSize, gridSize(2)-obj.elementSize+1:gridSize(2),2) = obj.luminanceValues(1);
            
            
        end
        
        function [] = preview(obj)
            
            frames = generate(obj) 
           
            for i = 1:obj.nFrames
               
               if mod(i,2) 
                   frame = 1;
               else
                   frame = 2;
               end
               
               imagesc(frames(:,:,frame))
               colormap('gray')
               
               pause(1/obj.frameRate)
               
            end
        end
    end
        

    
end