global mode1N mode2N mode3N v step initialized tiptoe_upper_bound tiptoe_bound_init_guess
initialized = 1;
tiptoe_bound_init_guess = 1e-2;
for mode1Now = 8
    mode1N = mode1Now;
    for mode2Now = 10
        mode2N = mode2Now;
        for mode3Now = 3
            mode3N = mode3Now;
                for vNow = 8
                    v = vNow;
                    for stepNow = 2
                        step = stepNow;
                        for tiptoenow = 1e-1
                            tiptoe_upper_bound = tiptoenow;
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