global mode1N mode2N mode3N v step initialized
initialized = 1;

for mode1Now = 8
    mode1N = mode1Now;
    for mode2Now = 12
        mode2N = mode2Now;
        for mode3Now = 3
            mode3N = mode3Now;
                for vNow = 2.1
                    v = vNow;
                    for stepNow = 0.65
                        step = stepNow;
                        main_run_optimization;
                        if(sol_info.success)
                            disp("SUCCESS:");
                            disp([mode1N,mode2N,mode3N,v,step]);
                            break
                        end
                    end
                    if(sol_info.success)
                        disp("SUCCESS:");
                        disp([mode1N,mode2N,mode3N]);
                        break
                    end
                end
                if(sol_info.success)
                    break
                end
        end
        if(sol_info.success)
            break
        end
    end
    if(sol_info.success)
        break
    end    
end