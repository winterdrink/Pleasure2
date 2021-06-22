func_tasks{53} = {'RE','CS','CC','SS','C0'};
func_tasks{54} = {'RE','SS','CC','CS','C0'};
func_tasks{55} = {'RE','CC','CS','SS','C0'};
func_tasks{56} = {'RE','SS','C0','CS','CC'};
func_tasks{57} = {'RE','CC','C0','CS','SS'};
func_tasks{58} = {'RE','C0','CS','SS','CC'};
func_tasks{59} = {'CC','CS','RE','C0','SS'};
func_tasks{60} = {'C0','RE','CS','CC','SS'};
func_tasks{61} = {'RE','CC','CS','SS','C0'};
func_tasks{62} = {'RE','SS','CC','C0','CS'};
func_tasks{63} = {'CC','SS','C0','RE','CS'};
func_tasks{64} = {'SS','C0','RE','CC','CS'};
func_tasks{65} = {'SS','CS','RE','CC','C0'};
func_tasks{66} = {'CC','CS','RE','C0','SS'};
func_tasks{67} = {'CC','RE','CS','SS','C0'};
func_tasks{68} = {'RE','SS','CS','CC','C0'};
func_tasks{69} = {'SS','RE','CC','C0','CS'};
func_tasks{70} = {'RE','CS','CC','SS','C0'};

%%

load('Pleasure2_randomized_run_data_final_new.mat');

new_runs_randomized(53,:) = {'RE','CS','CC','SS','C0'};
new_runs_randomized(54,:) = {'RE','SS','CC','CS','C0'};
new_runs_randomized(55,:) = {'RE','CC','CS','SS','C0'};
new_runs_randomized(56,:) = {'RE','SS','C0','CS','CC'};
new_runs_randomized(57,:) = {'RE','CC','C0','CS','SS'};
new_runs_randomized(58,:) = {'RE','C0','CS','SS','CC'};
new_runs_randomized(59,:) = {'CC','CS','RE','C0','SS'};
new_runs_randomized(60,:) = {'C0','RE','CS','CC','SS'};
new_runs_randomized(61,:) = {'RE','CC','CS','SS','C0'};
new_runs_randomized(62,:) = {'RE','SS','CC','C0','CS'};
new_runs_randomized(63,:) = {'CC','SS','C0','RE','CS'};
new_runs_randomized(64,:) = {'SS','C0','RE','CC','CS'};
new_runs_randomized(65,:) = {'SS','CS','RE','CC','C0'};
new_runs_randomized(66,:) = {'CC','CS','RE','C0','SS'};

save('Pleasure2_randomized_run_data_final_new.mat','new_runs_randomized');


load('Pleasure2_randomized_run_data_final2.mat');

new_runs_randomized2(1,:) = {'CC','RE','CS','SS','C0'};
new_runs_randomized2(2,:) = {'RE','SS','CS','CC','C0'};
new_runs_randomized2(3,:) = {'SS','RE','CC','C0','CS'};
new_runs_randomized2(4,:) = {'RE','CS','CC','SS','C0'};

save('Pleasure2_randomized_run_data_final2_new.mat','new_runs_randomized2','-append');
