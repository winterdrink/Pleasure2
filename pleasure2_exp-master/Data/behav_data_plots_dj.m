%% get data
datdir = '/Users/dongjupark/Dropbox/Pleasure2/Data';
cd(datdir);
addpath(genpath(pwd));

%% plot for continuous rating

sublist = dir(datdir);
%subnames = {sublist.name}'
subnames = filenames(fullfile(datdir, '*_PLS009_psy_run0*.mat')); % sub's initial

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



%% clear and close

clear all
close all


