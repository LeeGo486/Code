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
  Private IsAColor 'as integer ''是否根据审核登帐状态显示行的颜色
  Private Color 'as String ''颜色
  Private CField 'As Integer ''根据该字段显示颜色
  
  Private Dwidth,Dheight 'As String '表格宽和高,其实是<DIV>的宽和高
  
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
  
  Public Property Let CSureName(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class.Table","审核字段名不能为空!"
    CSure=Value
  End Property
  
  Public Property Let SureName(Value)
    Value=Trim(Value)
    if Value=null or Value="" then Err.Raise 50001,"Class.Table","登帐字段名不能为空!"
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
    if Value=null or Value="" then Err.Raise 50001,"Class","颜色字段设置错误!"
    CField=Value
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
	
	if ctype=4 then'定义并添加输入参数
      For i = 0 To pc-1 '参数名、参数数据类型、参数类型、数据长度、参数值
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


  Public Sub Show() ''显示记录集
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
    set ds=GetDs() ''取得记录集
	row=0
    while not ds.eof
	  row=row+1
      Response.Write "<tr id="""&row&""" style=""background:#F00""><td style=""background:#F00"">"
	  tmp=0 '清空上一次的tmp
	  select case IsAcolor '是否自动生成颜色
	  case 0 '自动生成
	    if ds.Fields.Item(Csure).value=1 then tmp="1" '此处可调整优先级,也即同时出现时,以哪个为准
        if ds.Fields.Item(sure).value=1 then tmp="2"
	  case 1 '不处理颜色
	    '
	  case 3
	    cf=ds.Fields.Item(CField).value ''参照配货时
	    if isnull(cf) or cf="" then ''一次都没有配
				tmp="2"
			else ''至少配过一次
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
		case 0'统计个数
		  arr(i,4)=arr(i,4)+1
		case 1'统计相加数
		  'arr(i,4)=arr(i,4)+clng(v)
		  arr(i,4)=arr(i,4)+formatnumber(v,2)
		case 2
		  arr(i,4)="&nbsp;"
		case 3'显示合计
		  arr(i,4)="合计"
		case 4'显示为空
		  arr(i,4)="&nbsp;"
		end select
		Response.Write "<td>"
		if instr(FieldName,"id")>0 then response.write "&nbsp;"	'编号前加一个空格
		on error resume next '用于调试*************************************
		Response.Write Trim(ds.Fields.Item(FieldName).value)
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
	  if i=0 then
	     response.Write("合计")
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
  
    Public Sub ShowRS(RS) ''显示记录集
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
    set ds=RS ''取得记录集
	row=0
    while not ds.eof
	  row=row+1
      Response.Write "<tr id="""&row&"""><td>"
	  tmp=0 '清空上一次的tmp
	  select case IsAcolor '是否自动生成颜色
	  case 0 '自动生成
	    if ds.Fields.Item(Csure).value=1 then tmp="1" '此处可调整优先级,也即同时出现时,以哪个为准
        if ds.Fields.Item(sure).value=1 then tmp="2"
	  case 1 '不处理颜色
	    '
	  case 3
	    cf=ds.Fields.Item(CField).value ''参照配货时
	    if isnull(cf) or cf="" then ''一次都没有配
		  tmp="2"
		else ''至少配过一次
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
		case 0'统计个数
		  arr(i,4)=arr(i,4)+1
		case 1'统计相加数
		  'arr(i,4)=arr(i,4)+clng(v)
		  arr(i,4)=arr(i,4)+formatnumber(v,2)
		case 2
		  arr(i,4)="&nbsp;"
		end select
		Response.Write "<td>"
		if instr(FieldName,"id")>0 then response.write "&nbsp;"	'编号前加一个空格
		on error resume next '用于调试*************************************
		Response.Write Trim(ds.Fields.Item(FieldName).value)
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
	  if i=0 then
	     response.Write("合计")
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