%% Set basic parameters and save data

global theWindow W H window_ratio  %window property
global lb1 rb1 lb2 rb2 scale_W scale_H anchor_lms  %rating scale
global bgcolor white red orange  %color

basedir = pwd;
cd(basedir);
addpath(genpath(basedir));

SID = input('\nSubject ID? : ', 's');
SID = strtrim(SID);


savedir = fullfile(basedir, 'BGS_Survey');
nowtime = clock;
Date = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
data.subject = SID;
data.datafile = fullfile(savedir, ['BGS_PLS_', Date, '_', SID, '.mat']);
data.version = 'Pleasure_v1_10-01-2018_Cocoanlab';
data.starttime = datestr(clock, 0);
data.starttime_getsecs = GetSecs;

% if the same file exists, break and retype subject info
if exist(data.datafile, 'file')
    fprintf('\n ** EXSITING FILE: %s %s **', data.subject);
    cont_or_not = input(['\nYou have already saved data with this subject information.', ...
        '\nWill you discard the data and re-start the survey?', ...
        '\n1: Yes, re-start the survey.  ,   2: No, it`s a mistake. I`ll break.\n:  ']);
    if cont_or_not == 2
        error('Breaked.')
    elseif cont_or_not == 1
        save(data.datafile, 'data');
    end
else
    save(data.datafile, 'data');
end

%% SETUP : Screen

bgcolor = 50;
% window_ratio = 3;

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
        window_rect = [0 0 1440 900];
        fontsize = 32;
end

% size
W = window_rect(3); % width
H = window_rect(4); % height
lb1 = W*(1/6); % rating scale left bounds 1/6
rb1 = W*(5/6); % rating scale right bounds 5/6
lb2 = W*(1/4); % rating scale left bounds 1/4
rb2 = W*(3/4); % rating scale right bounds 3/4

scale_W = W*0.1;
scale_H = H*0.1;

anchor_lms = [W/2-0.014*(W/2-lb2) W/2-0.061*(W/2-lb2) W/2-0.172*(W/2-lb2) W/2-0.354*(W/2-lb2) W/2-0.533*(W/2-lb2);
    W/2+0.014*(W/2-lb2) W/2+0.061*(W/2-lb2) W/2+0.172*(W/2-lb2) W/2+0.354*(W/2-lb2) W/2+0.533*(W/2-lb2)];
%W/2-lb2 = rb2-W/2

% color
white = 255;
red = [158 1 66];
orange = [255 164 0];

% font
% font = 'NanumBarunGothic';
Screen('Preference', 'TextEncodingLocale', 'ko_KR.UTF-8');

%% Start : Screen

theWindow = Screen('OpenWindow', window_num, bgcolor, window_rect); % start the screen
% Screen('TextFont', theWindow, font);
Screen('TextSize', theWindow, fontsize);

Screen(theWindow, 'FillRect', bgcolor, window_rect); % Just getting information, and do not show the scale.
Screen('Flip', theWindow);
HideCursor;

%% MAIN

BGS_questionnaires = call_BGS_questionnaires;
start_t = GetSecs;
data.dat.BGS_Survey_starttime = start_t;
labels = BGS_questionnaires.stimulus_types_label;
stimuli = BGS_questionnaires.stimulus_types_content;


while true
    msgtxt = '지금부터 설문을 시작합니다. (space)';
    DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white);
    Screen('Flip', theWindow);
    
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('space')) == 1
        break
    end
end

% Start the survey
for stimuli_i = 1:numel(stimuli)
    
    start_t = GetSecs;
    label = labels{stimuli_i};
    eval(['data.dat.' label '_timestamp = start_t;']);
    
    % randomize the order of ratings
    scale_random = randperm(2);
    
    % Get ratings
    if scale_random(1) == 1
        rec_i = 0;
        x = lb2;
        y = H*(1/2);
        SetMouse(x,y); % set mouse at the left
        first_start_t = GetSecs;
        while true
            rec_i = rec_i + 1;
            [x,~,button] = GetMouse(theWindow);
            scale = 'general_sensitivity';
            if x < lb2; x = lb2; elseif x > rb2; x = rb2; end
            [lb, rb, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
            Screen('Flip', theWindow);
            
            if button(1)
                while button(1)
                    [~,~,button] = GetMouse(theWindow);
                end
                break
            end
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
  
       
        
        cur_t = GetSecs;
        eval(['data.dat.' label '_gs_time_fromstart(rec_i,1) = cur_t-first_start_t;']);
        eval(['data.dat.' label '_gs_cont_rating(rec_i,1) = (x-lb2)/(rb2-lb2);']);
        
        % Freeze the screen 0.5 second with red line if overall type
        freeze_t = GetSecs;
        while true
            [lb2, rb2, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, red, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);
            Screen('Flip', theWindow);
            freeze_cur_t = GetSecs;
            if freeze_cur_t - freeze_t > 0.5
                break
            end
        end
        
        % do the other
        rec_i = 0;
        x = W/2;
        y = H*(1/2);
        SetMouse(x,y); % set mouse at the center
        second_start_t = GetSecs;
        while true
            rec_i = rec_i + 1;
            [x,~,button] = GetMouse(theWindow);
            scale = 'overall_glms';
            if x < lb1; x = lb1; elseif x > rb1; x = rb1; end
            [lb, rb, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
            Screen('Flip', theWindow);
            
            if button(1)
                while button(1)
                    [~,~,button] = GetMouse(theWindow);
                end
                break
            end
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        cur_t = GetSecs;
        eval(['data.dat.' label '_og_time_fromstart(rec_i,1) = cur_t-second_start_t;']);
        eval(['data.dat.' label '_og_cont_rating(rec_i,1) = (x-lb1)/(rb1-lb1);']);
        
        % Freeze the screen 0.5 second with red line if overall type
        freeze_t = GetSecs;
        while true
            [lb, rb, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, red, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);
            Screen('Flip', theWindow);
            freeze_cur_t = GetSecs;
            if freeze_cur_t - freeze_t > 0.5
                break
            end
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        
    else
        rec_i = 0;
        x = W/2;
        y = H*(1/2);
        SetMouse(x,y); % set mouse at the center
        first_start_t = GetSecs;
        while true
            rec_i = rec_i + 1;
            [x,~,button] = GetMouse(theWindow);
            scale = 'overall_glms';
            if x < lb1; x = lb1; elseif x > rb1; x = rb1; end
            [lb, rb, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
            Screen('Flip', theWindow);
            
            if button(1)
                while button(1)
                    [~,~,button] = GetMouse(theWindow);
                end
                break
            end
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        cur_t = GetSecs;
        eval(['data.dat.' label '_og_time_fromstart(rec_i,1) = cur_t-first_start_t;']);
        eval(['data.dat.' label '_og_cont_rating(rec_i,1) = (x-lb1)/(rb1-lb1);']);
        
        % Freeze the screen 0.5 second with red line if overall type
        freeze_t = GetSecs;
        while true
            [lb, rb, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, red, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);
            Screen('Flip', theWindow);
            freeze_cur_t = GetSecs;
            if freeze_cur_t - freeze_t > 0.5
                break
            end
        end
        
        % do the other
        rec_i = 0;
        x = lb2;
        y = H*(1/2);
        SetMouse(x,y); % set mouse at the left
        second_start_t = GetSecs;
        while true
            rec_i = rec_i + 1;
            [x,~,button] = GetMouse(theWindow);
            scale = 'general_sensitivity';
            if x < lb2; x = lb2; elseif x > rb2; x = rb2; end
            [lb2, rb2, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
            Screen('Flip', theWindow);
            
            if button(1)
                while button(1)
                    [~,~,button] = GetMouse(theWindow);
                end
                break
            end
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        cur_t = GetSecs;
        eval(['data.dat.' label '_gs_time_fromstart(rec_i,1) = cur_t-second_start_t;']);
        eval(['data.dat.' label '_gs_cont_rating(rec_i,1) = (x-lb2)/(rb2-lb2);']);
        
        % Freeze the screen 0.5 second with red line if overall type
        freeze_t = GetSecs;
        while true
            [lb, rb, start_center] = draw_scale_pls(scale);
            DrawFormattedText(theWindow, double(stimuli{stimuli_i}), 'center', H*(1/3), white, [], [], [], 2);
            Screen('DrawLine', theWindow, red, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);
            Screen('Flip', theWindow);
            freeze_cur_t = GetSecs;
            if freeze_cur_t - freeze_t > 0.5
                break
            end
        end
    end
end


if stimuli_i == numel(BGS_questionnaires.stimulus_types_content)
    while true
        msgtxt = '설문이 모두 끝났습니다.\n참가자분께서는 실험자의 지시에 따라주시기 바랍니다. (space)';
        msgtxt = double(msgtxt); % korean to double
        DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
        Screen('Flip', theWindow);
        
        [~,~,keyCode] = KbCheck;
        if keyCode(KbName('space')) == 1
            break
        end
    end
end


all_end_t = GetSecs;
data.dat.BGS_Survey_dur = all_end_t - start_t;

save(data.datafile, '-append', 'data');


ShowCursor;
Screen('Clear');
Screen('CloseAll');
