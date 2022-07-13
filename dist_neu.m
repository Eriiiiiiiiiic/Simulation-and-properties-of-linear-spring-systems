function reval = dist_neu(n,M,verb)

  for i = 1 : n
    for j = 1 : length(verb{i})
      A{i}{j} =  [verb{i}{j}, norm(M(1:2,i)-M(1:2,verb{i}{j}))];
    endfor
  endfor

  reval = A;

end
