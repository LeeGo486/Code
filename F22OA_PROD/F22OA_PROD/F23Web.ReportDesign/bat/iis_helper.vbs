' Creates\removes IIS Virtual Folders 
if WScript.Arguments.Count<2 then 
  WScript.Echo "Wrong arguments." 
  WScript.Quit(0) 
end if 
sID = WScript.Arguments(0) 
sAction = WScript.Arguments(1) 
if sAction="Create" then 
  if WScript.Arguments.Count<3 then 
    WScript.Echo "Wrong arguments." 
    WScript.Quit(0) 
  end if 
  sName = WScript.Arguments(2) 
  sPath = WScript.Arguments(3) 
  On Error Resume Next 
  Set fso = CreateObject("Scripting.FileSystemObject") 
  sPath = fso.GetAbsolutePathName(sPath) 
  If Err.Number<>0 then 
    Err.Clear 
    WScript.Echo "Can't create '" & sName & "': invalid virtual folder path." 
    WScript.Quit(0) 
  end if 
  Set oIIS = GetObject("IIS://localhost/W3SVC/" & sID & "/Root") 
  If Err.Number<>0 then 
    Err.Clear 
    WScript.Echo "Error creating '" & sName & "' virtual folder: can't access IIS." 
    WScript.Quit(0) 
  end if 
  Set oDir = oIIS.GetObject("IISWebVirtualDir", sName) 
  ' This will return error -2147024893 if it doesn't exist 
  If Err.Number=0 then 
    WScript.Echo "Can't create '" & sName & "': virtual folder already exists." 
    WScript.Quit(0) 
  end if 
  Err.Clear 
  Set oDir = oIIS.Create("IISWebVirtualDir", sName) 
  oDir.AccessScript = True 
  oDir.Path = sPath 
  oDir.SetInfo 
  oDir.AppCreate True 
  oDir.SetInfo 
elseif sAction="Remove" then 
  sName = WScript.Arguments(2) 
  On Error Resume Next 
  Set oIIS = GetObject("IIS://localhost/W3SVC/ & sID & /Root") 
  If Err.Number<>0 then 
    Err.Clear 
    WScript.Echo "Error removing '" & sName & "' virtual folder: can't access IIS." 
    WScript.Quit(0) 
  end if 
  Set oDir = GetObject("IIS://localhost/W3SVC/ & sID & /Root/" & sName) 
  If Err.Number<>0 then 
    Err.Clear 
    WScript.Echo "Error removing '" & sName & "': virtual folder doesn't exist." 
    WScript.Quit(0) 
  else 
    Err.Clear 
    'No error so directory registration exists, we need to remove it 
    Set oIIS  = GetObject("IIS://localhost/W3SVC/ & sID & ") 
    Set oRoot = oIIS.GetObject("IIsWebVirtualDir","Root") 
    oRoot.Delete "IIsWebVirtualDir", sName 
  End if 
end if 

