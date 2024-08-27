phase = [0];
sphase = num2str(phase);

E=14.6;
phase2 =[90,120,200,260,300,330]

N = length(phase2);

tic();
for i = 1:N
    disp("Ready")
    E_cav = E;
    p = phase2(i);
    
    mkdir("DEFTSOL4/same_phase",["2ps_1mm_300pC_E" num2str(E_cav,4) "MVm_10k"])
    Setup = struct("Lin_position",1.0,"Cav1_Emax",E_cav,"Cav1_PHID",0,"Cav2_Emax",E,"Cav2_PHID",p,"Cav3_Emax",E);
    
    setupfile=[char(["setup_cavity_CLEAR_phase_" num2str(p,4) ".dat"])]
    
    save('-text', setupfile, 'Setup');
     
    savepath = ["DEFTSOL4/same_phase/2ps_1mm_300pC_E" num2str(E_cav,4) "MVm_10k/beam_" num2str(p,4) "deg"]
    tablepath = ["DEFTSOL4/same_phase/2ps_1mm_300pC_E" num2str(E_cav,4) "MVm_10k/transport_table" num2str(p,4) "deg"]
    RF_lattice2(savepath,tablepath,setupfile)
    
    disp("Waiting...")

end
Total_Elapsed_Time = toc()

return

