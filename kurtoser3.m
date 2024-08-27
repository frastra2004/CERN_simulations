

myFolder = '/Users/francescostraniero/Documents/uniform_beams_fs/DEFTSOL3/kurt_evol_5deg/2ps_1mm_300pC_E14.6MVm_10k';
myfolder2='/Users/francescostraniero/Documents/uniform_beams_fs/DEFTSOL3/kurt_evol_10deg/2ps_1mm_300pC_E14.6MVm_10k';
myfolder3='/Users/francescostraniero/Documents/uniform_beams_fs/DEFTSOL3/kurt_evol_20deg/2ps_1mm_300pC_E14.6MVm_10k';
myfolder4='/Users/francescostraniero/Documents/uniform_beams_fs/DEFTSOL3/kurt_evol_300deg/2ps_1mm_300pC_E14.6MVm_10k';
myfolder5='/Users/francescostraniero/Documents/uniform_beams_fs/DEFTSOL3/kurt_evol_330deg/2ps_1mm_300pC_E14.6MVm_10k';
superstruct= {myFolder,myfolder2,myfolder3,myfolder4,myfolder5};
addpath('/Users/francescostraniero/Downloads/natsortfiles')
addpath('/Users/francescostraniero/Downloads/fit_gaussian')



%==============================================================================
n_sup = length(superstruct);
C_sup = cell(n_sup,1);
S_sup = cell(n_sup,1);
P_sup = cell(n_sup,1);
for j = 1:n_sup
    filePattern = fullfile(superstruct(j), '*.dat.gz');
    theFiles = dir(filePattern{1,1});
    theFiles = natsortfiles(theFiles);
    n = length(theFiles);
    C = cell(n,1);
    S = cell(n,1);
    P = cell(n,1);
    

    for k = 1 : n
        baseFileName = theFiles(k).name;
        fullFileName = fullfile(theFiles(k).folder, baseFileName);
        %fprintf(1, 'Now reading %s\n', fullFileName); %activate this to see output in terminal
        fullFileName = gunzip(fullFileName);
        fullFileName = string(fullFileName);
        MC = readtable(fullFileName);
        C{k} = kurtosis(MC);
        S{k} = std(MC);
        P{k} = mean(MC);


        %drawnow; % Force display to update immediately.
    end
    M = vertcat(C{:});
    C_sup{j}=M;
    %M
    %writetable(M,'kurtosis.xls')
    SM = vertcat(S{:});
    S_sup{j}=SM;
    %SM
    %writetable(SM,'std.xls')
    Pz = vertcat(P{:});
    P_sup{j}=Pz;
    %writetable(Pz,'means.xls')
    %==============================================================================
end
%% 

%x= [20,30,50,60,80,90,110,120,140,150,170,180,200,210,230,240,260,270,290,300,320,330,350,360,380,390,420,430,450,695];

s = [2,2,2,2,2,2,2,2,2,2,2];


figure();
hold on
for i = 1:n_sup
    x= [20,30,50,60,80,90,110,120,140,150,170,180,200,210,230,240,260,270,290,300,320,330,350,360,380,390,420,430,450,695];
    y = 0.5*(C_sup{i,1}{:,"Var2"} + C_sup{i,1}{:,"Var4"});
    scatter(x,y,'+')
    plot(x,y)
    %{
    x=x'; 
    f=fit(x,y,'fourier8');
    plot(f,x,y)
%}

end
xline(450,'--','RF cavity')
xlabel('position(cm)')
ylabel('Average kurtosis of momentum space (arb)')
legend('','5deg','','10deg','','20deg','','300deg','','330deg')
