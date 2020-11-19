function [SID, SubjNum, order] = pleasure_fmri_subjinfo_order

SID = input('\nSubject ID? (e.g. pdj) :    ', 's');
SID = strtrim(SID);
SubjNum = input('\nSubject number? (e.g. 1) : ');
% SubjRun = input('\nRun number? : ');

basedir = pwd;
cd(basedir); addpath(genpath(basedir));

if SubjNum <= 66
    rundatdir = fullfile(basedir, 'Pleasure2_randomized_run_data_final.mat');
    load(rundatdir, 'new_runs_randomized');
    order = new_runs_randomized(SubjNum,:);
else
    rundatdir = fullfile(basedir, 'Pleasure2_randomized_run_data_final2.mat');
    load(rundatdir, 'new_runs_randomized2');
    order = new_runs_randomized2(SubjNum-66,:);
end

SubjInfo_Order.SID = SID;
SubjInfo_Order.SubjNum = SubjNum;
SubjInfo_Order.order = order;

nowtime = clock;
SubjDate = sprintf('%.2d%.2d%.2d', nowtime(1), nowtime(2), nowtime(3));
save_subjinfo_order = fullfile(basedir, [SubjDate, '_PLST', sprintf('%.3d', SubjNum), '_', SID, '_SubjInfo_Order.mat']);
save(save_subjinfo_order, 'SubjInfo_Order');

end