<!--#include FILE="upload_inc.asp"-->
<html>
<head>
</head>
<style>
body { font-size:9pt  }
</style>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script>
if (top.location==self.location){
	top.location="login.asp"
}
</script>
<%
set upload=new upload_5xsoft
set file=upload.file("sf_upfile")
if file.fileSize<1 then
   response.write"<script language=javascript>alert('��û��ѡ��ͼƬ��~~~\n\n�������������������ť���ӵ����Ĵ�����ѡ��Ҫ�ϴ���ͼƬ��\n\n����������Ȼ�����ϴ���ť�Ϳ��԰�ͼƬ�ϴ���...\n\n��������������Ҫע��ͼƬ�ĸ�ʽŶ~~~');history.back()</script>"
   response.end 
end if
if file.fileSize<10 or file.fileSize>1000*1024 then
	response.write "����:�ϴ���ͼƬ��С����������! <a href='javascript:history.go(-1)'>�˻���һ��</a>"
	response.end
end if
upfilename = split(file.FileName,".")
upfileext = upfilename(ubound(upfilename))
if upfileext<>"jpg" and upfileext<>"jpeg" and upfileext<>"gif" and upfileext<>"JPG" and upfileext<>"JPEG" and upfileext<>"GIF"then
	response.write "����:�ϴ����ļ���ʽ����! <a href='javascript:history.go(-1)'>�˻���һ��</a>"
	response.end
end if
ufp="news_"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&"."&upfilename(ubound(upfilename))
file.saveas Server.mappath("../../../../upload/"&ufp)
%>
<script >
parent.formadd.ImageUrl.value='/upload/<%=ufp%>'
parent.formadd.ImageShopPic.src='../../../../upload/<%=ufp%>'
location.replace('upload.asp')
</script>
<%
set file=nothing
set upload=nothing
'set my_conn = nothing
'set rs = nothing
%>
</body></html>