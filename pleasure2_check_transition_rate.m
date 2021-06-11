%% select the index of subjs & set the directories

subj_idx = 1:53;
subj_idx(12) = [];  % not intact data

behav_dir = '/Volumes/alita/dropbox/data/Pleasure2/behavioral';

%% load behav data & stack run orders

func_tasks = [];
for i = 1:length(subj_idx) 
    sub_beh_dir = fullfile(behav_dir,sprintf('sub-pleasureT%.3d',subj_idx(i)));
    run_files_list = filenames(fullfile(sub_beh_dir, '*run*'));
    
    for ii = 1:numel(run_files_list)
        load(run_files_list{ii});
        func_tasks{i}{ii} = char(data.dat.type);   % Randomized run order
    end
end

%%
runs = {'CC','SS','RE','CS','C0'};
numlist = nchoosek(1:5,2);
transition_list = [];
for j = 1:size(numlist,1)
    transition_list{j,1} = runs(numlist(j,:));
    transition_list{j,2} = runs(fliplr(numlist(j,:)));
end
transition = zeros(10,2);
for i = 1:numel(func_tasks)
    for j = 1:size(numlist,1)
        if diff(find(ismember(func_tasks{i},runs(numlist(j,:)))))==1
            if isequal(func_tasks{i}(ismember(func_tasks{i},runs(numlist(j,:)))),transition_list{j,1})
                transition(j,1) = transition(j,1)+1;
            elseif isequal(func_tasks{i}(ismember(func_tasks{i},runs(numlist(j,:)))),transition_list{j,2})
                transition(j,2) = transition(j,2)+1;
            end            
        end
    end
end
disp(transition)

%% new run orders (sub050~) to balance the transition rate

% func_tasks{49} = {'CS','SS','RE','CC','C0'};  % sub050
% func_tasks{50} = {'RE','CC','CS','SS','C0'};
% func_tasks{51} = {'RE','CC','CS','SS','C0'};
% func_tasks{52} = {'RE','CC','CS','SS','C0'};

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



% func_tasks{70} = {'C0','RE','SS','CC','CS'};

