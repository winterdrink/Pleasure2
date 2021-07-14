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

func_tasks{71} = {'CC','CS','RE','SS','C0'};
func_tasks{72} = {'CC','RE','CS','C0','SS'};
func_tasks{73} = {'SS','RE','CC','CS','C0'};
func_tasks{74} = {'C0','RE','SS','CS','CC'};
func_tasks{75} = {'C0','CS','RE','SS','CC'};
func_tasks{76} = {'RE','C0','CS','SS','CC'};
func_tasks{77} = {'SS','C0','CC','RE','CS'};
func_tasks{78} = {'CC','SS','CS','C0','RE'};
func_tasks{79} = {'C0','RE','CC','SS','CS'};
func_tasks{80} = {'SS','RE','CS','CC','C0'};

func_tasks{81} = {'SS','RE','C0','CS','CC'};
func_tasks{82} = {'CC','CS','RE','C0','SS'};
func_tasks{83} = {'CC','RE','CS','SS','C0'};
func_tasks{84} = {'SS','RE','CC','CS','C0'};
func_tasks{85} = {'C0','CS','SS','CC','RE'};
func_tasks{86} = {'CC','C0','RE','SS','CS'};
func_tasks{87} = {'C0','CC','SS','CS','RE'};
func_tasks{88} = {'C0','RE','SS','CC','CS'};
func_tasks{89} = {'C0','CS','RE','CC','SS'};
func_tasks{90} = {'CS','CC','RE','C0','SS'};

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


load('Pleasure2_randomized_run_data_final2_new.mat');

new_runs_randomized2(1,:) = {'CC','RE','CS','SS','C0'};
new_runs_randomized2(2,:) = {'RE','SS','CS','CC','C0'};
new_runs_randomized2(3,:) = {'SS','RE','CC','C0','CS'};
new_runs_randomized2(4,:) = {'RE','CS','CC','SS','C0'};

new_runs_randomized2(5,:) = {'CC','CS','RE','SS','C0'};
new_runs_randomized2(6,:) = {'CC','RE','CS','C0','SS'};
new_runs_randomized2(7,:) = {'SS','RE','CC','CS','C0'};
new_runs_randomized2(8,:) = {'C0','RE','SS','CS','CC'};
new_runs_randomized2(9,:) = {'C0','CS','RE','SS','CC'};
new_runs_randomized2(10,:) = {'RE','C0','CS','SS','CC'};
new_runs_randomized2(11,:) = {'SS','C0','CC','RE','CS'};
new_runs_randomized2(12,:) = {'CC','SS','CS','C0','RE'};
new_runs_randomized2(13,:) = {'C0','RE','CC','SS','CS'};
new_runs_randomized2(14,:) = {'SS','RE','CS','CC','C0'};

new_runs_randomized2(15,:) = {'SS','RE','C0','CS','CC'};
new_runs_randomized2(16,:) = {'CC','CS','RE','C0','SS'};
new_runs_randomized2(17,:) = {'CC','RE','CS','SS','C0'};
new_runs_randomized2(18,:) = {'SS','RE','CC','CS','C0'};
new_runs_randomized2(19,:) = {'C0','CS','SS','CC','RE'};
new_runs_randomized2(20,:) = {'CC','C0','RE','SS','CS'};
new_runs_randomized2(21,:) = {'C0','CC','SS','CS','RE'};
new_runs_randomized2(22,:) = {'C0','RE','SS','CC','CS'};
new_runs_randomized2(23,:) = {'C0','CS','RE','CC','SS'};
new_runs_randomized2(24,:) = {'CS','CC','RE','C0','SS'};

save('Pleasure2_randomized_run_data_final2_new.mat','new_runs_randomized2','-append');
