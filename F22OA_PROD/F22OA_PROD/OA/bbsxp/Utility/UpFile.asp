<%
Sub CheckFileExt()

	if instr("|gif|jpg|jpeg|png|","|"&FileExt&"|") > 0 then
		if split(FileMIME,"/")(0)<>"image" then Alert("��׺�����ļ����Ͳ�����")
	end if

	if UpClass="Face" then
		if instr("|gif|jpg|jpeg|png|","|"&FileExt&"|") <= 0 then Alert("�Բ���ͷ��ֻ���ϴ���׺��Ϊ gif��jpg��jpeg��png ��ʽ���ļ�")
	else
		if instr("|"&SiteConfig("UpFileTypes")&"|","|"&FileExt&"|") <= 0 then Alert("�Բ��𣬹���Ա�趨����̳�������ϴ� "&FileExt&" ��ʽ���ļ�")
	end if
	
	if FileExt="asa" or FileExt="asp" or FileExt="cdx" or FileExt="cer" or FileExt="aspx" then Alert("�Բ��𣬹���Ա�趨����̳�������ϴ� "&FileExt&" ��ʽ���ļ�")

	if FileSize < 1 then Alert("��ǰ�ļ�Ϊ���ļ�")
	if FileSize > UpMaxFileSize then Alert("�ļ���С���ó��� "&CheckSize(UpMaxFileSize)&"\n��ǰ���ļ���СΪ "&CheckSize(FileSize)&"")

	if UpClass<>"Face" then
		TotalUserPostAttachments=Execute("Select sum(ContentSize) from [BBSXP_PostAttachments] where UserName='"&CookieUserName&"'")(0)
		if TotalUserPostAttachments+FileSize>SiteConfig("MaxPostAttachmentsSize")*1024 then Alert("�����ϴ��ռ�������")
	end if

End Sub


if ""&SiteConfig("UpFileOption")&""="" then
	Alert("�Բ��𣬹���Ա�ر��ļ��ϴ�����")
elseif SiteConfig("UpFileOption")="ADODB.Stream" then
	set upfile=new upfile_class				'�����ϴ�����
	upfile.GetData ()					'ȡ���ϴ�����
	FileName=upfile.file("file").FileName			'�ļ���
	FileExt=LCase(upfile.file("file").FileExt)		'Сд��׺��
	FileMIME=upfile.file("file").FileMIME			'�ļ�����
	FileSize=upfile.file("file").FileSize			'�ļ���С
	SaveFile=""&UpFolder&"."&FileExt&""			'�����ļ�·��
	CheckFileExt()
	upfile.SaveToFile "file",Server.mappath(""&SaveFile&"")
elseif SiteConfig("UpFileOption")="SoftArtisans.FileUp" then
	Set FileUP = Server.CreateObject("SoftArtisans.FileUp")
	FileName=FileUP.ShortFilename				'�ļ���
	FileExt=LCase(mid(FileName,InStrRev(FileName, ".")+1))	'Сд��׺��
	FileMIME=FileUP.ContentType				'�ļ�����
	FileSize=FileUP.TotalBytes				'�ļ���С
	SaveFile=""&UpFolder&"."&FileExt&""			'�����ļ�·��
	CheckFileExt()
	FileUP.SaveAs Server.mappath(""&SaveFile&"")
end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if SiteConfig("WatermarkOption")="Persits.Jpeg" and FileMIME="image/pjpeg" and UpClass<>"Face" then
	Set Jpeg = Server.CreateObject("Persits.Jpeg")
	Jpeg.Open Server.MapPath(""&SaveFile&"")
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if SiteConfig("WatermarkType")=0 then
		Jpeg.Canvas.Font.Color = Replace(SiteConfig("WatermarkFontColor"),"#","&h")	'��ɫ
		Jpeg.Canvas.Font.Family = SiteConfig("WatermarkFontFamily")  		'����
		Jpeg.Canvas.Font.size = SiteConfig("WatermarkFontSize")			'��С
		Jpeg.Canvas.Font.Bold = CBool(SiteConfig("WatermarkFontIsBold"))	'�Ƿ�Ӵ�

		Title = SiteConfig("WatermarkText") 
		TitleWidth = Jpeg.Canvas.GetTextExtent(Title)

		select case SiteConfig("WatermarkWidthPosition")
			case "left"
				PositionWidth=10
			case "center"
				PositionWidth=(Jpeg.Width - TitleWidth) / 2
			case "right"
				PositionWidth= Jpeg.Width - TitleWidth - 10
		end select

		Jpeg.Canvas.Print PositionWidth, 10, Title

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	elseif SiteConfig("WatermarkType")=1 then
		Set Jpeg2 = Server.CreateObject("Persits.Jpeg")
		Jpeg2.Open Server.MapPath(SiteConfig("WatermarkImage"))
		Jpeg2Width=Jpeg2.OriginalWidth
		Jpeg2Height=Jpeg2.OriginalHeight

		select case SiteConfig("WatermarkWidthPosition")
			case "left"
				PositionWidth=10
			case "center"
				PositionWidth=(Jpeg.Width - Jpeg2Width) / 2
			case "right"
				PositionWidth= Jpeg.Width - Jpeg2Width - 10
		end select

		select case SiteConfig("WatermarkHeightPosition")
			case "top"
				PositionHeight=10
			case "center"
				PositionHeight=(Jpeg.Height - Jpeg2Height) / 2
			case "bottom"
				PositionHeight= Jpeg.Height - Jpeg2Height - 10
		end select

		Jpeg.Canvas.DrawImage PositionWidth, PositionHeight, Jpeg2, 1, &HFFFFFF	'͸����, ͸����ɫ
	end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Jpeg.Save Server.MapPath(""&SaveFile&"")
	Set Jpeg = Nothing
end if

%>