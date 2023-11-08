global mode1N mode2N mode3N mode4N v step initialized tiptoe_upper_bound tiptoe_bound_init_guess
initialized = 1;

for mode1Now = 5
    mode1N = mode1Now;
    for mode2Now = 10
        mode2N = mode2Now;
        for mode3Now = 3
            mode3N = mode3Now;
            mode4N = 6;
                for vNow = 8
                    v = vNow;
                    for stepNow = 2
                        step = stepNow;
                        period = step/v;
                        for tiptoenow = 0.12*period
                            tiptoe_upper_bound = tiptoenow;
                            tiptoe_bound_init_guess = tiptoenow;
                            main_run_optimization;
                            if(sol_info.success)
                                disp("SUCCESS:");
                                disp([mode1N,mode2N,mode3N,v,step,tiptoe_upper_bound]);
                                break
                            end
                        end
                        
                        if(sol_info.success)
                            disp("SUCCESS:");
                            disp([mode1N,mode2N,mode3N,v,step,tiptoe_upper_bound]);
                            break
                        end
                    end
                    if(sol_info.success)
                        disp("SUCCESS:");
                        disp([mode1N,mode2N,mode3N,v,step,tiptoe_upper_bound]);
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