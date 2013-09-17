classdef MotionQuartet < StimulusObject
    
    properties
        horizontalDistance = 40
        verticalDistance = 40
        luminanceValues = [20 100]
        startOrientation = 0
        elementSize = 10 % assume always odd for now
        
    end
    
    methods
        function frames = generate(obj)
            
            
            gridSize = [obj.verticalDistance+obj.elementSize-1 obj.horizontalDistance+obj.elementSize-1];
            
            frames = zeros(obj.verticalDistance+obj.elementSize-1,...
                obj.horizontalDistance+obj.elementSize-1, obj.nFrames);
            
            
            
            for frame = 1:obj.nFrames
                
                
                if mod(frame,2)
                    
                    % define frame 1 luminances at desired locations
                    frames(1:obj.elementSize, 1:obj.elementSize, frame) = obj.luminanceValues(1);
                    frames(gridSize(1)-obj.elementSize+1:gridSize(1), gridSize(2)-obj.elementSize+1:gridSize(2),frame) = obj.luminanceValues(1);
                    
                    frames(gridSize(1)-obj.elementSize+1:gridSize(1), 1:obj.elementSize, frame) = obj.luminanceValues(2);
                    frames(1:obj.elementSize, gridSize(2)-obj.elementSize+1:gridSize(2),frame) = obj.luminanceValues(2);
                    
                else
                    
                    % define frame 2 luminances at desired locations
                    frames(1:obj.elementSize, 1:obj.elementSize, frame) = obj.luminanceValues(2);
                    frames(gridSize(1)-obj.elementSize+1:gridSize(1), gridSize(2)-obj.elementSize+1:gridSize(2),frame) = obj.luminanceValues(2);
                    
                    frames(gridSize(1)-obj.elementSize+1:gridSize(1), 1:obj.elementSize, frame) = obj.luminanceValues(1);
                    frames(1:obj.elementSize, gridSize(2)-obj.elementSize+1:gridSize(2),frame) = obj.luminanceValues(1);
                    
                end
                
            end
            
            
        end
        
        
        
    end
end