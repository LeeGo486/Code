<!-- #include file="upload_5xsoft.asp" -->
<%
Server.ScriptTimeout=999999
set upload=new upload_5xsoft
set txt=upload.file("zhx")
'�ϴ��ļ�
if txt.fileSize>0 then
   txt.saveAs Server.mappath ("up/"&txt.filename)
end if
%>