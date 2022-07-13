function change1 = f(p,n,fixpoints,verb,tau,k,m,friction,g,DistMat)
  
  x = p(1:n); %die ersten n einträge sind die x Werte
  y = p(n+1:2*n); %die n nächsten einträge sind die y Werte
  pos = [x;y];
  vx = p(2*n+1:3*n); %die n nächsten einträge sind die velocity - x Werte
  vy = p(3*n+1:4*n); %die n nächsten einträge sind die velocity - y Werte

  change1 = zeros(1,2*n); %die Werte von x,y,vx,vy werden um tau*ableitung verändert. change ist hier die Ableitung

  for i = 1:n
    if(!any(fixpoints == i))
      for l = 1 : length(verb{i}) 
        j = DistMat{i}{l}(1);% alle Verbindungen zu i
        d = DistMat{i}{l}(2);
        if norm(pos(:,j)-pos(:,i)) > 0.01
          change1(i) += k * (norm(pos(:,j)-pos(:,i)) - d) * (x(j)-x(i))/norm(pos(:,j)-pos(:,i));  %vx_i abgeleitet = x_i'' = proportional zur streckung "norm(pos(:,l)-pos(:,i)) - d"
          change1(n+i) += k * (norm(pos(:,j)-pos(:,i)) - d) * (y(j)-y(i))/norm(pos(:,j)-pos(:,i));
        end
      end
        change1(i) -= friction * vx(i) * tau;
        change1(n+i) -= friction * vy(i) * tau + g * tau;
    end
  end
end
