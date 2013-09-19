classdef TripleQuartet < StimulusObject
    
    properties
        flankerDistance = 400
        aspectRatioCentral = [40 40]
        aspectRatioRight = [40 80]
        aspectRatioLeft = [140 40]
        luminanceValues = [100 200]
        elementSize = 15
        
    end
    
    methods
        function frames = generate(obj)
            % generate array of three motion quartets
            motionQuartets(1:3) = MotionQuartet()
            
            % set global MotionQuartet parameters
            for i = 1:3
                
                motionQuartets(i).luminanceValues = obj.luminanceValues;
                motionQuartets(i).elementSize = obj.elementSize;
                
            end
            
            % set parameters for each MotionQuartet
            % set left quartet
            
            motionQuartets(1).verticalDistance = obj.aspectRatioLeft(1);
            motionQuartets(1).horizontalDistance = obj.aspectRatioLeft(2);
            
            motionQuartets(2).verticalDistance = obj.aspectRatioCentral(1);
            motionQuartets(2).horizontalDistance = obj.aspectRatioCentral(2);
            
            motionQuartets(3).verticalDistance = obj.aspectRatioRight(1);
            motionQuartets(3).horizontalDistance = obj.aspectRatioRight(2);
            
            % generate frames for each Quartet
            
            quartetLeftFrames = generate(motionQuartets(1));
            quartetCentralFrames = generate(motionQuartets(2));
            quartetRightFrames = generate(motionQuartets(3));
            
            % find size of each
            
           dimensions(1,:) = size(quartetLeftFrames);
           dimensions(2,:) = size(quartetCentralFrames);
           dimensions(3,:) = size(quartetRightFrames)
           
           
           newCanvasRows = max(dimensions(:,1)) 
           newCanvasColumns = 2*obj.flankerDistance + max(dimensions([1,3],2))
           newCanvas = zeros(newCanvasRows, newCanvasColumns, obj.nFrames);
           
           
           %paste central quartet on newCanvas
           centerColumn = newCanvasColumns/2
           centerRow = newCanvasRows/2
           
           newCanvas(centerRow-(dimensions(2,1)/2)+1:centerRow+(dimensions(2,1)/2),...
                     centerColumn - (dimensions(2,2)/2):centerColumn + (dimensions(2,2)/2)-1,...
                     :) = quartetCentralFrames;
           
           % paste left quartet on newCanvas
           
           newCanvas(centerRow-(dimensions(1,1)/2)+1:centerRow+(dimensions(1,1)/2),...
                     centerColumn - (dimensions(1,2)/2) - obj.flankerDistance:centerColumn + (dimensions(1,2)/2)-1- obj.flankerDistance,...
                    :) = quartetLeftFrames;
            
                
            % paste right quartet on newCanvas
            newCanvas(centerRow-(dimensions(3,1)/2)+1:centerRow+(dimensions(3,1)/2),...
                     centerColumn - (dimensions(3,2)/2) + obj.flankerDistance:centerColumn + (dimensions(3,2)/2)-1+ obj.flankerDistance,...
                    :) = quartetRightFrames;
            
                
                frames = newCanvas;
        end
        
        
    end
    
    
    
end