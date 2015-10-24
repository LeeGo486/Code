<!-- #include file="Setup.asp" -->
<!--#include FILE="Utility/UpFile_Class.asp"-->
<%
if CookieUserName=empty then Alert("您还未登录论坛")
if Request.ServerVariables("Request_method") = "POST" then


'生成目录
If IsObjInstalled("Scripting.FileSystemObject") Then
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	strDir="UpFile/UpAttachment/"&year(now)&"-"&month(now)&""
	if not fso.folderexists(Server.MapPath(strDir)) then fso.CreateFolder(Server.MapPath(strDir))
	Set fso = nothing
	UpFolder=""&year(now)&"-"&month(now)&"/"
end if

	UpFolder="UpFile/UpAttachment/"&UpFolder&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&""	'上传路径及文件名
	UpMaxFileSize=SiteConfig("MaxFileSize")*1024		'最大上传文件大小
	UpFileTypes=LCase(SiteConfig("UpFileTypes"))	'允许上传文件类型

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
<title>添加附件</title>
<style>body,table{FONT-SIZE:9pt;}</style>
<form enctype=multipart/form-data method=Post action=?>
<input type=file name=file size="50"><br><br>
支持文件类型：<%=Ucase(replace(""&SiteConfig("UpFileTypes")&"","|","、"))%><br>
文件大小限制：<%=CheckSize(SiteConfig("MaxFileSize")*1024)%><br><br>
<center><input type="submit" value=" 上 传 "> 
<input type="button" onclick="javascript:parent.BBSXP_Modal.Close()" value=" 取 消 "></center>
</form>
<%
end if
%>