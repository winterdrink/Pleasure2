function pleasure_fmri_t1(SID, SubjNum)

%% SETUP : Basic parameters

global theWindow W H window_ratio  %window property
global scale_W scale_H  %rating scale
global bgcolor white orange red  %color

basedir = pwd;
cd(basedir);
addpath(genpath(basedir));

%% SETUP : Save data according to subject information

savedir = fullfile(basedir, 'Data');

nowtime = clock;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));

data.subject = SID;
data.datafile = fullfile(savedir, [SubjDate, '_PLS', sprintf('%.3d', SubjNum), ...
    '_', SID, '_t1', '.mat']);
data.version = 'Pleasure_v1_08-27-2018_Cocoanlab';
data.starttime = datestr(clock, 0);
data.starttime_getsecs = GetSecs;

% if the same file exists, break and retype subject info
if exist(data.datafile, 'file')
    fprintf('\n ** EXSITING FILE: %s %s **', data.subject, SubjDate);
    cont_or_not = input(['\nYou type the run number that is inconsistent with the data previously saved.', ...
        '\nWill you go on with your run number that typed just before?', ...
        '\n1: Yes, continue with typed run number.  ,   2: No, it`s a mistake. I`ll break.\n:  ']);
    if cont_or_not == 2
        error('Breaked.')
    elseif cont_or_not == 1
        save(data.datafile, 'data');
    end
else
    save(data.datafile, 'data');
end

%% SETUP : Create paradigm according to subject information

data.dat.type = 'T1';
% data.dat.duration = 7*60+38;

%% SETUP : Screen

bgcolor = 50;
window_ratio = 3;

screens = Screen('Screens');
window_num = screens(1);
Screen('Preference', 'SkipSyncTests', 1);
screen_mode = 'full';
window_info = Screen('Resolution', window_num);
switch screen_mode
    case 'full'
        window_rect = [0 0 window_info.width window_info.height]; % full screen
        fontsize = 32;
    case 'semifull'
        window_rect = [0 0 window_info.width-100 window_info.height-100]; % a little bit distance
    case 'middle'
        window_rect = [0 0 window_info.width/2 window_info.height/2];
    case 'small'
        window_rect = [0 0 400 300]; % in the test mode, use a little smaller screen
        fontsize = 10;
    case 'test'
        window_rect = [0 0 window_info.width window_info.height]/window_ratio;
        fontsize = 20;
    case 'testmode'
        window_rect = [0 0 1440 900];  % 1920 1080]; full screen for window
        fontsize = 32;
end

% size
W = window_rect(3); % width
H = window_rect(4); % height
scale_W = W*0.1;
scale_H = H*0.1;

% color
white = 255;
red = [158 1 66];
orange = [255 164 0];

% font
% font = 'NanumBarunGothic';
Screen('Preference', 'TextEncodingLocale', 'ko_KR.UTF-8');

%% Start : Screen

theWindow = Screen('OpenWindow', window_num, bgcolor, window_rect); % start the screen
%Screen('TextFont', theWindow, font);
Screen('TextSize', theWindow, fontsize);

Screen(theWindow, 'FillRect', bgcolor, window_rect); % Just getting information, and do not show the scale.
Screen('Flip', theWindow);
HideCursor;

%% Start

while true % Space
    msgtxt = '잠시 후 구조촬영이 시작될 예정입니다.\n곧 나타날 화면 중앙의 + 표시를 응시하면서 편안히 계시기 바랍니다.\n준비가 완료되면 실험자는 스페이스바를 눌러주시기 바랍니다.';
    msgtxt = double(msgtxt);
    DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
    Screen('Flip', theWindow);
    
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('space')) == 1
        break
    elseif keyCode(KbName('q')) == 1
        abort_experiment('manual');
        break
    end
end


% Fixation cross

t1_start_t = GetSecs;
data.dat.t1_starttime = t1_start_t;

while true
    DrawFormattedText(theWindow, double('+'), 'center', 'center', white);
    Screen('Flip', theWindow);
    
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('q')) == 1
        break
    end
    
end

data.dat.t1_duration = GetSecs - t1_start_t;

save(data.datafile, 'data', '-append')


ShowCursor;
sca;
Screen('CloseAll');

end