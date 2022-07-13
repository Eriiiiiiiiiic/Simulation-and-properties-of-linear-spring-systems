function retval = stretch(M,s)
  for i = 1 : length(M)
    M(:,i) = s * M(:,i);
  endfor
  retval = M;
end
