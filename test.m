function main
%  nc = 9;
%  c = 8;
%  fix_points = nc-4;
%  k = 6;  %Federkonstante
%  m = 1;  %Masse
%  g = 0.1;  #Gravitation
%  gamma = 1;  %Reibungskoeffizient
%  n = nc * c + 1;
%  verb = connections(nc,c);
%  p_0 = [0,0,4,4];
%  C = matrix(nc,c,p_0);
%  DistMat = dist_neu(n,C,p_0);



%  n = 20;
%  fixpoints = 1;
%  k = 5;  %Federkonstante
%  m = 1;  %Masse
%  g = 1;  #Gravitation
%  gamma = 0.4;  %Reibungskoeffizient
%  
%  verb = {{2}};
%  for i = 2:(n-1)
%    verb{i}{1} = i-1;
%    verb{i}{2} = i+1;
%  end
%  verb{n}{1} = n-1;
%  
%  C = [1:n; zeros(1,n); zeros(1,n); zeros(1,n)];
%  DistMat = dist_neu(n,C);

  h = 11;
  w = 8;
  n = h*w;
  fixpoints = [(n-w):n, 1:w];
  k = 5;  %Federkonstante
  m = 1;  %Masse
  g = 0.05;  #Gravitation
  gamma = 1;  %Reibungskoeffizient
  
  verb = gitter(w,h)
  
  C = [repmat(1:w,1,h); floor(((1:n) - 1)/w); zeros(1,n); zeros(1,n)]
  C(3,n/2) = 2;
  C(4,n/2) = -2;
  DistMat = dist_neu(n,C);
  
  
  

  X_initial = transpose(transpose(C)(:));
  X = X_initial;
  
  tau = 1/8;
  T = 35;
  timesteps = floor(T/tau);
  
  positions_stored = zeros(2*n,timesteps);

  for t = 1:timesteps
    
    f_temp = f(X,n,fixpoints,verb,tau,k,m,gamma,g,DistMat);
    temp_velocity = X(2*n+1:4*n) + tau/2 * f_temp;
    
    X(1:2*n) = X(1:2*n) + tau * temp_velocity;
    X(2*n+1:4*n) = X(2*n+1:4*n) + tau/2 * f(X,n,fixpoints,verb,tau,k,m,gamma,g,DistMat) +  tau/2 * f_temp;
    
    positions_stored(:,t) = X(1:2*n);
  end

  clf;
  %figHandle = figure(1);
  
  axis([-3,2*w+1,-h,2*h+1]);
  for t = 1:timesteps
    if rem(t,8) == 0
        t
      x = positions_stored(1:n,t); % die x Werte der n Punkte
      y = positions_stored(n+1:2*n,t);  % die y Werte der n Punkte

        % Zeichnet die Punkte.
      axis([-3,2*w+1,-h,2*h+1]);
      for i = 1:n
        for j = cell2mat(verb{i})
          line([x(i),x(j)],[y(i),y(j)]);
        end
      end
      drawnow;
      %MakeGif(figHandle, 'test.gif');
      clf;
    end    
  end
end

main() %führe alles aus
