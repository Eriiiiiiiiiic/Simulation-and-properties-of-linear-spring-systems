function MakeGif(figHandle, filename)
  persistent persistentFilename = [];
  if isempty(filename)
    error('Can''t have an empty filename!');
  endif
  if ~ishandle(figHandle)
    error('Call MakeGif(figHandle, filename); no valid figHandle was passed!');
  endif
  writeMode = 'Append';
  if isempty(persistentFilename)|(filename!=persistentFilename)
    persistentFilename = filename;
    writeMode = 'Overwrite';
  endif
  imstruct = getframe(figHandle);
  imwrite(imstruct.cdata, filename, 'gif', 'WriteMode',writeMode,'DelayTime',0);
endfunction