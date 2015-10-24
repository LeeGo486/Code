<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#include file="config.asp"-->
<!--#include file="util.asp"-->
<!--#include file="io.asp"-->
<!--#include file="basexml.asp"-->
<!--#include file="commands.asp"-->
<!--#include file="class_upload.asp"-->
<%
Dim oUploader
Set oUploader = New NetRube_Upload
oUploader.MaxSize	= 0
oUploader.Allowed	= ConfigAllowedExtensions.Item( resourceType )
oUploader.Denied	= ConfigDeniedExtensions.Item( resourceType )
oUploader.GetData

If oUploader.ErrNum > 1 Then
	SendResults "202", "", "", ""
Else
	Dim sFileName, sFileUrl, sErrorNumber, sOriginalFileName, sExtension
	sFileName		= ""
	sFileUrl		= "File/"
	sErrorNumber	= "0"

	' Map the virtual path to the local server path.
	Dim sServerDir
	sServerDir = Server.MapPath( ConfigUserFilesPath )
	If ( Right( sServerDir, 1 ) <> "\" ) Then
		sServerDir = sServerDir & "\"
	End If

	Dim oFSO
	Set oFSO = Server.CreateObject( "Scripting.FileSystemObject" )

	' Get the uploaded file name.
	sFileName	= oUploader.File( "NewFile" ).Name
	sExtension	= oUploader.File( "NewFile" ).Ext
	sFileName	= sFileUrl&sFileName
	sOriginalFileName = sFileName
	sTipsName	= oUploader.File( "NewFile" ).Name
	Dim iCounter
	iCounter = 0

	Do While ( True )
		Dim sFilePath
		sFilePath = sServerDir & sFileName

		If ( oFSO.FileExists( sFilePath ) ) Then
			iCounter = iCounter + 1
			sFileName = RemoveExtension( sOriginalFileName ) & "(" & iCounter & ")." & sExtension
			sErrorNumber = "201"
		Else
			oUploader.SaveAs "NewFile", sFilePath
			If oUploader.ErrNum > 0 Then SendResults "202", "", "", ""
			Exit Do
		End If
	Loop
	sFileUrl = ConfigUserFilesPath & sFileName

End If

Set oUploader = Nothing
%>


<script>
//方案一：上传文件成功后提示上传成功，并等待用户确定后插入编辑器内相应的内容。
parent.myform.thumb.value="<%=sFileUrl%>";
alert('上传成功!');

//方案二：上传文件成功后，直接插入编辑器内容，并关掉上传对话框。
//alert('上传成功!');
//parent.FCK.InsertHtml("<IMG SRC='/zhxeditor/editor/images/icon_download.gif' border=0><a href='<%=sFileUrl%>'><%=sFileName%>下载附件</a>");
//window.close();
</script>