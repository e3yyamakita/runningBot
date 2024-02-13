function modify_functions()
listing = dir('+SEA_model');
for i=1:length(listing)
  filename = ['+SEA_model/' listing(i).name];
  if ~contains(filename,'.m') 
    continue
  end
  if or(contains(filename,["Jc1.m","Jc2.m","pj.m","dpj.m"]), strcmp(filename,"pcom.m"))
    contents = fileread(filename);
    matches = regexp(contents,'\([\w,]+\)','match');
    newstr = ['(params,x)' newline fileread('+create_model/decomposition2.m')];
    new_contents = strrep(contents,matches{1},newstr);
    fileID = fopen(filename,'w');
    fwrite(fileID,new_contents);
    fclose(fileID);
  elseif contains(filename,"Jzmp.m")
    contents = fileread(filename);
    matches = regexp(contents,'\([\w,]+\)','match');
    newstr = ['(params,x,z)' newline fileread('+create_model/decomposition_zmp.m')];
    new_contents = strrep(contents,matches{1},newstr);
    fileID = fopen(filename,'w');
    fwrite(fileID,new_contents);
    fclose(fileID);
  elseif contains(filename,"M.m")
    contents = fileread(filename);
    matches = regexp(contents,'\([\w,]+\)','match');
    newstr = ['(params,x,p)' newline fileread('+create_model/decomposition.m')];
    new_contents = strrep(contents,matches{1},newstr);
    fileID = fopen(filename,'w');
    fwrite(fileID,new_contents);
    fclose(fileID);
  elseif contains(filename,"h.m")
    contents = fileread(filename);
    matches = regexp(contents,'\([\w,]+\)','match');
    newstr = ['(params,x,z,p)' newline fileread('+create_model/decomposition.m')];
    new_contents = strrep(contents,matches{1},newstr);
    fileID = fopen(filename,'w');
    fwrite(fileID,new_contents);
    fclose(fileID);
  elseif contains(filename,"pcom.m")
    contents = fileread(filename);
    matches = regexp(contents,'\([\w,]+\)','match');
    newstr = ['(params,x)' newline fileread('+create_model/decomposition.m')];
    new_contents = strrep(contents,matches{1},newstr);
    fileID = fopen(filename,'w');
    fwrite(fileID,new_contents);
    fclose(fileID);
  else
    contents = fileread(filename);
    matches = regexp(contents,'\([\w,]+\)','match');
    newstr = ['(params,x,z)' newline fileread('+create_model/decomposition.m')];
    new_contents = strrep(contents,matches{1},newstr);
    fileID = fopen(filename,'w');
    fwrite(fileID,new_contents);
    fclose(fileID);
  end
end