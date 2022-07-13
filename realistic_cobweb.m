function retval = realistic_cobweb(d,verb,C)
  n = length(verb);
  N = C(1:2,:);
  for i = 1 : n
    for j = 1 : length(verb{i})

      for l = 1 : length(verb{verb{i}{j}})

        if verb{verb{i}{j}}{l} == i
          verb{verb{i}{j}}{l} = verb{i}{j};
        else
          continue
        endif

      endfor

      if verb{i}{j} == i
        continue
      else
        A = discretize(N(:,i),N(:,verb{i}{j}),d);
        verb{length(N)+length(A)}{2} = verb{i}{j};
        verb{i}{j} = length(N) + 1;
        verb{length(N)+1}{1} = i;
        verb{length(N)+1}{2} = length(N)+ 2;
        verb{length(N)+length(A)}{1} = length(N) + length(A) - 1;

        for k = 2 : length(A) - 1
          verb{length(N)+k}{1} = length(N)+ k - 1;
          verb{length(N)+k}{2} = length(N)+ k + 1;
        endfor

      endif

      N = [N,A];
    endfor

  endfor

  for i = 1 : length(verb)
    for j = 1 : length(verb{i})
      if verb{i}{j} != i
        verb{verb{i}{j}}{length(verb{verb{i}{j}})+1} = i;
      else
        continue
      endif
    endfor
  endfor

  retval = {N,verb};
end
