function pleasure_fmri_task_main(SID, SubjNum, type, varargin)

%% SETUP : Basic parameters

global theWindow W H window_ratio  %window property
global lb1 rb1 lb2 rb2 scale_W scale_H anchor_lms  %rating scale
global bgcolor white orange red  %color

basedir = pwd;
cd(basedir);
addpath(genpath(basedir));

explain = false;
practice = false;
run = false;
USE_EYELINK = false;
USE_BIOPAC = false;
% savedir = fullfile(pwd, 'data');

%% PARSING VARARGIN

for i = 1:length(varargin)
    if ischar(varargin{i})
        switch varargin{i}
            % functional commands
            case {'explain'}
                explain = true;
            case {'practice'}
                practice = true;
            case {'run'}
                run = true;
                %             case {'savedir'}
                %                 savedir = varargin{i+1};
            case {'eyelink'}
                USE_EYELINK = true;
            case {'biopac'}
                USE_BIOPAC = true;
                channel_n = 3;
                biopac_channel = 0;
                ljHandle = BIOPAC_setup(channel_n); % BIOPAC SETUP
        end
    end
end

%% SETUP : Check subject information & load run order

SubjRun = input('\nRun number? : ');

%% SETUP : Save data according to subject information

savedir = fullfile(basedir, 'Data');

nowtime = clock;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));

data.subject = SID;
data.datafile = fullfile(savedir, [SubjDate, '_PLS', sprintf('%.3d', SubjNum), '_', SID, ...
    '_run', sprintf('%.2d', SubjRun), '_', char(type), '.mat']);
data.version = 'Pleasure_v1_10-04-2018_Cocoanlab';  % month-date-year
data.starttime = datestr(clock, 0);
data.starttime_getsecs = GetSecs;

% if the same file exists, break and retype subject info
if exist(data.datafile, 'file')
    fprintf('\n ** EXSITING FILE: %s %s **', data.subject, SubjDate);
    cont_or_not = input(['\nYou typed the run number that is inconsistent with the data previously saved.', ...
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
 
run_dur = 5;  % including disdaq(10s), except 8 secs before trigger

rating_types_pls = call_ratingtypes_pls;

data.dat.type = type;
data.dat.duration = run_dur;


%% SETUP : Screen

bgcolor = 50;
window_ratio = 1.1;

screens = Screen('Screens');
window_num = screens(1);
Screen('Preference', 'SkipSyncTests', 1);
screen_mode = 'small';
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

lb1 = W*(1/6); % rating scale left bounds 1/6
rb1 = W*(5/6); % rating scale right bounds 5/6
lb2 = W*(1/4); % rating scale left bounds 1/4
rb2 = W*(3/4); % rating scale right bounds 3/4

scale_W = W*0.1;
scale_H = H*0.1;

anchor_lms = [W/2-0.014*(W/2-lb1) W/2-0.061*(W/2-lb1) W/2-0.172*(W/2-lb1) W/2-0.354*(W/2-lb1) W/2-0.533*(W/2-lb1);
    W/2+0.014*(W/2-lb1) W/2+0.061*(W/2-lb1) W/2+0.172*(W/2-lb1) W/2+0.354*(W/2-lb1) W/2+0.533*(W/2-lb1)];
%W/2-lb1 = rb1-W/2

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

Screen(theWindow, 'FillRect', bgcolor, window_rect);
Screen('Flip', theWindow);
HideCursor;

%% SETUP: Save eyelink filename according to subject information

% need to be revised when the eyelink is here.
if USE_EYELINK
    
    edf_filename = ['P_' SID '_' sprintf('%.1d', SubjRun)]; % name should be equal or less than 7
    edfFile = sprintf('%s.EDF', edf_filename);
    eyelink_main(edfFile, 'Init');
    
    status = Eyelink('Initialize');
    if status
        error('Eyelink is not communicating with PC. It is okay though.');
    end
    Eyelink('Command', 'set_idle_mode');
    waitsec_fromstarttime(GetSecs, .5);
    
end
%% Start

try
    %% (Explain) Continuous & Overall
    
    if explain
        
        % Explain bi-directional scale with visualization
        while true % Button
            msgtxt = '지금부터 실험이 시작됩니다. 먼저, 실험을 진행하기에 앞서 평가 척도에 대한 설명을 진행하겠습니다.\n\n참가자는 모든 준비가 완료되면 버튼을 눌러주시기 바랍니다.';
            DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
            Screen('Flip', theWindow);
            
            [~,~,button] = GetMouse(theWindow);
            if button(1) == 1
                break
            end
        end
        
        while true % Space
            Screen(theWindow, 'FillRect', bgcolor, window_rect);
            cont_rat_scale = imread('gLMS_bidirectional_rating_scale','jpg');
            [s1, s2, s3] = size(cont_rat_scale);
            cont_rat_scale_texture = Screen('MakeTexture', theWindow, cont_rat_scale);
            Screen('DrawTexture', theWindow, cont_rat_scale_texture, [0 0 s2 s1],[0 0 W H]);  %show the continuous rating scale
            Screen('Flip', theWindow);
            
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('space')) == 1
                break
            elseif keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        
        % go to the next after space is unpressed
        while keyCode(KbName('space')) == 1
            if keyCode(KbName('space')) == 1
                while keyCode(KbName('space')) == 1
                    [~,~,keyCode] = KbCheck;
                end
                break
            end
        end
        
        
        
        % Explain one-directional scale with visualization
        while true % Space
            Screen(theWindow, 'FillRect', bgcolor, window_rect);
            overall_rat_scale = imread('gLMS_unidirectional_rating_scale','jpg');
            [s1, s2, s3] = size(overall_rat_scale);
            overall_rat_scale_texture = Screen('MakeTexture', theWindow, overall_rat_scale);
            Screen('DrawTexture', theWindow, overall_rat_scale_texture, [0 0 s2 s1],[0 0 W H]);
            Screen('PutImage', theWindow, overall_rat_scale); %show the overall rating scale
            Screen('Flip', theWindow);
            
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('space')) == 1
                break
            elseif keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        
    end
    
    %% (Practice) Continuous & Overall
    
    if practice
        
        % bi-directional
        x = W/2;
        y = H*(1/2);
        SetMouse(x,y)
        anchor_type = {'cont_glms_unpls', 'cont_glms_pls'};
        anchor_practice = [anchor_type(randperm(2)) anchor_type(randperm(2))];
        
        for prac_i = 1:length(anchor_practice)
            WaitSecs(0.5);
            disp(prac_i);
            button = [];
            iswhile =1;
            while iswhile % button
                msgtxt = '평가 예제 : 참가자는 충분히 평가 방법을 연습한 후, 연습이 끝나면 버튼을 눌러주시기 바랍니다.';
                DrawFormattedText(theWindow, double(msgtxt), 'center', H*(1/4), white, [], [], [], 2);
                draw_scale_pls(anchor_practice{prac_i});
                Screen('DrawLine', theWindow, white, lb1, H*(1/2), rb1, H*(1/2), 4); %rating scale
                % penWidth: 0.125~7.000
                Screen('DrawLine', theWindow, white, W/2, H*(1/2)-scale_H/3, W/2, H*(1/2)+scale_H/3, 6);
                Screen('DrawLine', theWindow, white, lb1, H*(1/2)-scale_H/3, lb1, H*(1/2)+scale_H/3, 6);
                Screen('DrawLine', theWindow, white, rb1, H*(1/2)-scale_H/3, rb1, H*(1/2)+scale_H/3, 6);
                Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
                Screen('Flip', theWindow);
                
                [x,~,button] = GetMouse(theWindow);
                if x < lb1; x = lb1; elseif x > rb1; x = rb1; end
                
                [~,~,keyCode] = KbCheck;
                if button(1) == 1
                    iswhile = 0;
                elseif keyCode(KbName('q')) == 1
                    abort_experiment('manual');
                    iswhile =0;
                end
            end
            
        end
        
        
        % go to the next after the button is unpressed
        while (1)
            if button(1)
                while button(1)
                    [~,~,button] = GetMouse(theWindow);
                end
                break
            end
        end
        
        % one-directional
        x = W*(1/4);
        y = H*(1/2);
        SetMouse(x,y)
        
        while true % button
            msgtxt = '평가 예제 : 참가자는 충분히 평가 방법을 연습한 후, 연습이 끝나면 버튼을 눌러주시기 바랍니다.';
            DrawFormattedText(theWindow, double(msgtxt), 'center', H*(1/4), white, [], [], [], 2);
            Screen('DrawLine', theWindow, white, lb2, H*(1/2), rb2, H*(1/2), 4); %rating scale
            % penWidth: 0.125~7.000
            Screen('DrawLine', theWindow, white, lb2, H*(1/2)-scale_H/3, lb2, H*(1/2)+scale_H/3, 6);
            Screen('DrawLine', theWindow, white, rb2, H*(1/2)-scale_H/3, rb2, H*(1/2)+scale_H/3, 6);
            Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
            Screen('Flip', theWindow);
            
            [x,~,button] = GetMouse(theWindow);
            if x < lb2; x = lb2; elseif x > rb2; x = rb2; end
            [~,~,keyCode] = KbCheck;
            if button(1) == 1
                break
            elseif keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
            
        end
        
    end
    
    %% (Main) Continuous
    
    if run
        
        while true % Start, Space
            msgtxt = '\n실험자는 모든 것이 잘 준비되었는지 체크해주세요 (Biopac, Eyelink, 등등).\n\n모두 준비되었으면, 스페이스바를 눌러주세요.';
            DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
            Screen('Flip', theWindow);
            
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('space')) == 1
                break
            elseif keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        while true % Ready, s
            msgtxt = '시작합니다...';
            DrawFormattedText(theWindow, double(msgtxt), 'center', 'center', white, [], [], [], 2);
            Screen('Flip', theWindow);
            
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('s')) == 1
                savenum = 1;
                save_timestamp{savenum} = GetSecs;
                data.dat.cont_rat_save_timestamp = save_timestamp;
                save(data.datafile, 'data', '-append')
                break
            elseif keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
        end
        
        if USE_EYELINK
            Eyelink('StartRecording');
            data.dat.eyetracker_starttime = GetSecs; % eyelink timestamp
            Eyelink('Message','Continuous Rating Start');
        end
        
        if USE_BIOPAC
            data.dat.biopac_starttime = GetSecs; % biopac timestamp
            BIOPAC_trigger(ljHandle, biopac_channel, 'on');
            waitsec_fromstarttime(data.dat.biopac_starttime, 1.5);
            BIOPAC_trigger(ljHandle, biopac_channel, 'off');
        end

        
        %% Continuous rating
        % This includes disdaq (8~9s), so cut out 10 secs from baseline
        % (1.5 mins)
        
        cont_rat_start_t = GetSecs;
        data.dat.cont_rating_starttime = cont_rat_start_t;
        
        rec_i = 0;
        x = W/2;
        y = H*(1/2);
        SetMouse(x,y)
        
        while GetSecs - cont_rat_start_t < run_dur  % duration of continuous rating
            
            rec_i = rec_i + 1;
            Screen(theWindow, 'FillRect', bgcolor, window_rect);

%             if type{1} == 'CAPS ' | type{1} == 'QUIN '
              
              data_num = size(filenames(fullfile(basedir,['Data/*' rating_types_pls.postallstims{SubjRun} '.mat'])),1);
               
              if isequal(char(type),'RE')
                  % For Rest run
                  if mod(data_num,2) == 1  % odd number
                      [lb, rb, start_center] = draw_scale_pls('cont_glms_unpls');
                      msgtxt = '현재 상태가 얼마나 불쾌 혹은 유쾌한지를 지속적으로 보고해주세요.';
                  else
                      [lb, rb, start_center] = draw_scale_pls('cont_glms_pls');
                      msgtxt = '현재 상태가 얼마나 유쾌 혹은 불쾌한지를 지속적으로 보고해주세요.';
                  end
              else
                  % For the other runs
                  if mod(data_num,2) == 1  % odd number
                      [lb, rb, start_center] = draw_scale_pls('cont_glms_unpls');
                      msgtxt = '이 자극이 얼마나 불쾌 혹은 유쾌한지를 지속적으로 보고해주세요.';
                  else
                      [lb, rb, start_center] = draw_scale_pls('cont_glms_pls');
                      msgtxt = '이 자극이 얼마나 유쾌 혹은 불쾌한지를 지속적으로 보고해주세요.';
                  end
              end
            
            DrawFormattedText(theWindow, double(msgtxt), 'center', H*(1/4), orange);
            [x,~,~] = GetMouse(theWindow);
            if x < lb1; x = lb1; elseif x > rb1; x = rb1; end
            Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);  %rating bar
            Screen('Flip', theWindow);
            
            cont_rat_cur_t = GetSecs;
            data.dat.cont_rating_time_fromstart(rec_i,1) = cont_rat_cur_t-cont_rat_start_t;
            data.dat.cont_rating(rec_i,1) = (x-W/2)/(rb1-lb1).*2;
            
            
            % save data after 9 mins
            for i = 1
                k = 0;
                while GetSecs - data.dat.cont_rating_starttime > 7*60-0.5 && GetSecs - data.dat.cont_rating_starttime < 7*60+0.5
                    k = k + 1;
                    if k == 1
                        savenum = 2;
                        save_timestamp{savenum} = GetSecs;
                        data.dat.cont_rat_save_timestamp = save_timestamp;
                        save(data.datafile, 'data', '-append')
                    end
                end
            end
            
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                
                data.dat.cont_rating_dur = GetSecs - cont_rat_start_t;  % should be equal to run_dur - disdaq
                save(data.datafile, 'data', '-append');  % also save the lasting time when aborted
                
                break
            end
            
        end
        
        % end anyway after one session
        waitsec_fromstarttime(data.dat.cont_rating_starttime, run_dur)  % run duration (with disdaq) except 8 secs
        
        data.dat.cont_rating_dur = GetSecs - cont_rat_start_t;  % should be equal to run_dur - disdaq
        savenum = 3;
        save_timestamp{savenum} = GetSecs;
        data.dat.cont_rat_save_timestamp = save_timestamp;
        save(data.datafile, 'data', '-append')
        
        if USE_EYELINK
            Eyelink('Message','Continuous Rating End');
        end
        
        if USE_BIOPAC
            data.dat.biopac_endtime = GetSecs; % biopac timestamp
            BIOPAC_trigger(ljHandle, biopac_channel, 'on');
            ending_trigger = (2*SubjRun-1)/10;  % 0.1, 0.3, 0.5, 0.7, 0.9
            waitsec_fromstarttime(data.dat.biopac_endtime, ending_trigger);
            BIOPAC_trigger(ljHandle, biopac_channel, 'off');
        end
        
        
        %% MAIN : Postrun questionnaire
        
        all_start_t = GetSecs;
        data.dat.postrun_starttime = all_start_t;
        ratestim = strcmp(rating_types_pls.postallstims, type);
        % rating_types_pls.postallstims = {'RE', 'CC ', 'SS', 'C0', 'CS'};
        % 1 appears at the right type of this session
        % Ex: 'CS' session --> 0 0 0 0 1 (logical)
        scales = rating_types_pls.postalltypes{ratestim};
        
        Screen(theWindow, 'FillRect', bgcolor, window_rect);
        msgtxt = [num2str(SubjRun) '번째 세션이 끝났습니다.\n\n잠시 후 질문들이 제시될 것입니다. 참가자분께서는 기다려주시기 바랍니다.'];
        msgtxt = double(msgtxt);
        DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
        Screen('Flip', theWindow);
        
        if USE_EYELINK
            Eyelink('Message','Postrun Questionnaires Start');
        end
        
        waitsec_fromstarttime(all_start_t, 4)
        
        
        for scale_i = 1:numel(scales)
            
            scale = scales{scale_i};
            [lb, rb, start_center] = draw_scale_pls(scale);
            
            Screen(theWindow, 'FillRect', bgcolor, window_rect);
            
            start_t = GetSecs;
            eval(['data.dat.' scale '_starttime = start_t;']);
            
            rec_i = 0;
            ratetype = strcmp(rating_types_pls.alltypes, scale);
            % corresponding one among all postrun questionnaires
            % Ex: scale = 'overall_resting_touch_glms' (5th)
            
            % Initial position
            if start_center
                SetMouse(W/2,H/2); % set mouse at the center
            else
                SetMouse(lb,H/2); % set mouse at the left
            end
            
            % Get ratings
            while true
                rec_i = rec_i + 1;
                [x,~,button] = GetMouse(theWindow);
                [lb, rb, start_center] = draw_scale_pls(scale);
                if x < lb; x = lb; elseif x > rb; x = rb; end
                
                DrawFormattedText(theWindow, double(rating_types_pls.prompts{ratetype}), 'center', H*(1/4), white, [], [], [], 2);
                Screen('DrawLine', theWindow, orange, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6); %rating bar
                Screen('Flip', theWindow);
                
                if button(1)
                    while button(1)
                        [~,~,button] = GetMouse(theWindow);
                    end
                    break
                end
                
                cur_t = GetSecs;
                eval(['data.dat.' scale '_time_fromstart(rec_i,1) = cur_t-start_t;']);
                eval(['data.dat.' scale '_rating_trajectory(rec_i,1) = (x-lb)/(rb-lb);']);
                
            end
            
            end_t = GetSecs;
            eval(['data.dat.' scale '_rating_endpoint = (x-lb)/(rb-lb);']);
            eval(['data.dat.' scale '_duration = end_t - start_t;']);
            
            % Freeze the screen 0.5 second with red line if overall type
            freeze_t = GetSecs;
            while true
                [lb, rb, start_center] = draw_scale_pls(scale);
                DrawFormattedText(theWindow, double(rating_types_pls.prompts{ratetype}), 'center', H*(1/4), white, [], [], [], 2);
                Screen('DrawLine', theWindow, red, x, H*(1/2)-scale_H/3, x, H*(1/2)+scale_H/3, 6);
                Screen('Flip', theWindow);
                freeze_cur_t = GetSecs;
                if freeze_cur_t - freeze_t > 0.5
                    break
                end
            end
            
            if scale_i == numel(scales)
                msgtxt = '질문이 끝났습니다.';
                msgtxt = double(msgtxt); % korean to double
                DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
                Screen('Flip', theWindow);
                
                % wait for 2 secs to end
                postrun_end = GetSecs;
                waitsec_fromstarttime(postrun_end, 2);
                
            end
            
        end
        
        
        all_end_t = GetSecs;
        data.dat.postrun_dur = all_end_t - all_start_t;
        
        save(data.datafile, 'data', '-append');
        
        
        if USE_EYELINK
            Eyelink('Message','Postrun Questionnaires End');
            eyelink_main(edfFile, 'Shutdown');
        end
        
        
        %% Closing screen
        
        while true % Space
            
            [~,~,keyCode] = KbCheck;
            if keyCode(KbName('space'))
                while keyCode(KbName('space'))
                    [~,~,keyCode] = KbCheck;
                end
                break
            end
            
            if keyCode(KbName('q')) == 1
                abort_experiment('manual');
                break
            end
            
            msgtxt = [num2str(SubjRun) '번째 세션이 끝났습니다.\n\n세션을 마치려면, 실험자는 스페이스바를 눌러주시기 바랍니다.'];
            msgtxt = double(msgtxt); % korean to double
            DrawFormattedText(theWindow, msgtxt, 'center', 'center', white, [], [], [], 2);
            Screen('Flip', theWindow);
            
        end
        
        ShowCursor;
        sca;
        Screen('CloseAll');
        
    end
    
    
catch err
    % ERROR
    disp(err);
    for i = 1:numel(err.stack)
        disp(err.stack(i));
    end
    abort_experiment('error');
end
end