datdir = '/Users/salee/Dropbox/github/pleasure_exp/Behav_exp_data';
clear dat;

mat_sweet = filenames(fullfile(datdir, '*sweet*.mat'));
mat_touch = filenames(fullfile(datdir, '*touch*.mat'));

for i = 1:numel(mat_sweet)
    load(mat_sweet{i});
    overlap_idx = find(diff(data.dat.time_fromstart)==0);  % ��ġ�� �ð� ã��
    data.dat.time_fromstart(overlap_idx) = [];
    data.dat.cont_rating(overlap_idx) = [];  % �� �κ� ���ֱ�
    
    dat.sweet(i,:) = interp1(data.dat.time_fromstart, data.dat.cont_rating, 1:1000);  % �������� ���� timestamp�� ������ ����(1��)���� resampling
end

for i = 1:numel(mat_touch)
    load(mat_touch{i});
    overlap_idx = find(diff(data.dat.time_fromstart)==0);
    data.dat.time_fromstart(overlap_idx) = [];
    data.dat.cont_rating(overlap_idx) = [];
    
    dat.touch(i,:) = interp1(data.dat.time_fromstart, data.dat.cont_rating, 1:1000);
end


%% not include time with nans
clf;
subplot(4,1,1);
set(gcf, 'color', 'w');  % gcf: ���� figure �ڵ�

for i = 1:size(dat.sweet,1)
    plot(dat.sweet(i,:), 'color', [.7 .7 .7], 'linewidth', 1);
    hold on;
end

idx_nonan = find(sum(isnan(dat.sweet))>=1, 1, 'first')-1;  % ���������͵� �߿��� ù ��°�� NaN�� ������(������ ���� ���� ����) ���� �ٷ� �� ã��: 332��
wani_plot_shading(1:idx_nonan, mean(dat.sweet(:,1:idx_nonan)), std(dat.sweet(:,1:idx_nonan)), 'alpha', .5)
box off;
xlabel('seconds');
ylabel('pleasantness');
title('Sweet (no-nan time)');

line([0 1000], [0 0], 'color', 'k', 'linestyle', '--', 'linewidth', 1.5);
set(gca, 'linewidth', 1.5, 'fontsize', 15, 'tickdir', 'out')
% gca: ���� ��ǥ�� �Ǵ� ��Ʈ
% tick marks: �� ����

subplot(4,1,2);
for i = 1:size(dat.touch,1)
    plot(dat.touch(i,:), 'color', [.7 .7 .7], 'linewidth', 1);
    hold on;
end

idx_nonan = find(sum(isnan(dat.touch))>=1, 1, 'first')-1;  % ���������͵� �߿��� ù ��°�� NaN�� ������(������ ���� ���� ����) ���� �ٷ� �� ã��: 311��
wani_plot_shading(1:idx_nonan, mean(dat.touch(:,1:idx_nonan)), std(dat.touch(:,1:idx_nonan)), 'alpha', .5)
box off;
xlabel('seconds');
ylabel('pleasantness');
title('Touch (no-nan time)');

line([0 1000], [0 0], 'color', 'k', 'linestyle', '--', 'linewidth', 1.5);
set(gca, 'linewidth', 1.5, 'fontsize', 15, 'tickdir', 'out')

set(gcf, 'position', [1   395   642   560]);


% include time with nans
subplot(4,1,3);
set(gcf, 'color', 'w');

for i = 1:size(dat.sweet,1)
    plot(dat.sweet(i,:), 'color', [.7 .7 .7], 'linewidth', 1);
    hold on;
end

m = mean(dat.sweet);
nan_m = nanmean(dat.sweet);  % NaN �� �����ϰ� ���������� ��ü ��� ���ϱ�
idx_nonan = find(isnan(nan_m), 1, 'first')-1;  % ��տ��� ���� ���� ������ NaN �ٷ� �� ���� ã��: 976��

wani_plot_shading(1:idx_nonan, nanmean(dat.sweet(:,1:idx_nonan)), nanstd(dat.sweet(:,1:idx_nonan)), 'alpha', .3)
box off;
xlabel('seconds');
ylabel('pleasantness');
title('Sweet (whole time)');

line([0 1000], [0 0], 'color', 'k', 'linestyle', '--', 'linewidth', 1.5);
set(gca, 'linewidth', 1.5, 'fontsize', 15, 'tickdir', 'out')

subplot(4,1,4);
for i = 1:size(dat.touch,1)
    plot(dat.touch(i,:), 'color', [.7 .7 .7], 'linewidth', 1);
    hold on;
end

nan_m = nanmean(dat.touch);
idx_nonan = find(isnan(nan_m), 1, 'first')-1;  % ��տ��� ���� ���� ������ NaN �ٷ� �� ���� ã��: 763��

wani_plot_shading(1:idx_nonan, nanmean(dat.touch(:,1:idx_nonan)), nanstd(dat.touch(:,1:idx_nonan)), 'alpha', .3)
box off;
xlabel('seconds');
ylabel('pleasantness');
title('Touch (whole time)');

line([0 1000], [0 0], 'color', 'k', 'linestyle', '--', 'linewidth', 1.5);
set(gca, 'linewidth', 1.5, 'fontsize', 15, 'tickdir', 'out')


