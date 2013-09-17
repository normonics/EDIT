
classdef ExperimentalDesign
    
    properties
        stimulus = ''
        conditions = {}
        nRepetitions = 1
        shuffleMode = 'block'; % should be ablt to toggle between block and subblock shuffling, or perhaps custom order of some kind
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
            currentStimulus = eval([obj.stimulus]);
            
            for trial = 1:size(obj.conditionsMatrix,1)
                currentCondition = obj.conditionsMatrix(trial,:);
                
                for stimulusParameter = 1:size(obj.conditionsMatrix,2)
                    
                    currentParameterLabel = obj.conditions{1,stimulusParameter};
                    
                    eval(['currentStimulus.' currentParameterLabel '= currentCondition(stimulusParameter);'])
                    
                end
                
                preview(currentStimulus)
                pause
                
            end
            
            
        end
                
        function [] = run(obj) % run the thing
            
            nConditions = size(obj.conditionsMatrix, 1); % calculate total number of unique conditions
            
            trialOrder = Shuffle(kron([1:nConditions], ones(1,obj.nRepetitions))); % this shuffles the indices to the conditionsMatrix by the whole block
            
            currentStimulus = eval([obj.stimulus]); % generate a stimulus object
            
            
            
            
            
            try
                HideCursor
                window = Screen('OpenWindow', 0);
                Screen('FillRect', window, 0)
                Screen('Flip', window)
                KbWait
                
                for trial = 1:nConditions*obj.nRepetitions
                    
                    currentCondition = obj.conditionsMatrix(trialOrder(trial),:);
                    
                    for stimulusParameter = 1:size(obj.conditionsMatrix,2)
                        
                        currentParameterLabel = obj.conditions{1,stimulusParameter};
                        
                        eval(['currentStimulus.' currentParameterLabel '= currentCondition(stimulusParameter);']);
                        
                    end
                    
                    
                    frames = generate(currentStimulus);
                    
                    % make textures
                    for frame = 1:currentStimulus.nFrames
                        
                        textures(frame) = Screen('MakeTexture', window, frames(:,:,frame));
                        
                    end
                    
                    % display textures
                    for frame = 1:currentStimulus.nFrames
                        
                        Screen('DrawTexture', window, textures(frame));
                        Screen('Flip', window);
                        WaitSecs(1/currentStimulus.frameRate);
                        
                    end
                    
                    Screen('FillRect', window, 0)
                    Screen('Flip', window)
                    KbWait % collect response here
                    
                end
                Screen('CloseAll');
                ShowCursor
            catch
                Screen('CloseAll');
                ShowCursor
            end
            
            
        end
        
    end
    
end
