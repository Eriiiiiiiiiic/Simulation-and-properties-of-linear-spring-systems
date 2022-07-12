function retval = imp_verb(verb)

  for i = 1 : length(verb)
    for j = 1 : length(verb{i})
      verbstr{i}{j} = num2str(verb{i}{j});
    endfor
  endfor

  for i = 1 : length(verb)
    verbstr1{i} = unique(verbstr{i});
  endfor

  for i = 1 : length(verb)
    for j = 1 : length(verbstr1{i})
      verbnr{i}{j} = str2num(verbstr1{i}{j});
    endfor
  endfor
  retval = verbnr;
end

