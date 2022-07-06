function verb = gitter(w,h)
  
  verb = {{2,w+1}};
  for i = 2:(w-1)
    verb{i}{1} = i-1;
    verb{i}{2} = i+1;
    verb{i}{3} = i+w;
  end
  verb{w}{1} = w-1;
  verb{w}{2} = 2*w;
  
  for row = 1:(h-2)
    start = w * row + 1;
    verb{start}{1} = start - w;
    verb{start}{2} = start + w ;
    verb{start}{3} = start + 1;
    for i = 1:(w-2)
      verb{start + i}{1} = start + i-1;
      verb{start + i}{2} = start + i+1;
      verb{start + i}{3} = start + i+w;
      verb{start + i}{4} = start + i-w;
    end
    verb{start + w -1}{1} = start + w -1 - w ;
    verb{start + w -1}{2} = start + w -1 + w ;
    verb{start + w -1}{3} = start + w -1 - 1 ;
  end
  
  verb{w*h - w +1}{1} = w*h - w + 1 + 1;
  verb{w*h - w +1}{2} = w*h - w + 1 - w;

  verb{w*h - w +2}{1} = w*h - w +2 + 1;
  verb{w*h - w +2}{2} = w*h - w +2 - w;
  
  
  for i = 3:w
    verb{w*h - w + i}{1} = w*h - w + i - 1;
    verb{w*h - w + i}{2} = w*h - w + i + 1;
    verb{w*h - w + i}{3} = w*h - w + i - w;
  end
  verb{w*h}{1} = w*h-1;
  verb{w*h}{2} = w*h-w;
  
end
