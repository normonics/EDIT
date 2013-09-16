
classdef ExperimentalDesign
   
    properties
       stimulus = ''
       conditions = {}
       nRepetitions
       responseStructure = []
       saveFile = '' 
    end
    
    properties(Dependent)
        conditionsMatrix
    end
    
    methods
        % generate conditions matrix from inputted condition values
        function conditionsMatrix = get.conditionsMatrix(obj)
            
            conditionsMatrix = allcomb(obj.conditions{2,:});
        
        end
        
        % preview all stimulus conditions without responses
        function [] = preview(obj)
            currentStimulus = eval([obj.stimulus])
            
            for trial = 1:size(obj.conditionsMatrix,1)
               currentCondition = obj.conditionsMatrix(trial,:);
               
               for stimulusParameter = 1:size(obj.conditionsMatrix,2)
               
                   currentParameterLabel = obj.conditions{1,stimulusParameter}
                   
                   eval(['currentStimulus.' currentParameterLabel '= currentCondition(stimulusParameter)'])
                   
               end
              
             preview(currentStimulus)
             pause
               
            end
            
            
        end
        
    end
    
    
    
    
    
end  
    