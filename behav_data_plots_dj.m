%% get data
datdir = '/Users/dongjupark/Dropbox/Pleasure2/Data/pilot_data';
cd(datdir);
addpath(genpath(pwd));

%% plot for continuous rating

sublist = dir(datdir);
%subnames = {sublist.name}'
subnames = filenames(fullfile(datdir, '*09_PLS001_test_run0*.mat')); % sub's initial

figure;
nodata=0;
for i = 1:numel(subnames)
    load(subnames{i})
    if isfield(data, 'dat') == 0
        nodata = nodata + 1;
        i % run excepted
    elseif isfield(data, 'dat') == 1
        load(subnames{i})
        x = data.dat.cont_rating_time_fromstart;
        y = data.dat.cont_rating;
        subplot(numel(subnames)-nodata,1,i-nodata);
        plot(x,-y)
        axis([0 870 -0.7 0.7]);
        xlabel('time (secs)', 'FontSize', 10);
        ylabel('rating (-1 ~ 1)', 'FontSize', 10);
        title(data.starttime);
        hold on;
        yline(0);
    end
end

load(subnames{i})
x = data.dat.cont_rating_time_fromstart;
y = data.dat.cont_rating;
subplot(numel(subnames)-nodata,1,i-nodata);
plot(x,-y)
axis([0 870 -0.7 0.7]);
xlabel('time (secs)', 'FontSize', 10);
ylabel('rating (-1 ~ 1)', 'FontSize', 10);
title(data.starttime);
hold on;
yline(0);

%% run order


ordersubs = filenames(fullfile(datdir, '*_SubjInfo_Order*.mat'));
orders = cell(numel(ordersubs),1);

for i = 1:numel(ordersubs)
    load(ordersubs{i});
    orders{i,1} = SubjInfo_Order.SubjNum;
    orders{i,2} = SubjInfo_Order.SID;
    orders{i,3} = SubjInfo_Order.order;    % run-order match for each subj, later!
end

orders = cell2table(orders);



%% for each session

clear datdir;
datdir = '/Users/dongjupark/Dropbox/Pleasure2_codes/Data';
cd(datdir);
addpath(genpath(pwd));

sublist = dir(datdir);
%subnames = {sublist.name}'
subnames = filenames(fullfile(datdir, '*run0*.mat'));
sessions = ["C0"; "CC"; "CS"; "SS"; "RE"];

% for i = 1:numel(subnames)
%     load(subnames{i});
%     if data.dat.type == 

figure;

for i = 1:numel(subnames)
    load(subnames{i});
    for j = 1:numel(sessions)
        if data.dat.type == sessions(j)
            x = data.dat.cont_rating_time_fromstart;
            y = data.dat.cont_rating;
            plot(x,-y)
            subplot(3,2,j);
            axis([0 870 -1 1]);
            xlabel('time (secs)', 'FontSize', 10);
            ylabel('rating (-1 ~ 1)', 'FontSize', 10);
            title(data.dat.type);
            hold on;
            yline(0);
        end
    end
end


% pleasure_fmri_task_main�� line 49���� subinfo, data ������
% ���� 9�� ������ �ѹ� �� ����
% mod(data_num,2) == 1 �̸� ���谡 ������, �� ������ ����ְ�, �ƴ� ���ڸ� �־ �ǰ�
% �� ������ ����ǵ���!

