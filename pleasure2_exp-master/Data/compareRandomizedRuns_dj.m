datdir = '/Users/dongjupark/Dropbox/Pleasure2_codes/pleasure2_exp-master/Data';
rorderlist = dir(datdir);
rordernames = filenames(fullfile(datdir, '*_randomized_run_data_final*.mat'));

same = [];
same = num2cell(same);


A = cell(1,4);
for r = 1:length(rordernames)
    load(rordernames{r})
    if r == 1
        R = new_runs_randomized;
        n = 0;
        m = 0;
        for i = 1:66
            for ii = 1:66
                for j = 1:5
                    if R{i,j} == R{ii, j}
                        n = n + 1;
                    end
                end
                if n == 5
                    m = m + 1;
                    A(m, 1) = {i};
                    A(m, 2) = {ii};
                else
                    n = 0;
                end
            end
        end
        
    else
        R = new_runs_randomized2;
        n = 0;
        mm = 0;
        for i = 1:60
            for ii = 1:60
                for j = 1:5
                    if R{i,j} == R{ii, j}
                        n = n + 1;
                    end
                end
                if n == 5
                    mm = mm + 1;
                    A(mm, 3) = {i};
                    A(mm, 4) = {ii};
                else
                    n = 0;
                end
            end
        end
    end
end

open A;
