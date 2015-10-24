<%
''''''''''''''''''''''''''''''''''''
Function HTMLEncode(fString)

	fString=Trim(fString)
	fString=Replace(fString,CHR(9),"")
	fString=Replace(fString,CHR(13),"")
	fString=Replace(fString,CHR(22),"")
	fString=Replace(fString,CHR(38),"&#38;")	'“&”
	fString=Replace(fString,CHR(32),"&#32;")	'“ ”
	fString=Replace(fString,CHR(34),"&#34;")	'“"”
	fString=Replace(fString,CHR(39),"&#39;")	'“'”
	fString=Replace(fString,CHR(42)&CHR(42),"&#42;&#42;")	'“**”/**/
	fString=Replace(fString,CHR(44),"&#44;")	'“,”
	fString=Replace(fString,CHR(60),"&#60;")	'“<”
	fString=Replace(fString,CHR(62),"&#62;")	'“>”
	fString=Replace(fString,CHR(92),"&#92;")	'“\”
	fString=Replace(fString,CHR(45)&CHR(45),"&#45;&#45;")	'“--”
	fString=Replace(fString,CHR(59),"&#59;")	'“;”
	fString=Replace(fString,CHR(10),"<br>")
	fString=ReplaceText(fString,"([&#])([a-z0-9]*)&#59;","$1$2;")

	if IsSqlDataBase=0 then '过滤片假名(日文字符)[\u30A0-\u30FF] by yuzi
		fString=escape(fString)
		fString=ReplaceText(fString,"%u30([A-F][0-F])","&#x30$1;")
		fString=unescape(fString)
	end if

	HTMLEncode=fString
End Function
''''''''''''''''''''''''''''''''''''
Function BodyEncode(fString)
	fString=Replace(fString,vbCrlf, "")
	fString=Replace(fString,"\","&#92;")
	fString=Replace(fString,"'","&#39;")
	fString=Replace(fString,"<a href=","<a target=_blank href=") '点链接打开新窗口
	if SiteConfig("BannedHtmlLabel")<>"" then fString=ReplaceText(fString,"<(\/|)("&SiteConfig("BannedHtmlLabel")&")", "&lt;$1$2")
	if SiteConfig("BannedHtmlEvent")<>"" then fString=ReplaceText(fString,"<(.[^>]*)("&SiteConfig("BannedHtmlEvent")&")", "&lt;$1$2")
	if SiteConfig("BannedText")<>"" then fString=ReplaceText(fString,"("&SiteConfig("BannedText")&")",string(len("&$1&"),"*"))
	BodyEncode=fString
End Function
''''''''''''''''''''''''''''''''''''
Function YbbEncode(str)
	str=ReplaceText(str,"\[(\/|)(b|i|u|strike|center|marquee)\]","<$1$2>")
	str=ReplaceText(str,"\[COLOR=([^[]*)\]","<FONT COLOR=$1>")
	str=ReplaceText(str,"\[FONT=([^[]*)\]","<FONT face=$1>")
	str=ReplaceText(str,"\[SIZE=([0-9]*)\]","<FONT size=$1>")
	str=ReplaceText(str,"\[\/(SIZE|FONT|COLOR)\]","</FONT>")
	str=ReplaceText(str,"\[URL\]([^[]*)","<A TARGET=_blank HREF=$1>$1")
	str=ReplaceText(str,"\[URL=([^[]*)\]","<A TARGET=_blank HREF=$1>")
	str=ReplaceText(str,"\[\/URL\]","</A>")
	str=ReplaceText(str,"\[EMAIL\](\S+\@[^[]*)(\[\/EMAIL\])","<a href=mailto:$1>$1</a>")
	str=ReplaceText(str,"\[IMG\]([^("&CHR(34)&"|[|#)]*)(\[\/IMG\])","<img border=0 src=$1>")
	str=ReplaceText(str,"\[quote\]","<blockquote>")
	str=ReplaceText(str,"\[quote user="&CHR(34)&"([^[]*)"&CHR(34)&"\]","<blockquote><img border=0 src=images/icon-quote.gif> <b>$1:</b><br>")
	str=ReplaceText(str,"\[\/quote\]","</blockquote>")
	YbbEncode=str
End Function

''''''''''''''''''''''''''''''''''''
Function RequestInt(fString)

	RequestInt=Request(fString)

	if IsNumeric(RequestInt) then
		RequestInt=int(RequestInt)
	else
		RequestInt=0
	end if

End Function

''''''''''替换模块START''''''''''''
Function ReplaceText(fString,patrn,replStr)
	Set regEx = New RegExp   	' 建立正则表达式。
		regEx.Pattern = patrn   ' 设置模式。
		regEx.IgnoreCase = True ' 设置是否区分大小写。
		regEx.Global = True     ' 设置全局可用性。 
		ReplaceText = regEx.Replace(""&fString&"",""&replStr&"") ' 作替换。
	Set regEx=nothing
End Function
''''''''''替换模块END''''''''''''
Function ResponseCookies(Key,Value,Expires)

	Response.Cookies(Key) = ""&Value&""
	Response.Cookies(Key).Path = SiteConfig("CookiePath")
	if int(Expires)>0 then Response.Cookies(Key).Expires = date+Expires

End Function
'''''''''''''''''''''''''''''''''''''''''''
Function RequestCookies(CookieName)

	RequestCookies=Request.Cookies(CookieName)

End Function
'''''''''''''''''''''''''''''''''''''''''''
Function CleanCookies()

	For Each objCookie In Request.Cookies
		ResponseCookies objCookie,"",0
	Next

End Function

'''''''''''''''''''''''''''''''''''''''''''
Function DelFile(DelFilePath)
	On Error Resume Next
	DelFile= False
	Set MyFileObject=Server.CreateOBject("Scripting.FileSystemObject")
	MyFileObject.DeleteFile""&Server.MapPath(""&DelFilePath&"")&""
	Set MyFileObject= Nothing
	If 0 = Err or 53 = Err Then
		DelFile= True
	else
		Alert("出错讯息："&Err.Description&"\n"&DelFilePath&" 无法删除！")
	end if
	On Error GoTo 0
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function CheckSize(ByteSize)
	if ByteSize=>1073741824 then
		ByteSize=formatnumber(ByteSize/1073741824)&" GB"
	elseif ByteSize=>1048576 then
		ByteSize=formatnumber(ByteSize/1048576)&" MB"
	elseif ByteSize=>1024 then
		ByteSize=formatnumber(ByteSize/1024)&" KB"
	else
		ByteSize=ByteSize&" 字节"
	end if
	CheckSize=ByteSize
End Function
'''''''''''''''''''''''''''''''''''''''''''
'针对中文日期格式的服务器
Function FormatTime(value)
	FormatTime=""&FormatDateTime(value, 2)&" "&FormatDateTime(value, 4)&":"&second(value)&""
End Function

Function DefaultPasswordFormat(value)
	if SiteConfig("DefaultPasswordFormat")="MD5" then
		DefaultPasswordFormat=MD5(value)
	Else
		DefaultPasswordFormat=SHA1(value)
	End if
End Function



'''''''''''''''''''''''''''''''''''''''''''
Sub ConciseMsg(Message)
	Response.write(Message)	
	Response.End
End Sub
''''''''''''''''''''''''
Sub Log(Message)
	MessageXML=MessageXML&"<Message>"&Message&"</Message>"&vbCrlf
	MessageXML=MessageXML&"<REMOTE_ADDR>"&REMOTE_ADDR&"</REMOTE_ADDR>"&vbCrlf
	MessageXML=MessageXML&"<Request_Method>"&Escape(Request.ServerVariables("Request_method"))&"</Request_Method>"&vbCrlf
	MessageXML=MessageXML&"<Server_Name>"&Escape(Request.ServerVariables("server_name"))&"</Server_Name>"&vbCrlf
	MessageXML=MessageXML&"<Script_Name>"&Escape(Request.ServerVariables("script_name"))&"</Script_Name>"&vbCrlf
	MessageXML=MessageXML&"<Query_String>"&Escape(Request.ServerVariables("Query_String"))&"</Query_String>"&vbCrlf
	MessageXML=MessageXML&"<Request_Form>"&Escape(Request.Form)&"</Request_Form>"&vbCrlf
	MessageXML=MessageXML&"<All_Http>"&Escape(Request.ServerVariables("All_Http"))&"</All_Http>"&vbCrlf
End Sub
''''''''''''''''''''''''''''''''
'取得标准日期格式
function get_date(tdate)
  dim y,m,d
  y=year(tdate)
  m=month(tdate)
  d=day(tdate)
  m=cint(m)
  d=cint(d)
  if m<10 then m="0"&m
  if d<10 then d="0"&d
  d=y & "-" & m & "-" & d
  get_date=d
end function

Sub close(str)
url = reques
  response.Write("<script language='javascript'>")
  response.Write("alert('"& str &"');")
	response.Write("window.close()")
  response.Write("</script>")
  response.End()
End Sub

Sub zclose()
  response.Write("<script language='javascript'>")
	response.Write("window.close()")
  response.Write("</script>")
  response.End()
End Sub

sub mbox(str)
  response.write "<script language=""javascript"">"
  response.write "alert("""&str&""");"
  'response.write "history.back();"
  response.write "</script>"
  response.end
end sub

function de(s)
 response.Write("<textarea cols=50 rows=12>"&s&"</textarea>")
 response.End()
end function%>
