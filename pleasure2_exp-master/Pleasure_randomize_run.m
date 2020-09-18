%% Save randmoized run order. Each version contains 120 pairs.

Runs = {'RE ', 'CC', 'SS', 'C0', 'CS'}; 
Runs = Runs(perms(1:5)); % all possible pairs from permutation
% Runs = Runs(randperm(size(Runs, 1)), :); % randomize the order
Runs_1 = Runs(1:24,:);  % start with 'CS'
Runs_2 = Runs(25:48,:);  % start with 'C0'
Runs_3 = Runs(49:72,:);  % start with 'SS'
Runs_4 = Runs(73:96,:);  % start with 'CC'
Runs_5 = Runs(97:120,:);  % start with 'RE'

%% Divide into 2 halves
%% First half (part1)

for i = 1:12
    Runs_1_odd(i,:) = Runs_1(2*i-1,:);
    Runs_2_even(i,:) = Runs_2(2*i,:);
    Runs_3_odd(i,:) = Runs_3(2*i-1,:);
    Runs_4_even(i,:) = Runs_4(2*i,:);
end

Runs_5_oddeven(1,:) = Runs_5(1,:);  % 1st row
Runs_5_oddeven(2,:) = Runs_5(4,:);  % 4th row
Runs_5_oddeven(3,:) = Runs_5(5,:);  % 5th row
Runs_5_oddeven(4,:) = Runs_5(8,:);  % 8th row
Runs_5_oddeven(5,:) = Runs_5(9,:);  % 9th row
Runs_5_oddeven(6,:) = Runs_5(12,:);  % 12th row
Runs_5_oddeven(7,:) = Runs_5(13,:);  % 13th row
Runs_5_oddeven(8,:) = Runs_5(16,:);  % 16th row
Runs_5_oddeven(9,:) = Runs_5(17,:);  % 17th row
Runs_5_oddeven(10,:) = Runs_5(20,:);  % 20th row
Runs_5_oddeven(11,:) = Runs_5(21,:);  % 21st row
Runs_5_oddeven(12,:) = Runs_5(24,:);  % 24th row

Runs_randomized(1:12,:) = Runs_1_odd;
Runs_randomized(13:24,:) = Runs_2_even;
Runs_randomized(25:36,:) = Runs_3_odd;
Runs_randomized(37:48,:) = Runs_4_even;
Runs_randomized(49:60,:) = Runs_5_oddeven;

save('Pleasure2_randomized_run_data.mat','Runs_randomized');  %base data


Runs_randomized(58,:) = {'RE', 'CC','SS','CS','C0'};
Runs_randomized(8,:) = {'CS', 'QUIN ','CC','C0', 'RE'};
Runs_randomized(20,:) = {'RE','CC','CS','SS','C0'};

save('Pleasure2_randomized_run_data_v1.mat','Runs_randomized');  %equal transition rates

% Final version of part1 (according to 'Pleasure_scannote.xlsx')
for i = 1:7
    new_runs_randomized(i,:) = Runs_randomized(i,:);
end
new_runs_randomized(8,:) = Runs_randomized(13,:);
new_runs_randomized(9,:) = Runs_randomized(25,:);
new_runs_randomized(10,:) = Runs_randomized(37,:);
new_runs_randomized(11,:) = Runs_randomized(20,:);
new_runs_randomized(12,:) = Runs_randomized(7,:);
new_runs_randomized(13,:) = Runs_randomized(16,:);
new_runs_randomized(14,:) = Runs_randomized(28,:);
new_runs_randomized(15,:) = Runs_randomized(40,:);
new_runs_randomized(16,:) = Runs_randomized(49,:);
new_runs_randomized(17,:) = Runs_randomized(1,:);
new_runs_randomized(18,:) = Runs_randomized(19,:);
new_runs_randomized(19,:) = Runs_randomized(31,:);
new_runs_randomized(20,:) = Runs_randomized(43,:);
new_runs_randomized(21,:) = Runs_randomized(52,:);
new_runs_randomized(22,:) = Runs_randomized(4,:);
new_runs_randomized(23,:) = Runs_randomized(22,:);
new_runs_randomized(24,:) = Runs_randomized(34,:);
new_runs_randomized(25,:) = Runs_randomized(46,:);
new_runs_randomized(26,:) = Runs_randomized(55,:);
new_runs_randomized(27,:) = Runs_randomized(9,:);
new_runs_randomized(28,:) = Runs_randomized(14,:);
new_runs_randomized(29,:) = Runs_randomized(26,:);
new_runs_randomized(30,:) = Runs_randomized(38,:);
new_runs_randomized(31,:) = Runs_randomized(58,:);
new_runs_randomized(32,:) = Runs_randomized(10,:);
new_runs_randomized(33,:) = Runs_randomized(17,:);
new_runs_randomized(34,:) = Runs_randomized(29,:);
new_runs_randomized(35,:) = Runs_randomized(41,:);
new_runs_randomized(36,:) = Runs_randomized(50,:);
new_runs_randomized(37,:) = Runs_randomized(11,:);
new_runs_randomized(38,:) = Runs_randomized(23,:);
new_runs_randomized(39,:) = Runs_randomized(32,:);
new_runs_randomized(40,:) = Runs_randomized(44,:);
new_runs_randomized(41,:) = Runs_randomized(53,:);
new_runs_randomized(42,:) = Runs_randomized(8,:);
new_runs_randomized(43,:) = Runs_randomized(15,:);
new_runs_randomized(44,:) = Runs_randomized(35,:);
new_runs_randomized(45,:) = Runs_randomized(47,:);
new_runs_randomized(46,:) = Runs_randomized(56,:);
new_runs_randomized(47,:) = Runs_randomized(12,:);
new_runs_randomized(48,:) = Runs_randomized(18,:);
new_runs_randomized(49,:) = Runs_randomized(27,:);
new_runs_randomized(50,:) = Runs_randomized(39,:);
new_runs_randomized(51,:) = Runs_randomized(59,:);
new_runs_randomized(52,:) = Runs_randomized(2,:);
new_runs_randomized(53,:) = Runs_randomized(21,:);
new_runs_randomized(54,:) = Runs_randomized(30,:);
new_runs_randomized(55,:) = Runs_randomized(42,:);
new_runs_randomized(56,:) = Runs_randomized(51,:);
new_runs_randomized(57,:) = Runs_randomized(3,:);
new_runs_randomized(58,:) = Runs_randomized(24,:);
new_runs_randomized(59,:) = Runs_randomized(54,:);
new_runs_randomized(60,:) = Runs_randomized(33,:);
new_runs_randomized(61,:) = Runs_randomized(45,:);
new_runs_randomized(62,:) = Runs_randomized(57,:);
new_runs_randomized(63,:) = Runs_randomized(5,:);
new_runs_randomized(64,:) = Runs_randomized(36,:);
new_runs_randomized(65,:) = Runs_randomized(48,:);
new_runs_randomized(66,:) = Runs_randomized(60,:);

save('Pleasure_randomized_run_data_final.mat','new_runs_randomized');


%% Second half (part2)
for i = 1:12
    Runs_1_even(i,:) = Runs_1(2*i,:);
    Runs_2_odd(i,:) = Runs_2(2*i-1,:);
    Runs_3_even(i,:) = Runs_3(2*i,:);
    Runs_4_odd(i,:) = Runs_4(2*i-1,:);
end

Runs_5_oddeven2(1,:) = Runs_5(2,:);  % 2nd row
Runs_5_oddeven2(2,:) = Runs_5(3,:);  % 3rd row
Runs_5_oddeven2(3,:) = Runs_5(6,:);  % 6th row
Runs_5_oddeven2(4,:) = Runs_5(7,:);  % 7th row
Runs_5_oddeven2(5,:) = Runs_5(10,:);  % 10th row
Runs_5_oddeven2(6,:) = Runs_5(11,:);  % 11th row
Runs_5_oddeven2(7,:) = Runs_5(14,:);  % 14th row
Runs_5_oddeven2(8,:) = Runs_5(15,:);  % 15th row
Runs_5_oddeven2(9,:) = Runs_5(18,:);  % 18th row
Runs_5_oddeven2(10,:) = Runs_5(19,:);  % 19th row
Runs_5_oddeven2(11,:) = Runs_5(22,:);  % 22dn row
Runs_5_oddeven2(12,:) = Runs_5(23,:);  % 23rd row

Runs_randomized2(1:12,:) = Runs_1_even;
Runs_randomized2(13:24,:) = Runs_2_odd;
Runs_randomized2(25:36,:) = Runs_3_even;
Runs_randomized2(37:48,:) = Runs_4_odd;
Runs_randomized2(49:60,:) = Runs_5_oddeven2;

save('Pleasure2_randomized_run_data2.mat','Runs_randomized2');  %base data

Runs_randomized2(3,:) = {'CS', 'CC','C0','RE','SS'};
Runs_randomized2(5,:) = {'RE', 'SS','CC','CS','C0'};
Runs_randomized2(6,:) = {'CS', 'RE','SS','C0', 'CC'};
Runs_randomized2(40,:) = {'CC', 'RE','CS','SS', 'C0'};

save('Pleasure2_randomized_run_data_v2.mat','Runs_randomized2');  %equal transition rates

% Final version of part2 (according to 'Pleasure_scannote.xlsx')
new_runs_randomized2(1,:) = Runs_randomized2(1,:);
new_runs_randomized2(2,:) = Runs_randomized2(13,:);
new_runs_randomized2(3,:) = Runs_randomized2(25,:);
new_runs_randomized2(4,:) = Runs_randomized2(37,:);
new_runs_randomized2(5,:) = Runs_randomized2(5,:);
new_runs_randomized2(6,:) = Runs_randomized2(2,:);
new_runs_randomized2(7,:) = Runs_randomized2(14,:);
new_runs_randomized2(8,:) = Runs_randomized2(26,:);
new_runs_randomized2(9,:) = Runs_randomized2(38,:);
new_runs_randomized2(10,:) = Runs_randomized2(49,:);
new_runs_randomized2(11,:) = Runs_randomized2(3,:);
new_runs_randomized2(12,:) = Runs_randomized2(15,:);
new_runs_randomized2(13,:) = Runs_randomized2(27,:);
new_runs_randomized2(14,:) = Runs_randomized2(39,:);
new_runs_randomized2(15,:) = Runs_randomized2(50,:);
new_runs_randomized2(16,:) = Runs_randomized2(4,:);
new_runs_randomized2(17,:) = Runs_randomized2(16,:);
new_runs_randomized2(18,:) = Runs_randomized2(28,:);
new_runs_randomized2(19,:) = Runs_randomized2(40,:);
new_runs_randomized2(20,:) = Runs_randomized2(51,:);
new_runs_randomized2(21,:) = Runs_randomized2(6,:);
new_runs_randomized2(22,:) = Runs_randomized2(17,:);
new_runs_randomized2(23,:) = Runs_randomized2(29,:);
new_runs_randomized2(24,:) = Runs_randomized2(41,:);
new_runs_randomized2(25,:) = Runs_randomized2(52,:);
new_runs_randomized2(26,:) = Runs_randomized2(7,:);
new_runs_randomized2(27,:) = Runs_randomized2(18,:);
new_runs_randomized2(28,:) = Runs_randomized2(30,:);
new_runs_randomized2(29,:) = Runs_randomized2(42,:);
new_runs_randomized2(30,:) = Runs_randomized2(53,:);
new_runs_randomized2(31,:) = Runs_randomized2(8,:);
new_runs_randomized2(32,:) = Runs_randomized2(19,:);
new_runs_randomized2(33,:) = Runs_randomized2(31,:);
new_runs_randomized2(34,:) = Runs_randomized2(43,:);
new_runs_randomized2(35,:) = Runs_randomized2(54,:);
new_runs_randomized2(36,:) = Runs_randomized2(9,:);
new_runs_randomized2(37,:) = Runs_randomized2(20,:);
new_runs_randomized2(38,:) = Runs_randomized2(32,:);
new_runs_randomized2(39,:) = Runs_randomized2(44,:);
new_runs_randomized2(40,:) = Runs_randomized2(55,:);
new_runs_randomized2(41,:) = Runs_randomized2(10,:);
new_runs_randomized2(42,:) = Runs_randomized2(21,:);
new_runs_randomized2(43,:) = Runs_randomized2(33,:);
new_runs_randomized2(44,:) = Runs_randomized2(45,:);
new_runs_randomized2(45,:) = Runs_randomized2(56,:);
new_runs_randomized2(46,:) = Runs_randomized2(11,:);
new_runs_randomized2(47,:) = Runs_randomized2(22,:);
new_runs_randomized2(48,:) = Runs_randomized2(34,:);
new_runs_randomized2(49,:) = Runs_randomized2(46,:);
new_runs_randomized2(50,:) = Runs_randomized2(57,:);
new_runs_randomized2(51,:) = Runs_randomized2(12,:);
new_runs_randomized2(52,:) = Runs_randomized2(23,:);
new_runs_randomized2(53,:) = Runs_randomized2(35,:);
new_runs_randomized2(54,:) = Runs_randomized2(47,:);
new_runs_randomized2(55,:) = Runs_randomized2(58,:);
new_runs_randomized2(56,:) = Runs_randomized2(24,:);
new_runs_randomized2(57,:) = Runs_randomized2(36,:);
new_runs_randomized2(58,:) = Runs_randomized2(59,:);
new_runs_randomized2(59,:) = Runs_randomized2(48,:);
new_runs_randomized2(60,:) = Runs_randomized2(60,:);

save('Pleasure2_randomized_run_data_final2.mat','new_runs_randomized2');  %equal trasition rates


