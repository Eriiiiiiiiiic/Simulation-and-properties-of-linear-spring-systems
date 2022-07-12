function retval = stretch(M,nc,c,s)
  n = nc*c + 1;
  for i = 1 : length(M)
    M(:,i) = s * M(:,i);
  endfor
  retval = M;
end
