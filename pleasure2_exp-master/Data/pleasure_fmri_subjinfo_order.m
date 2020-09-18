function [SID, SubjNum, order] = pleasure_fmri_subjinfo_order

SID = input('\nSubject ID? : ', 's');
SID = strtrim(SID);
SubjNum = input('\nSubject number? : ');
% SubjRun = input('\nRun number? : ');

basedir = pwd;
cd(basedir); addpath(genpath(basedir));

if SubjNum <= 126
    rundatdir = fullfile(basedir, 'Pleasure2_randomized_runs_data.mat');
    load(rundatdir, 'pls2_new_runs_randomized');
    order = pls2_new_runs_randomized(SubjNum,:);
end

SubjInfo_Order.SID = SID;
SubjInfo_Order.SubjNum = SubjNum;
SubjInfo_Order.order = order;

nowtime = clock;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
save_subjinfo_order = fullfile(basedir, [SubjDate, '_PLS', sprintf('%.3d', SubjNum), '_', SID, '_SubjInfo_Order.mat']);
save(save_subjinfo_order, 'SubjInfo_Order');

end