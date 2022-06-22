function reval = dist_neu(n,M)

  D = M(1:2,1:n);
  A = zeros(n,n);

  for i = 1 : n
    for j = 1 : n
      if i == j
        A(i,j) = 0;
      elseif i >= j
        A(i,j) = A(j,i) = norm(M(1:2,i)-M(1:2,j));
      else
        continue
      endif
    endfor
  endfor

  reval = A;

end
