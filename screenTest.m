clear;clc
try
    
nFrames = 100;
frameRate = 24; % Hz

x = rand(100,100,nFrames)*255;



%%

window=Screen('OpenWindow',0)


%xTexture=Screen('MakeTexture', windowPtr, x)

for i = 1:nFrames


    
    frames(i) = Screen('MakeTexture', window, x(:,:,i))



end


for i = 1:nFrames

    Screen('DrawTexture', window, frames(i))
    Screen('Flip', window);
    
    WaitSecs(1/frameRate)
    
end

Screen('CloseAll')

catch ME

Screen('CloseAll');

end