<%
option explicit
Const JET_3X = 4
if ""&Request.Form("sessionid")&""<>""&session.sessionid&"" then Alert("Ч�������")

Dim dbpath,boolIs97
dbpath = Request.Form("dbpath")
boolIs97 = Request.Form("boolIs97")

If dbpath <> "" Then
	dbpath = server.mappath(dbpath)
	response.write(CompactDB(dbpath,boolIs97))
End If


Function CompactDB(dbPath, boolIs97)
	Dim fso, Engine, strDBPath
	strDBPath = Left(dbPath,instrrev(DBPath,"\"))
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(dbPath) Then
		Set Engine = CreateObject("JRO.JetEngine")
		On Error Resume Next
		If boolIs97 = "True" Then
			Engine.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbpath, _
			"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb;" _
			& "Jet OLEDB:Engine Type=" & JET_3X
		Else
			Engine.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbpath, _
			"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb"
		End If
		If Err Then error("����ʶ������ݿ��ʽ")
		fso.CopyFile strDBPath & "temp.mdb",dbpath
		fso.DeleteFile(strDBPath & "temp.mdb")
		Set fso = nothing
		Set Engine = nothing
		CompactDB = "<script language='JavaScript'>alert('ѹ���ɹ���');history.back();</script>"
	Else
		CompactDB = "<script language='JavaScript'>alert('�Ҳ������ݿ⣡\n�������ݿ�·���Ƿ��������');history.back();</script>"
	End If
End Function

Sub Alert(Message)
%>
<script language='JavaScript'>alert('<%=Message%>');history.back();</script><script language='JavaScript'>window.close();</script>
<%
	response.end
End Sub
%>