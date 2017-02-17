function replace_string_in_file(filename,filename_save,keyw,repl_text)

% Inlezen van de file als 1 string:
fid=fopen(filename);
fseek(fid,0,'bof');
file_str=fscanf(fid,'%c');
fclose(fid);

% aanpassen string
file_str_adj=strrep(file_str, keyw, repl_text);

% wegschrijven aangepaste string in file:
fid = fopen(filename_save,'w');
fprintf(fid,'%c',file_str_adj);
fclose(fid);