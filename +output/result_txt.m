function result_txt(result,filename)
global b_init
file_name = ['+results/' filename '.mat'];
diary(file_name)

output.print_param(result);

result.flags

fprintf("beta init %f\n",b_init)

disp("memo:none")

diary off