function pb(result)
% plot xb,yb
clean = false;
separate = 1; %1 for yes 0 for no

if ~clean
    figure;
    if separate == 1
        sgtitle('Forefoot running body base position');
    else
        sgtitle('Forefoot running body base position and velocity');
    end
    subplot(3,2-separate,1); plot(result.time, result.xb);
    title('$x_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[m]'); result.separate_background_with_section('state');

    subplot(3,2-separate,3-separate); plot(result.time, result.yb);
    title('$y_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[m]'); result.separate_background_with_section('state');

    subplot(3,2-separate,5-2*separate); plot(result.time, result.thb);
    title('$\theta_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[rad]'); result.separate_background_with_section('state');

    if separate == 1
        figure;
        sgtitle('Forefoot running body base velocity');
    end
    subplot(3,2-separate,(2-separate)); plot(result.time, result.dxb);
    title('$\dot{x}_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('velocity[m/s]'); result.separate_background_with_section('state');

    subplot(3,2-separate,(2-separate)*2); plot(result.time, result.dyb); 
    title('$\dot{y}_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('velocity[m/s]'); result.separate_background_with_section('state');

    subplot(3,2-separate,(2-separate)*3); plot(result.time, result.dthb);
    title('$\dot{\theta}_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[rad/s]'); result.separate_background_with_section('state');

else
    figure;
    if separate == 1
        sgtitle('Forefoot running body base position');
    else
        sgtitle('Forefoot running body base position and velocity');
    end
    subplot(3,2-separate,1); %plot(result.time, result.xb);
    cleaned = +utils.clean_data_diff(result.xb,result.time(1:end),0);
    plot(cleaned(1,:),cleaned(2,:));
    title('$x_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[m]'); result.separate_background_with_section('state');  

    subplot(3,2-separate,3-separate); %plot(result.time, result.yb);
    cleaned = +utils.clean_data_diff(result.yb,result.time(1:end),0);
    plot(cleaned(1,:),cleaned(2,:));
    title('$y_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[m]'); result.separate_background_with_section('state');

    subplot(3,2-separate,5-2*separate); %plot(result.time, result.thb);
    cleaned = +utils.clean_data_diff(result.thb,result.time(1:end),0);
    plot(cleaned(1,:),cleaned(2,:));
    title('$\theta_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[rad]'); result.separate_background_with_section('state');

    if separate == 1
        figure;
        sgtitle('Forefoot running body base velocity');
    end
    subplot(3,2-separate,2-separate); %plot(result.time, result.dxb);
    cleaned = +utils.clean_data_threshold(result.time(2:end),diff(result.xb)./diff(result.time),1);
    plot(cleaned(1,:),cleaned(2,:));
    title('$\dot{x}_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('velocity[m/s]'); result.separate_background_with_section('state');

    subplot(3,2-separate,(2-separate)*2); %plot(result.time, result.dyb);
    cleaned = +utils.clean_data_diff(result.dyb,result.time(1:end),0);
    plot(cleaned(1,:),cleaned(2,:));
    title('$\dot{y}_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('velocity[m/s]'); result.separate_background_with_section('state');

    subplot(3,2-separate,(2-separate)*3); plot(result.time, result.dthb);
    cleaned = +utils.clean_data_diff(result.dthb,result.time(1:end),0);
    plot(cleaned(1,:),cleaned(2,:));
    title('$\dot{\theta}_b$','Interpreter','latex'); xlabel('time[s]'); ylabel('position[rad/s]'); result.separate_background_with_section('state');

end
end

