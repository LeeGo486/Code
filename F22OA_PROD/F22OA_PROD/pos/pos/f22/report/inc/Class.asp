<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Class Table
  'Private Const AI =20
  Private AI ''常量,字段数组长度
  Private arr(40,4) 'As Variant
  Private ac 'As Integer ''字段名数组索引
  
  'Private Const PI =10
  Private PI ''常量,参数数组长度
  Private param(10,3) 'as variant ''存储过程参数数组
  Private pc 'as integer

  Private i ' As Integer
  
  Private ctype ''命令类型
  Private ctext 'As String ''命令
  
  Private cn 'As ADODB.Connection ''连接
  
  Private CSure 'As String ''审核字段名
  Private Sure 'As String ''登帐字段名
  Private PkIndex 'As Integer ''主键位置
  
  Private Dwidth,Dheight 'As String '表格宽和高,其实是<DIV>的宽和高
	private DMSelect,DMSDefCheck,DMselectValue 'As Bool '是否可多选
  
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
	DMSelect=false
	DMSDefCheck=false
	DMselectValue=0	'选中的值
  End Sub
  
  Public Property Let CommandType(Value)
    if not isNumeric(Value) then Err.Raise 50001,"Class.Table","CommandType的值只能是数字!"
    ctype=Value
  End Property
  
  Public Property Let CommandText(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class.Table","CommandText的值不能为空!"
    ctext=Value
  End Property
  
  Public Property Let ActiveConnection(Value)
    if Value=null then Err.Raise 50001,"Class.Table","Connection对象的值不能为NULL!"
    cn=Value
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
  
  Public Property Let MSelect(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Value=false
	DMSelect=Value
  End Property
	
  Public Property Let MSDefCheck(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Value=false
	DMSDefCheck=Value
  End Property
	
  Public Property Let MselectValue(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Value=0
	DMselectValue=Value
  End Property
	
  
  Public Sub SetField(FieldName,DisplayName,Length,tj) ''设置字段数组
    if ac>AI then Err.Raise 50001,"Class","字段数组索引越界,不能超过"&AI&"个字符!"
    arr(ac,0)=FieldName
	arr(ac,1)=DisplayName
	arr(ac,2)=Length
	arr(ac,3)=tj
	arr(ac,4)=0
	ac=ac+1
  End Sub
  
  Public Sub SetParam(pname,ptype,plength,pvalue)
    if pc>PI then Err.Raise 50001,"Class","存储过程参数数组索引越界,不能超过"&PI&"个字符!"
    Param(pc,0)=pname
    Param(pc,1)=ptype
    Param(pc,2)=plength
    Param(pc,3)=pvalue
	pc=pc+1
  End Sub
	

  Public Function GetDs() 'As ADODB.Recordset ''产生记录集
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
	
	if ctype=4 then					'定义并添加输入参数
      For i = 0 To pc-1 	'参数名、参数数据类型、参数类型、数据长度、参数值
        cd.Parameters.Append cd.CreateParameter(Param(i, 0), Param(i, 1), adParamInput, Param(i, 2), Param(i, 3))
        'response.Write(Param(i, 0)&" , "& Param(i, 1)&" , "& "adParamInput" &" , "& Param(i, 2)&" , "& Param(i, 3)&"<br>")
      Next
	  'response.end
	end if
	
	set ds=cd.Execute
	set GetDs=ds
	Set ds=Nothing
	Set cd=Nothing
	Set Cntmp=Nothing
  End Function

  Public Sub Show() ''显示记录集
	Dim FieldName 'As String
	Dim DisplayName 'As String
	Dim Length 'As String
	Dim ds 'As ADODB.Recordset
	Dim tmp 'As String
	Dim row 'As integer
	Dim v 'As String
	'call sp
	
	Response.Write "<div id=""gt1"" style=""width:"&Dwidth&";height:"&Dheight&";"">"
	Response.Write "<table border=1>"
	Response.Write "<thead><tr>"
	
		'多选框
		if DMSelect then
			Response.Write "<th width=""30"">选择</th>"
		end if

    for i=0 to ac-1
      FieldName=arr(i,0)
      DisplayName=arr(i,1)
      Length=arr(i,2)
			
      Response.Write "<th width="""&Length&""">"&DisplayName&"</th>"
		next
    Response.Write "</tr></thead>"
    set ds=GetDs() ''取得记录集
	row=0
    while not ds.eof
	  row=row+1
	  Response.Write "<tr id="""&row&""">"
	  
		'多选框
		if DMSelect then
			Response.Write "<td><input type=""checkbox"" value="""&ds.Fields.Item(DMselectValue).value&""""&_
														" name="""&ds.Fields.Item(DMselectValue).name&""" onclick=""return false"" "
			if DMSDefCheck then response.write " checked=checked"
			response.write " /></td>"
		end if

		For i=0 to ac-1
			FieldName=arr(i,0)
		v=ds.Fields.Item(FieldName).value
		select case arr(i,3)
		case 0'统计个数
		  arr(i,4)=arr(i,4)+1
		case 1'统计相加数
		  'arr(i,4)=arr(i,4)+clng(v)
		  arr(i,4)=arr(i,4)+formatnumber(v,4)
		case 2
		  arr(i,4)=arr(i,4)+clng(v)
		case 3'显示合计
		  arr(i,4)="合计"
		case 4'显示为空
		  arr(i,4)="&nbsp;"
		end select
		Response.Write "<td>"
		if instr(FieldName,"colorid")>0 then response.write "&nbsp;"	'编号前加一个空格
		if instr(FieldName,"clothingid")>0 then response.write "&nbsp;"	'编号前加一个空格
		if instr(FieldName,"depotid")>0 then response.write "&nbsp;"	'编号前加一个空格
		on error resume next '用于调试*************************************
		Response.Write Trim(v)
		if err.number<>0 then '用于调试
		  de "没有 "&FieldName&" , "&arr(i,1)&" 这个字段!"
		  response.end
		end if
		Response.Write "</td>"
	  next
      Response.Write "</tr>"
	  ds.movenext
	wend
    Response.Write "<tr id="""&row+1&""">"
		'多选框
		if DMSelect then
			Response.Write "<td></td>"
		end if
	for i=0 to ac-1
	  response.Write "<td>"
	  response.Write arr(i,4)
	  Response.Write "<input type=""hidden"" name=""csd"" value=""1"">"
	  response.Write "</td>"
	next
    Response.Write "</tr>"
    Response.Write "</table>"
	Response.Write "</div>"
	ds.close
    set ds=nothing
  End Sub
  
  Sub sp()
    for i=0 to ac-1
	  response.Write(arr(i,0)&":")
	  response.Write(arr(i,1))
	next
  End Sub
  
  Public Sub ShowRs(rs) ''显示记录集
	Dim FieldName 'As String
	Dim DisplayName 'As String
	Dim Length 'As String
	Dim ds 'As ADODB.Recordset
	Dim tmp 'As String
	Dim row 'As integer
	Dim v 'As String
	'call sp
    Response.Write "<div id=""gt1"" style=""width:"&Dwidth&";height:"&Dheight&";"" border=0>"
	Response.Write "<table border=1>"
	Response.Write "<thead><tr>"
    for i=0 to ac-1
      FieldName=arr(i,0)
      DisplayName=arr(i,1)
      Length=arr(i,2)
      Response.Write "<th width="""&Length&""">"&DisplayName&"</th>"
	next
    Response.Write "</tr></thead>"
    'set ds=GetDs() ''取得记录集
	set ds=rs
	row=0
    while not ds.eof
	  row=row+1
	  Response.Write "<tr id="""&row&""">"
      For i=0 to ac-1
        FieldName=arr(i,0)
		v=ds.Fields.Item(FieldName).value
		select case arr(i,3)
		case 0'统计个数
		  arr(i,4)=arr(i,4)+1
		case 1'统计相加数
		  arr(i,4)=arr(i,4)+clng(v)
		case 2
		  arr(i,4)=arr(i,4)+clng(v)
		end select
        
		Response.Write "<td>"
		if instr(FieldName,"colorid")>0 then response.write "&nbsp;"	'编号前加一个空格
		on error resume next '用于调试*************************************
		Response.Write Trim(v)
		if err.number<>0 then '用于调试
		  de "没有 "&FieldName&" , "&arr(i,1)&" 这个字段!"
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
	  response.Write arr(i,4)
	  Response.Write "<input type=""hidden"" name=""csd"" value=""1"">"
	  response.Write "</td>"
	next
    Response.Write "</tr>"
    Response.Write "</table>"
	'Response.Write "</div>"
	ds.close
    set ds=nothing
  End Sub

End Class%>