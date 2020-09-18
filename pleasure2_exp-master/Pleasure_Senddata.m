function Pleasure_Senddata(SID, SubjNum)
%
% Copyright 1984-2016 The MathWorks, Inc.
% This function requires Java.

%% SETTING: MAIL ACCOUNT
% This mail account created only for this function because this fucntion
% should include both address and password of account as variables
mail = 'pbc1159@gmail.com';   % Sooan's google mail
password = 'gozj10tk#wjf';
% mail address of receiver
rec_mail = 'pbc1159@google.com';   % Sooan's google mail

%% SETTING: SMTP protocol (gmail)
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
%
props = java.lang.System.getProperties;
clc;
disp('This function requires Java');
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

%% SETTING: Attachments, title and message
% :you can freely modify what you want do depends on your aim.

%pwd = '/Users/salee/Dropbox/github/pleasure_exp';
nowtime = clock;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
data_dir = {
    [pwd '/Data/' [SubjDate, '_', SID, '_PLS', sprintf('%.3d', SubjNum), '_run', sprintf('%.2d', 1), '.mat']];...
    [pwd '/Data/' [SubjDate, '_', SID, '_PLS', sprintf('%.3d', SubjNum), '_run', sprintf('%.2d', 2), '.mat']];...
    [pwd '/Data/' [SubjDate, '_', SID, '_PLS', sprintf('%.3d', SubjNum), '_run', sprintf('%.2d', 3), '.mat']];...
    [pwd '/Data/' [SubjDate, '_', SID, '_PLS', sprintf('%.3d', SubjNum), '_run', sprintf('%.2d', 4), '.mat']];...
    [pwd '/Data/' [SubjDate, '_', SID, '_PLS', sprintf('%.3d', SubjNum), '_run', sprintf('%.2d', 5), '.mat']];...
    };

%modify message
msg_title = ['MRI_experiment_' SID '_' datestr(now)];
msg_text = ['MRI_experiment' 'Subject Name:' SID '   ' 'Time:' datestr(now) '   ' 'data_files'];

% Attachment files
% attachment = CheFiles(data_dir);
for i = 1:length(data_dir)
    if exist(data_dir{i,1},'file')
        attachment{i,1} = data_dir{i,1};
    end
end

%% Send data to selected gmail
% Send mail (mail address, title of mail, contents, attachments files )
% e.g, sendmail(rec_mail,[sbj datestr(now)],[sbj datestr(now)
% 'data_files'], {Cali_dir, Learn_dir, Main_dir, Mot_dir });

sendmail(rec_mail, msg_title, msg_text, attachment);

%final_msg = strcat('Send total files\n',num2str(numel(attachment)),'see detatis:''\n',attachment, '\n:::');
clc;
fprintf('=========================Send total %d files================================\n',numel(attachment));
fprintf('DETAILS:\n');
fprintf(['Subject name: ' SID '\n']);
for i = 1:numel(attachment)
    fprintf(attachment{i});
    fprintf('\n');
end


end

function attachment = CheFiles(data_dir)
ii = 1;
for i = 1:length(data_dir)
    if exist(data_dir{1,i},'file')
        attachment{1, ii} = data_dir{1,i};
        ii = ii+1;
    end
end
end
