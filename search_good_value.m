global mode1N mode2N mode3N v step

for mode1Now = 8
    mode1N = mode1Now;
    for mode2Now = 14
        mode2N = mode2Now;
        for mode3Now = 4
            mode3N = mode3Now;
                for vNow = 8
                    v = vNow;
                    for stepNow = 1.5
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