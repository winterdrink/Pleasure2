clc;
clear;
close all;
%% EXPERIMENT %%
%% Subject info & load run order

[SID, SubjNum, order] = pleasure_fmri_subjinfo_order;

%% MAIN %%
%% T1

pleasure_fmri_t1(SID, SubjNum);

%% Main
%% Run 1

run_i = 1;
pleasure_fmri_task_main(SID, SubjNum, order(run_i),'explain', 'practice', 'run', 'biopac','eyelink')

%% RUN 2

run_i = 2;
pleasure_fmri_task_main(SID, SubjNum, order(run_i), 'run', 'biopac')%, 'eyelink')

%% RUN 3

run_i = 3;
pleasure_fmri_task_main(SID, SubjNum, order(run_i),  'run', 'biopac')%, 'eyelink')
%% RUN 4

run_i = 4;
pleasure_fmri_task_main(SID, SubjNum, order(run_i), 'run', 'biopac')%, 'eyelink')

%% RUN 5

run_i = 5;
pleasure_fmri_task_main(SID, SubjNum, order(run_i), 'run', 'biopac')%, 'eyelink')

%% SEND DATA
Pleasure_Senddata(SID, SubjNum)
