<!-- #include file="Setup.asp" -->
<!--#include FILE="Utility/UpFile_Class.asp"-->
<%
if CookieUserName=empty then Alert("����δ��¼��̳")
if Request.ServerVariables("Request_method") = "POST" then


'����Ŀ¼
If IsObjInstalled("Scripting.FileSystemObject") Then
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	strDir="UpFile/UpAttachment/"&year(now)&"-"&month(now)&""
	if not fso.folderexists(Server.MapPath(strDir)) then fso.CreateFolder(Server.MapPath(strDir))
	Set fso = nothing
	UpFolder=""&year(now)&"-"&month(now)&"/"
end if

	UpFolder="UpFile/UpAttachment/"&UpFolder&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&""	'�ϴ�·�����ļ���
	UpMaxFileSize=SiteConfig("MaxFileSize")*1024		'����ϴ��ļ���С
	UpFileTypes=LCase(SiteConfig("UpFileTypes"))	'�����ϴ��ļ�����

%>
<!--#include FILE="Utility/UpFile.asp"-->
<%
	Rs.Open "[BBSXP_PostAttachments]",conn,1,3 
	Rs.addnew 
		Rs("UserName")=CookieUserName
		Rs("FileName")=FileName
		Rs("ContentType")=FileMIME
		Rs("ContentSize")=FileSize
		Rs("FilePath")=SaveFile
	Rs.update
	AttachmentID=Rs("UpFileID")
	Rs.close
%>


<script language="JavaScript">
parent.document.form.UpFileID.value+='<%=AttachmentID%>,';
parent.document.getElementById("UpFile").innerHTML+="<img src=images/affix.gif><a target=_blank href=<%=SaveFile%> title='<%=FileName%>'><%=FileName%></a><br>";
	
var FileMIME="<%=FileMIME%>"
if (parent.YuZi_CurrentMode.toLowerCase() == 'design') {
	parent.BBSXPEditorForm.focus();
	if (FileMIME.split ('/')[0]=="image"){
		var element = parent.document.createElement("img");
		element.src = "<%=SaveFile%>";
		element.border = 0;
	}else{
		var element = parent.document.createElement("span");
		element.innerHTML = "[url=<%=SaveFile%>][img]images/affix.gif[/img]<%=FileName%>[/url]"
	}
	parent.BBSXPSelection();
	parent.BBSXPInsertItem(element);
	parent.BBSXPDisableMenu();
	parent.BBSXPReloadIframe();	
	}
else {
	if (FileMIME.split ('/')[0]=="image"){
		parent.document.getElementById("BBSXPCodeForm").value += "[img]<%=SaveFile%>[/img]";
	}else{
		parent.document.getElementById("BBSXPCodeForm").value += "[url=<%=SaveFile%>][img]images/affix.gif[/img]<%=FileName%>[/url]"
	}
}
parent.BBSXP_Modal.Close();
</script>
<%
else
Response.clear
%>
<title>��Ӹ���</title>
<style>body,table{FONT-SIZE:9pt;}</style>
<form enctype=multipart/form-data method=Post action=?>
<input type=file name=file size="50"><br><br>
֧���ļ����ͣ�<%=Ucase(replace(""&SiteConfig("UpFileTypes")&"","|","��"))%><br>
�ļ���С���ƣ�<%=CheckSize(SiteConfig("MaxFileSize")*1024)%><br><br>
<center><input type="submit" value=" �� �� "> 
<input type="button" onclick="javascript:parent.BBSXP_Modal.Close()" value=" ȡ �� "></center>
</form>
<%
end if
%>