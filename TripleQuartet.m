classdef TripleQuartet < StimulusObject

    properties
        flankerDistance = 200
        aspectRatioCentral = [40 40]
        aspectRatioRight = [40 80] 
        aspectRatioLeft = [80 40]
        luminanceValues = [100 200]
        elementSize = 15
       
    end
        
    methods
        function frames = generate(obj)
           % generate array of three motion quartets
           motionQuartets(1:3) = MotionQuartet()
           
           % set global MotionQuartet parameters
           
           
           obj.luminanceValues
         
           motionQuartets.luminanceValues = 5%obj.luminanceValues
           motionQuartets(1)
           
           % set parameters for each MotionQuartet
           % set left quartet
           
%            motionQuartets(1).verticalDistance = obj.aspectRatioLeft(1)
%            motionQuartets(1).horizontalDistance = obj.aspectRatioLeft(2)
%           
            
        end
        
    
    end
    
    
   
end