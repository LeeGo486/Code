<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Class Table
  'Private Const AI =20
  Private AI ''����,�ֶ����鳤��
  Private arr(40,2) 'As Variant
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
  
  Public Sub SetField(FieldName,DisplayName,Length) ''�����ֶ�����
    if ac>AI then Err.Raise 50001,"Class","�ֶ���������Խ��,���ܳ���"&AI&"���ַ�!"
    arr(ac,0)=FieldName
	arr(ac,1)=DisplayName
	arr(ac,2)=Length
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
      Response.Write "<tr id="""&row&"""><td>"
	  tmp=0 '�����һ�ε�tmp
	 
      Response.Write "<input type=""hidden"" name=""csd"" value="""&tmp&""">"
      Response.Write Trim(ds.Fields.Item(arr(0,0)).value)
	  Response.Write "</td>"
      For i=1 to ac-1
        FieldName=arr(i,0)
		Response.Write "<td>"
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
    Response.Write "</table>"
	'Response.Write "</div>"
	ds.close
    set ds=nothing
  End Sub
End Class%>