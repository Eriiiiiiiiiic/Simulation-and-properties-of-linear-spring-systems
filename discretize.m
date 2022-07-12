function retval = discretize(p1,p2,d)
  n = norm(p1-p2);
  m = floor(n/d);
  dx = (p2(1,1)-p1(1,1)) / m;
  dy = (p2(2,1)-p1(2,1)) / m;
  A = [];
  for i = 1:m-1
    x = p1(1,1) + i * dx;
    y = p1(2,1) + i * dy;
    A = [A,[x;y]];
  endfor
  retval = [A];
end
