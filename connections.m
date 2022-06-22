function retval = connections(nc,c)
  n = nc * c + 1;

  for i = 1 : nc + 1
    verb{1}{i} = i;
  endfor

  for i = 2 : nc + 1
    if i == nc + 1
      verb{i}{1} = i - 1;
      verb{i}{2} = i + nc;
      verb{i}{3} = 1;
      verb{i}{4} = 2;
    elseif i == 2
      verb{i}{1} = i + nc - 1;
      verb{i}{2} = i + nc;
      verb{i}{3} = 1;
      verb{i}{4} = i + 1;
    else
      verb{i}{1} = i - 1;
      verb{i}{2} = i + nc;
      verb{i}{3} = 1;
      verb{i}{4} = i + 1;
    endif
  endfor

  for r = 2 : c - 1
    for i = (r-1) * nc + 2 : r * nc + 1
      if i == r * nc + 1
        verb{i}{1} = i - 1;
        verb{i}{2} = i + nc;
        verb{i}{3} = i - nc;
        verb{i}{4} = i - nc + 1;
      elseif i == nc * (r - 1) + 2
        verb{i}{1} = i + 1;
        verb{i}{2} = i + nc;
        verb{i}{3} = i - nc;
        verb{i}{4} = i + nc - 1;
      else
        verb{i}{1} = i - 1;
        verb{i}{2} = i + nc;
        verb{i}{3} = i - nc;
        verb{i}{4} = i + 1;
      endif
    endfor
  endfor

  for i = (c-1) * nc + 2 : c * nc + 1
    if i == c * nc + 1
      verb{i}{1} = i - 1;
      verb{i}{2} = i - nc;
      verb{i}{3} = i - nc + 1;
    elseif i == nc * (c - 1) + 2
      verb{i}{1} = i + 1;
      verb{i}{2} = i - nc;
      verb{i}{3} = i + nc - 1;
    else
      verb{i}{1} = i - 1;
      verb{i}{2} = i - nc;
      verb{i}{3} = i + 1;
    endif
  endfor

  con = verb;

  retval = con;

end
