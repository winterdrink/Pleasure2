datdir = '/Users/dongjupark/Dropbox/Pleasure2_codes/pleasure2_exp-master';
rorderlist = dir(datdir);
rordernames = {rorderlist.name}';
rordernames = filenames(fullfile(datdir, '*_randomized_run_data*.mat'));
rorderopen = (cellstr(["Runs_randomized" "Runs_randomized2" "new_runs_randomized2"]));

for r = 1:length(rordernames)
    load(rordernames{r})
    if isequal(r, or(1,4))
        R = Runs_randomized;
    elseif isequal(r, or(2,5))
        R = Runs_randomized2;
    else
        R = new_runs_randomized2;
    for i = 1:59
        iswhile = 0;
        while iswhile == 0
            for j = 1:5
                if isequal(R{i,j}, R{i+1, j})==0
                    iswhile = 1;
                end
            end
            same = [];
            n = 0;
            n = n+1;
            same(n) = i;
        end
    end

    end
end

        