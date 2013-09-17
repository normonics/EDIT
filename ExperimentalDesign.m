
classdef ExperimentalDesign
    
    properties
        stimulus = ''
        conditions = {}
        nRepetitions = 1
        shuffleMode = 'subblock'; % should be ablt to toggle between block and subblock shuffling, or perhaps custom order of some kind
        responseStructure = {'any'}
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
            
            %shuffle based on shuffleMode
            if strcmpi(obj.shuffleMode, 'block')
                
                trialOrder = Shuffle(kron([1:nConditions], ones(1,obj.nRepetitions))); % this shuffles the indices to the conditionsMatrix by the whole block
                
            elseif strcmpi(obj.shuffleMode, 'subblock')
                trialOrder = [];
                
                for i = 1:obj.nRepetitions
                    trialOrder = [trialOrder randperm(nConditions)];
                end
                
            elseif strcmpi(obj.shuffleMode, 'off')
                
                trialOrder = [];
                
                for i = 1:obj.nRepetitions
                    trialOrder = [trialOrder [1:nConditions]];
                end
                
            end
            
            currentStimulus = eval([obj.stimulus]); % generate a stimulus object
            
            try
                HideCursor
                ListenChar(2)
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
                    
                    % collect responses along with trial conditions
                    conditionList{trial,1} = currentCondition;
                    
                    for responseNumber = 1:size(obj.responseStructure,2)
                        
                        [secs, keyCode, deltaSecs] = KbStrokeWait;
                        responses{trial,responseNumber} = KbName(keyCode);
                         
                    end
                  
                WaitSecs(1); % give short delay before next stimulus is presented
                
                end
                responses = [conditionList responses];
                conditionLabels = obj.conditions(1,:);
                save(obj.saveFile,'responses', 'conditionLabels')
                
                Screen('CloseAll');
                ShowCursor
                ListenChar(0)
            catch
                Screen('CloseAll');
                ShowCursor
                ListenChar(0)
            end
            
            
        end
        
    end
    
end
