func_tasks{50} = {'RE','CC','CS','SS','C0'};
func_tasks{51} = {'RE','CC','CS','SS','C0'};
func_tasks{52} = {'RE','CC','CS','SS','C0'};
func_tasks{53} = {'RE','CC','CS','SS','C0'};

func_tasks{54} = {'CC','C0','CS','RE','SS'};
func_tasks{55} = {'CC','C0','CS','RE','SS'};
func_tasks{56} = {'CC','C0','CS','RE','SS'};
func_tasks{57} = {'CC','C0','CS','RE','SS'};

func_tasks{58} = {'SS','CC','RE','CS','C0'};
func_tasks{59} = {'CC','SS','RE','C0','CS'};
func_tasks{60} = {'RE','CS','CC','C0','SS'};
func_tasks{61} = {'SS','CS','CC','C0','RE'};
func_tasks{62} = {'RE','CC','SS','CS','C0'};
func_tasks{63} = {'C0','RE','CS','SS','CC'};
func_tasks{64} = {'SS','C0','RE','CC','CS'};
func_tasks{65} = {'CS','CC','RE','SS','C0'};
func_tasks{66} = {'C0','CS','RE','CC','SS'};
func_tasks{67} = {'C0','CC','SS','RE','CS'};
func_tasks{68} = {'RE','C0','SS','CC','CS'};
func_tasks{69} = {'SS','CS','CC','RE','C0'};

%%

load('Pleasure2_randomized_run_data_final.mat');

new_runs_randomized(50,:) = {'CS','SS','RE','CC','C0'};
new_runs_randomized(51,:) = {'RE','CC','CS','SS','C0'};
new_runs_randomized(52,:) = {'RE','CC','CS','SS','C0'};
new_runs_randomized(53,:) = {'RE','CC','CS','SS','C0'};
new_runs_randomized(54,:) = {'RE','CC','CS','SS','C0'};

new_runs_randomized(55,:) = {'CC','C0','CS','RE','SS'};
new_runs_randomized(56,:) = {'CC','C0','CS','RE','SS'};
new_runs_randomized(57,:) = {'CC','C0','CS','RE','SS'};
new_runs_randomized(58,:) = {'CC','C0','CS','RE','SS'};

new_runs_randomized(59,:) = {'SS','CC','RE','CS','C0'};
new_runs_randomized(60,:) = {'CC','SS','RE','C0','CS'};
new_runs_randomized(61,:) = {'RE','CS','CC','C0','SS'};
new_runs_randomized(62,:) = {'SS','CS','CC','C0','RE'};
new_runs_randomized(63,:) = {'RE','CC','SS','CS','C0'};
new_runs_randomized(64,:) = {'C0','RE','CS','SS','CC'};
new_runs_randomized(65,:) = {'SS','C0','RE','CC','CS'};
new_runs_randomized(66,:) = {'CS','CC','RE','SS','C0'};

save('Pleasure2_randomized_run_data_final_new.mat','new_runs_randomized');


load('Pleasure2_randomized_run_data_final2.mat');

new_runs_randomized2(1,:) = {'C0','CS','RE','CC','SS'};
new_runs_randomized2(2,:) = {'C0','CC','SS','RE','CS'};
new_runs_randomized2(3,:) = {'RE','C0','SS','CC','CS'};
new_runs_randomized2(4,:) = {'SS','CS','CC','RE','C0'};
new_runs_randomized2(5,:) = {'C0','RE','SS','CC','CS'};

save('Pleasure2_randomized_run_data_final2_new.mat','new_runs_randomized2');
