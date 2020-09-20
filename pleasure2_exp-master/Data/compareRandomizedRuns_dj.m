datdir = '/Users/dongjupark/Dropbox/Pleasure2_codes/pleasure2_exp-master/Data';
rorderlist = dir(datdir);
rordernames = filenames(fullfile(datdir, '*_randomized_run_data*.mat'));

for r = 1:length(rordernames)
    load(rordernames{r})
    if r==1||5
        R = Runs_randomized;
        same = [];
        same = num2cell(same);
        n = 0;
        m = 0;
        for i = 1:60
            for ii = 1:60
            for j = 1:5
                if isequal(R{i,j}, R{ii, j})==1
                    n = n + 1;
                end
            end
            end
            if n == 5
                m = m + 1;
                same(r,m) = i;
                same(r,m*2) = ii;
            else n = 0;
            end
        end
        
    elseif r == 2||6
        R = Runs_randomized2;
        n = 0;
        m = 0;
        for i = 1:60     
            for ii = 1:60
            for j = 1:5
                if isequal(R{i,j}, R{ii, j})==1
                    n = n + 1;
                end
            end
            end
            if n == 5
                m = m + 1;
                same(r,m) = i;
                same(r,m*2) = ii;
            else n = 0;
            end
        end
 
    elseif r == 3
        R = new_runs_randomized;
        n = 0;
        m = 0;
        for i = 1:60
            for ii = 1:60
                for j = 1:5
                    if isequal(R{i,j}, R{ii, j})==1
                        n = n + 1;
                    end
                end
            end
            if n == 5
                m = m + 1;
                same(r,m) = i;
                same(r,m*2) = ii;
            else n = 0;
            end
        end
        
    else
        R = new_runs_randomized2;
        n = 0;
        m = 0;
        for i = 1:60
            for ii = 1:60
                for j = 1:5
                    if isequal(R{i,j}, R{ii, j})==1
                        n = n + 1;
                    end
                end
            end
            if n == 5
                m = m + 1;
                same(r,m) = i;
                same(r,m*2) = ii;
            else n = 0;
            end
        end
    end
end
