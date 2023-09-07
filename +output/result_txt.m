function result_txt(result,filename)
global b_init
file_name = ['+search_local_solution/+result/' filename '.txt'];
diary(file_name)

output.print_param(result);

result.flags

fprintf("beta init %f\n",b_init)

disp("memo:none")

diary off