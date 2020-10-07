%% Directory

datdir = '/Users/dongjupark/Dropbox/Pleasure2_codes/pleasure2_exp-master/Data';
rorderlist = dir(datdir);
rordernames = filenames(fullfile(datdir, '*_randomized_run_data*.mat'));


%% Finding overlapping orders

% data.mat & data2.mat : r = 1:2, if r == 1, Runs_randomized
% data_v1.mat & data_v2.mat : r = 5:6, if r == 5, Runs_randomized
% data_final.mat & data_final.mat : r = 3:4, if r == 3,
% new_runs_randomized, 66


A = cell(1,4);
for r = 3:4
    load(rordernames{r})
    if r == 3
        m = 0;
        for i = 1:66
            for ii = 1:66
                n = 0;
                for j = 1:5
                    if isequal(new_runs_randomized{i,j}, new_runs_randomized{ii, j})
                        n = n + 1;
                    end
                end
                if n == 5

                    if ~isequal(i,ii)
                    m = m + 1;
                    A(m, r) = {i};
                    A(m, r+1) = {ii};
                    end
                else
                    n = 0;
                end
            end
        end
        
    else
        mm = 0;
        for i = 1:60
            for ii = 1:60     
                n = 0;
                for j = 1:5
                    if isequal(new_runs_randomized2{i,j},new_runs_randomized2{ii, j})
                        n = n + 1;
                    end
                end
                if n == 5
                    if ~isequal(i, ii)
                    mm = mm + 1;
                    A(mm, r+1) = {i};
                    A(mm, r+2) = {ii};
                    end
                else
                    n = 0;
                end
            end
        end
    end
end

open A;




%% Correct data.mat & data2.mat

% data.mat & data2.mat : r = 1:2, if r == 1, Runs_randomized
% data_v1.mat & data_v2.mat : r = 5:6, if r == 5, Runs_randomized


B = cell(1,4);
e = 0;
ee = 0;
for r = 1:2
    if r == 1
        load(rordernames{r});
        noversion = Runs_randomized;
        load(rordernames{r+4});
        version = Runs_randomized;
        for i = 1:60
            t = 0;
            for ii = 1:60
                n = 0;
                for j = 1:5
                    if isequal(noversion{i,j}, version{ii, j})
                        n = n + 1;
                    end
                end
                if n == 5
                    t = t + 1;
                end   
            end
            if t == 0
                e = e+1;
                B(e, 1) = {i};
                B(e, 2) = {ii};
            end
        end
   
    
    else
        load(rordernames{r});
        noversion = Runs_randomized2;
        load(rordernames{r+4});
        version = Runs_randomized2;
        for i = 1:60
            tt = 0;
            for ii = 1:60
                n = 0;
                for j = 1:5
                    if isequal(noversion{i,j},version{ii, j})
                        n = n + 1;
                    end
                end
                if n == 5
                    tt = tt + 1;
                end
            end
            if tt == 0
                ee = ee + 1;
                B(ee, 3) = {i};
                B(ee, 4) = {ii};
            end
        end
    end
end

open B;


%% Counts each pairs

Runs = {'RE', 'CC', 'SS', 'C0', 'CS'};
N = cell(1,3);
nn = 0;
pp = 0;


i = 1;
for j = 1:5
    N{i+4*(j-1),1} = Runs{j};
    N{i+4*(j-1)+1,1} = Runs{j};
    N{i+4*(j-1)+2,1} = Runs{j};
    N{i+4*(j-1)+3,1} = Runs{j};
    if j == 1
        N{i+4*(j-1),2} = Runs{2};
        N{i+4*(j-1)+1,2} = Runs{3};
        N{i+4*(j-1)+2,2} = Runs{4};
        N{i+4*(j-1)+3,2} = Runs{5};
    elseif j == 2
        N{i+4*(j-1),2} = Runs{1};
        N{i+4*(j-1)+1,2} = Runs{3};
        N{i+4*(j-1)+2,2} = Runs{4};
        N{i+4*(j-1)+3,2} = Runs{5};
    elseif j == 3
        N{i+4*(j-1),2} = Runs{1};
        N{i+4*(j-1)+1,2} = Runs{2};
        N{i+4*(j-1)+2,2} = Runs{4};
        N{i+4*(j-1)+3,2} = Runs{5};
    elseif j == 4
        N{i+4*(j-1),2} = Runs{1};
        N{i+4*(j-1)+1,2} = Runs{2};
        N{i+4*(j-1)+2,2} = Runs{3};
        N{i+4*(j-1)+3,2} = Runs{5};
    else
        N{i+4*(j-1),2} = Runs{1};
        N{i+4*(j-1)+1,2} = Runs{2};
        N{i+4*(j-1)+2,2} = Runs{3};
        N{i+4*(j-1)+3,2} = Runs{4};
        
    end
end

open N

     
      

    n = 0;

for a = 1:5
    for s = 1:4
        n = 0;
        for r = 3:4
            load(rordernames{r})
            if r == 3
                for j = 1:4
                    for i = 1:66
                        if isequal(new_runs_randomized{i,j}, N{(4*a)-3,1})
                            if isequal(new_runs_randomized{i,j+1}, N{4*(a-1)+s, 2})
                                n = n+1;
                            end
                        end
                    end
                end
            else
                for j = 1:4
                    for i = 1:60
                        if isequal(new_runs_randomized2{i,j}, N{(4*a)-3,1})
                            if isequal(new_runs_randomized2{i,j+1}, N{4*(a-1)+s, 2})
                                n = n+1;
                            end
                        end
                    end
                end
            end
        end
        N{4*(a-1)+s, 3} = n;
    end
end


open N     %  # of pairs




% # of each pairs = 18

% N = double(4);
% 
% for i = 1:120
%    for j = 1:3
%     if M(i,j) == 2
%         if M(i, j+1) == 3
%             n = n+1;
%             N(n, 1) = M(i, j);
%             N(n, 2) = M(i, j+1);
%         end
%     end
%    end
% end
% 
            
            
        
                