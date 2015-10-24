<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Class Table
  'Private Const AI =20
  Private AI ''常量,字段数组长度
  Private arr(40,2) 'As Variant
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
  
  Public Sub SetField(FieldName,DisplayName,Length) ''设置字段数组
    if ac>AI then Err.Raise 50001,"Class","字段数组索引越界,不能超过"&AI&"个字符!"
    arr(ac,0)=FieldName
	arr(ac,1)=DisplayName
	arr(ac,2)=Length
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
      Response.Write "<tr id="""&row&"""><td>"
	  tmp=0 '清空上一次的tmp
	 
      Response.Write "<input type=""hidden"" name=""csd"" value="""&tmp&""">"
      Response.Write Trim(ds.Fields.Item(arr(0,0)).value)
	  Response.Write "</td>"
      For i=1 to ac-1
        FieldName=arr(i,0)
		Response.Write "<td>"
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
    Response.Write "</table>"
	'Response.Write "</div>"
	ds.close
    set ds=nothing
  End Sub
End Class%>