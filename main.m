function main


% COBWEB
netz = 3;
int_method = 2;
energy_plot = 0;

if netz == 1
%%{
  nc = 15;
  c = 7;

  fixpoints = [nc*c+2 - nc: nc*c+1];
  d = 0.1;
  k = 1;  %Federkonstante
  m = 1;  %Masse
  g = 0.01;  #Gravitation
  friction = 1;  %Reibungskoeffizient
  verb1 = connections(nc,c);
  p_0 = [0,0,0,0];
  C1 = matrix(nc,c,p_0);
  C2 = realistic_cobweb(d,verb1,C1){1};
  C3(1:2,:) = C2;
  P = [transpose(p_0(3:4)),zeros(2,length(C2)-1)];
  C3(3:4,:) = P;
  verb2 = realistic_cobweb(nc,c,d,verb1,C1){2};  
  verb = imp_verb(verb2);
  DistMat = dist_neu(length(C3),C3,verb);
  length(DistMat);
  n = length(C3);
  s = 1;
  C = stretch(C3,s);
%}
endif
if netz == 2


% HÄNGENDE KETTE

%{
  n = 10;
  fixpoints = [1,n];
  k = 5;  %Federkonstante
  m = 1;  %Masse
  g = 10;  #Gravitation
  friction = 0;  %Reibungskoeffizient
  verb = {{2}};
  for i = 2:(n-1)
    verb{i}{1} = i-1;
    verb{i}{2} = i+1;
  end
  verb{n}{1} = n-1;
  C = [(1/n)* 1:n; 1:n; zeros(1,n); zeros(1,n)];
  DistMat = dist_neu(n,C);
%}
endif
if netz == 3


% Gitter

%%{
  h = 4;
  w = 4;
  d = 0.1
  n = h*w;
  fixpoints = [(n-w+1):n];
  k = 20;  %Federkonstante
  m = 1;  %Masse
  g = 2;  #Gravitation
  friction = 0;  %Reibungskoeffizient
  C1 = [repmat(1:w,1,h); floor(((1:n) - 1)/w); zeros(1,n); 0.2 zeros(1,n-1)];
  C1(3,n/2) = 2;
  C1(4,n/2) = -2;
  verb1 = gitter(w,h);
  C2 = realistic_cobweb(d,verb1,C1){1};
  C3(1:2,:) = C2;
  P = zeros(2,length(C2));
  C3(3:4,:) = P;
  verb2 = realistic_cobweb(d,verb1,C1){2};  
  verb = imp_verb(verb2);
  DistMat = dist_neu(length(C3),C3,verb);
  length(DistMat);
  n = length(C3);
  s = 1;
  C = stretch(C3,s);
  
%}
endif


  gamma = 0.5;
  beta = 0.25;

  X_initial = transpose(transpose(C)(:));
  X = X_initial; % Zeilenmatrix
  tau = 1/16;
  T = 200;
  timesteps = floor(T/tau);


  positions_stored = zeros(2*n,timesteps);

  clf;

  for t = 1:timesteps
    t
    if int_method == 1
      
    %Verlet Method
    %%{
    f_temp = f(X,n,fixpoints,verb,tau,k,m,friction,g,DistMat);
    temp_velocity = X(2*n+1:4*n) + tau/2 * f_temp;
    X(1:2*n) = X(1:2*n) + tau * temp_velocity;
    X(2*n+1:4*n) = X(2*n+1:4*n) + tau/2 * f(X,n,fixpoints,verb,tau,k,m,friction,g,DistMat) +  tau/2 * f_temp;
    %}
    %initale Werte für Fixpunktiteration
    
    endif
    if int_method == 2
    %%{

    x_old = X(1,1:(2*n));
    v_old = X(1,(2*n+1):(4*n));
    a_old = 1/m * f(X,n,fixpoints,verb,tau,k,m,friction,g,DistMat);

    x_new = x_old;
    v_new = v_old;
    a_new = a_old;



    %Fixpunktiteration
    iter = 0;

    do
      v_new_temp = v_old + (1-gamma)*tau*a_old + gamma*tau*a_new;
      x_new_temp = x_old + tau* v_new + tau**2/2*((1-2*beta)*a_old + 2*beta*a_new);
      a_new_temp = 1/m * f([x_new,v_new],n,fixpoints,verb,tau,k,m,friction,g,DistMat); %X durch X_new ersetzten

      error = norm(x_new - x_new_temp);

      v_new = v_new_temp;
      x_new = x_new_temp;
      a_new = a_new_temp;


      iter += 1;
    until(iter > 50 || error < 10**(-3))

    endif

    %X aus x_new,v_new berechnen
    X = [x_new,v_new];

    %}


    positions_stored(:,t) = X(1:2*n);




    if energy_plot == 1
    %%{
    if t!=1
      energy_temp = energy;
      kin_energy_temp = kin_energy;
      spannungs_energy_temp  = spannungs_energy;
      potentielle_energy_temp = potentielle_energy;
    end
    energy = 0;
    kin_energy = 0;
    spannungs_energy = 0;
    potentielle_energy = 0;
    for i = 1:n
      kin_energy += 1/2 * m * norm([X(1,2*n+i),X(1,3*n+i)])^2; #kinetische Energie
      for j = cell2mat(verb{i})
        spannungs_energy += 1/4 * k * (norm([X(1,i)-X(1,j),X(1,n+i)-X(1,n+j)]) - DistMat(i,j))^2; #spann/potentielle Ernergie. Der Fakotr 1/4 kommt davon, dass die Federn doppelt gezählt werden.
      end
      potentielle_energy += m*g*X(1,n+i);
    end
    energy = kin_energy + spannungs_energy + potentielle_energy;
    figure(1);
    if t!=1
      plot([t/timesteps,(t+1)/timesteps],[energy_temp,energy],'r-'); hold on;
      plot([t/timesteps,(t+1)/timesteps],[kin_energy_temp,kin_energy],'bo'); hold on;
      plot([t/timesteps,(t+1)/timesteps],[spannungs_energy_temp,spannungs_energy],'g--'); hold on;
      plot([t/timesteps,(t+1)/timesteps],[potentielle_energy_temp,potentielle_energy],'px'); hold on;
      axis([0,1,0,100])
      energy; #output im Befehlsfenster
    end
    %}
    endif
  end


  figHandle = figure(1);

  figure(1);
  clf;

  axis([-1,9,-25,10]);
  %axis([-3,3*w+1,-h,3*h+1]);
  %axis([-10,10,-10,10]);
  for t = 1:timesteps
    if rem(t,4) == 0
      t
      clf;
      x = positions_stored(1:n,t); % die x Werte der n Punkte
      y = positions_stored(n+1:2*n,t);  % die y Werte der n Punkte

        % Zeichnet die Punkte.
      %axis([-10,10,-10,10]);
      %axis([-3,2*w+1,-h,2*h+1]);
      axis([-1,9,-25,10]);

      for i = 1:n
        for j = cell2mat(verb{i})
          line([x(i),x(j)],[y(i),y(j)]);
        end
      end
      drawnow;
      MakeGif(figHandle, 'test.gif');
    end
  end
end

main() %führe alles aus
