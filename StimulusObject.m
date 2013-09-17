classdef StimulusObject
    
    properties
        location = [0,0] % in pixel values with respect to (approximate) center
        nFrames = 10 % number of frames
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
            
        end % previews stimulus using matlab figure window, scales movie right now
        function [] = run(obj)
            
            frames = generate(obj);
            
            try
                window = Screen('OpenWindow', 0);
                Screen('FillRect', window, 0);
                
                % make textures
                for frame = 1:obj.nFrames
                    
                    textures(frame) = Screen('MakeTexture', window, frames(:,:,frame));
                    
                end
                
                
                for frame = 1:obj.nFrames
                    
                    Screen('DrawTexture', window, textures(frame));
                    Screen('Flip', window);
                    WaitSecs(1/obj.frameRate);
                    
                end
                
                Screen('CloseAll');
            catch
                Screen('CloseAll');
                
            end
            
            
            
            
        end % runs stimulus through psychtoolbox Screen function 
        
    end
    
    
    
end