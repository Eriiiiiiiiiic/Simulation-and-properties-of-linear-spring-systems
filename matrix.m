function retval = matrix(nc,c,p_0)
  n = nc * c + 1;

  A = zeros(4, (nc * c) + 1);
  A(1:4, 1) = p_0;

  for r = 1 : c
    for k = (r-1) * nc + 2: (nc * r) + 1
      A(1,k) = A(1,1) + r * sin(((2 * pi) / nc) * k);
      A(2,k) = A(2,1) + r * cos(((2 * pi) / nc) * k);
    endfor
  endfor
  retval = A;
end
