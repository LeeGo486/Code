<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Class Table
  'Private Const AI =20
  Private AI ''����,�ֶ����鳤��
  Private arr(40,4) 'As Variant
  Private ac 'As Integer ''�ֶ�����������
  
  'Private Const PI =10
  Private PI ''����,�������鳤��
  Private param(10,3) 'as variant ''�洢���̲�������
  Private pc 'as integer

  Private i ' As Integer
  
  Private ctype ''��������
  Private ctext 'As String ''����
  
  Private cn 'As ADODB.Connection ''����
  
  Private CSure 'As String ''����ֶ���
  Private Sure 'As String ''�����ֶ���
  Private PkIndex 'As Integer ''����λ��
  Private IsAColor 'as integer ''�Ƿ������˵���״̬��ʾ�е���ɫ
  Private Color 'as String ''��ɫ
  Private CField 'As Integer ''���ݸ��ֶ���ʾ��ɫ
  
  Private Dwidth,Dheight 'As String '����͸�,��ʵ��<DIV>�Ŀ�͸�
  
  Private Sub Class_Initialize()
    AI=40
	PI=10
    ac=0
	pc=0
	i=0
	ctype=8
	ctext=""
	Csure="Setchk_Sure"
	Sure="Set_Sure"
	PkIndex=0
	Dwidth="100%"
	Dheight="100%"
	IsAColor=0
  End Sub
  
  Public Property Let CommandType(Value)
    if not isNumeric(Value) then Err.Raise 50001,"Class.Table","CommandType��ֵֻ��������!"
    ctype=Value
  End Property
  
  Public Property Let CommandText(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class.Table","CommandText��ֵ����Ϊ��!"
    ctext=Value
  End Property
  
  Public Property Let ActiveConnection(Value)
    if Value=null then Err.Raise 50001,"Class.Table","Connection�����ֵ����ΪNULL!"
    cn=Value
  End Property
  
  Public Property Let CSureName(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class.Table","����ֶ�������Ϊ��!"
    CSure=Value
  End Property
  
  Public Property Let SureName(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class.Table","�����ֶ�������Ϊ��!"
    Sure=Value
  End Property
  
  Public Property Let Width(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Value="100%"
	Dwidth=Value
  End Property
  
  Public Property Let Height(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Value="94%"
	Dheight=Value
  End Property
  
  Public Property let IsAutoColor(Value)
    IsAColor=Value
  End Property
  
  Public Property let ColorField(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class","��ɫ�ֶ����ô���!"
    CField=Value
  End Property
  
  Public Sub SetField(FieldName,DisplayName,Length,tj) ''�����ֶ�����
    if ac>AI then Err.Raise 50001,"Class","�ֶ���������Խ��,���ܳ���"&AI&"���ַ�!"
    arr(ac,0)=FieldName
	arr(ac,1)=DisplayName
	arr(ac,2)=Length
	arr(ac,3)=tj
	arr(ac,4)=0
	ac=ac+1
  End Sub
  
  Public Sub SetParam(pname,ptype,plength,pvalue)
    if pc>PI then Err.Raise 50001,"Class","�洢���̲�����������Խ��,���ܳ���"&PI&"���ַ�!"
    Param(pc,0)=pname
    Param(pc,1)=ptype
    Param(pc,2)=plength
    Param(pc,3)=pvalue
	pc=pc+1
  End Sub

  Public Function GetDs() 'As ADODB.Recordset ''������¼��
    Dim ds 'As ADODB.Recordset
	Dim cd 'As ADODB.Command
	Dim rq1,rq2 'As string
	Dim fso,fd,fn,path
	Dim Cntmp
	
	'Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	'Set Fd=Fso.GetFolder()
	set Cntmp=server.createobject("ADODB.Connection")
    Cntmp.open session("cn")
	Set cd=Server.CreateObject("ADODB.Command")
	cd.ActiveConnection = Cntmp
	cd.CommandType=ctype
	cd.CommandText=ctext
	cd.commandtimeout=999
	
	if ctype=4 then'���岢����������
      For i = 0 To pc-1 '�������������������͡��������͡����ݳ��ȡ�����ֵ
        cd.Parameters.Append cd.CreateParameter(Param(i, 0), Param(i, 1), adParamInput, Param(i, 2), Param(i, 3))
        'response.Write(Param(i, 0)&" , "& Param(i, 1)&" , "& "adParamInput" &" , "& Param(i, 2)&" , "& Param(i, 3)&"<br>")
      Next
	  'response.end
	end if
	'de ctext
	set ds=cd.Execute
	set GetDs=ds
	Set ds=Nothing
	Set cd=Nothing
	Set Cntmp=Nothing
  End Function


  Public Sub Show() ''��ʾ��¼��
    Dim FieldName 'As String
	Dim DisplayName 'As String
	Dim Length 'As String
	Dim ds 'As ADODB.Recordset
	Dim tmp 'As String
	Dim row 'As integer
	Dim cf 'As String
	Dim v 'As String
    Response.Write "<div id=""gt1"" style=""width:"&Dwidth&";height:"&Dheight&";"" border=0>"
    Response.Write "<table>"
	Response.Write "<thead><tr>"
    for i=0 to ac-1
      FieldName=arr(i,0)
      DisplayName=arr(i,1)
      Length=arr(i,2)
      Response.Write "<th width="""&Length&""">"&DisplayName&"</th>"
	next
    Response.Write "</tr></thead>"
    set ds=GetDs() ''ȡ�ü�¼��
	row=0
    while not ds.eof
	  row=row+1
      Response.Write "<tr id="""&row&""" style=""background:#F00""><td style=""background:#F00"">"
	  tmp=0 '�����һ�ε�tmp
	  select case IsAcolor '�Ƿ��Զ�������ɫ
	  case 0 '�Զ�����
	    if ds.Fields.Item(Csure).value=1 then tmp="1" '�˴��ɵ������ȼ�,Ҳ��ͬʱ����ʱ,���ĸ�Ϊ׼
        if ds.Fields.Item(sure).value=1 then tmp="2"
	  case 1 '��������ɫ
	    '
	  case 3
	    cf=ds.Fields.Item(CField).value ''�������ʱ
	    if isnull(cf) or cf="" then ''һ�ζ�û����
				tmp="2"
			else ''�������һ��
				tmp="1"
			end if
	  end select
      Response.Write "<input type=""hidden"" name=""csd"" value="""&tmp&""">"
      Response.Write Trim(ds.Fields.Item(arr(0,0)).value)
	  Response.Write "</td>"
      For i=1 to ac-1
        FieldName=arr(i,0)
		v=ds.Fields.Item(FieldName).value
		select case arr(i,3)
		case 0'ͳ�Ƹ���
		  arr(i,4)=arr(i,4)+1
		case 1'ͳ�������
		  'arr(i,4)=arr(i,4)+clng(v)
		  arr(i,4)=arr(i,4)+formatnumber(v,2)
		case 2
		  arr(i,4)="&nbsp;"
		case 3'��ʾ�ϼ�
		  arr(i,4)="�ϼ�"
		case 4'��ʾΪ��
		  arr(i,4)="&nbsp;"
		end select
		Response.Write "<td>"
		if instr(FieldName,"id")>0 then response.write "&nbsp;"	'���ǰ��һ���ո�
		on error resume next '���ڵ���*************************************
		Response.Write Trim(ds.Fields.Item(FieldName).value)
		if err.number<>0 then '���ڵ���
		  de "û�� "&FieldName&" , "&arr(i,1)&" ����ֶ�!"
		  response.end
		end if
		Response.Write "</td>"
	  next
      Response.Write "</tr>"
	  ds.movenext
	wend
	  Response.Write "<tr id="""&row+1&""">"
	  for i=0 to ac-1
	  response.Write "<td>"
	  if i=0 then
	     response.Write("�ϼ�")
	  else
	     response.Write arr(i,4)
	  end if
	  Response.Write "<input type=""hidden"" name=""csd"" value=""0"">"
	  response.Write "</td>"
	  next
    Response.Write "</table>"
	Response.Write "</div>"
	ds.close
    set ds=nothing
	
	Response.Write("<script language=""javascript"">")
    Response.Write("try{")
	Response.Write(" gt = new GtTable(""gt1"");")
	Response.Write(" gtTables.addTable(gt);")
	Response.Write(" gt.loadTable();")
	Response.Write("}catch(ex){}")
	Response.Write("</script>")
	
  End Sub
  
    Public Sub ShowRS(RS) ''��ʾ��¼��
    Dim FieldName 'As String
	Dim DisplayName 'As String
	Dim Length 'As String
	Dim ds 'As ADODB.Recordset
	Dim tmp 'As String
	Dim row 'As integer
	Dim cf 'As String
	Dim v ' As String
    Response.Write "<div id=""gt1"" style=""width:"&Dwidth&";height:"&Dheight&";"" border=0>"
    Response.Write "<table>"
	Response.Write "<thead><tr>"
    for i=0 to ac-1
      FieldName=arr(i,0)
      DisplayName=arr(i,1)
      Length=arr(i,2)
      Response.Write "<th width="""&Length&""">"&DisplayName&"</th>"
	next
    Response.Write "</tr></thead>"
    set ds=RS ''ȡ�ü�¼��
	row=0
    while not ds.eof
	  row=row+1
      Response.Write "<tr id="""&row&"""><td>"
	  tmp=0 '�����һ�ε�tmp
	  select case IsAcolor '�Ƿ��Զ�������ɫ
	  case 0 '�Զ�����
	    if ds.Fields.Item(Csure).value=1 then tmp="1" '�˴��ɵ������ȼ�,Ҳ��ͬʱ����ʱ,���ĸ�Ϊ׼
        if ds.Fields.Item(sure).value=1 then tmp="2"
	  case 1 '��������ɫ
	    '
	  case 3
	    cf=ds.Fields.Item(CField).value ''�������ʱ
	    if isnull(cf) or cf="" then ''һ�ζ�û����
		  tmp="2"
		else ''�������һ��
		  tmp="1"
		end if
	  end select
      Response.Write "<input type=""hidden"" name=""csd"" value="""&tmp&""">"
      Response.Write Trim(ds.Fields.Item(arr(0,0)).value)
	  Response.Write "</td>"
      For i=1 to ac-1
        FieldName=arr(i,0)
		v=ds.Fields.Item(FieldName).value
		select case arr(i,3)
		case 0'ͳ�Ƹ���
		  arr(i,4)=arr(i,4)+1
		case 1'ͳ�������
		  'arr(i,4)=arr(i,4)+clng(v)
		  arr(i,4)=arr(i,4)+formatnumber(v,2)
		case 2
		  arr(i,4)="&nbsp;"
		end select
		Response.Write "<td>"
		if instr(FieldName,"id")>0 then response.write "&nbsp;"	'���ǰ��һ���ո�
		on error resume next '���ڵ���*************************************
		Response.Write Trim(ds.Fields.Item(FieldName).value)
		if err.number<>0 then '���ڵ���
		  de "û�� "&FieldName&" , "&arr(i,1)&" ����ֶ�!"
		  response.end
		end if
		Response.Write "</td>"
	  next
      Response.Write "</tr>"
	  ds.movenext
	wend
	  Response.Write "<tr id="""&row+1&""">"
	  for i=0 to ac-1
	  response.Write "<td>"
	  if i=0 then
	     response.Write("�ϼ�")
	  else
	     response.Write arr(i,4)
	  end if
	  Response.Write "<input type=""hidden"" name=""csd"" value=""0"">"
	  response.Write "</td>"
	  next
    Response.Write "</table>"
	Response.Write "</div>"
	ds.close
    set ds=nothing
	
	Response.Write("<script language=""javascript"">")
    Response.Write("try{")
	Response.Write(" gt = new GtTable(""gt1"");")
	Response.Write(" gtTables.addTable(gt);")
	Response.Write(" gt.loadTable();")
	Response.Write("}catch(ex){}")
	Response.Write("</script>")

  End Sub

End Class%>