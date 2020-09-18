result = [17.05 10.7 12.9 15.2 20.05;   % CWW
    7.9 11 5 16.25 13.85;   % JJ
    10.55 8.65 9.5 12.9 12.1;   % BK
    16.2 11.25 17.9 18.5 18.4;   % YWH
    7.2 8.3 3.95 4.35 3.5;   % SHG
    1.8 9.05 9.5 17.3 12.5;   % LK
    20.1 6.1 17.9 4.05 1.2;   % SYL
    1.9 17.1 7.1 12.65 0]./25.9;   % JHH

for i = 1:5
    result(9,i) = sum(result(:,i))/8;   % average
end
% result(9,:) = [0.3991 0.3965 0.4042 0.4884 0.3938];

result(10,:) = std(result(1:8,:));
% result(10,:) = [0.2670 0.1253 0.2074 0.2156 0.2978];


boxplot(result(1:8,:))
xlabel('Types of stimuli')
% hLegend = legend(findall(gca, 'Tag', 'Box'), {'sugary water','vanilla syrup','hazelnut syrup','hotchoco mitte','hotchoco swissmiss'});
ylabel('VAS score')

% paired t-test
% h: null hypothesis, p: p-value
% default: alpha = 0.05
x = result(1:8,1); y = result(1:8,2);
[h,p] = ttest(x-y);
x = result(1:8,2); y = result(1:8,3);
[h,p] = ttest(x-y);
x = result(1:8,3); y = result(1:8,4);
[h,p] = ttest(x-y);
x = result(1:8,4); y = result(1:8,5);
[h,p] = ttest(x-y);  