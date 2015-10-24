<%
Sub CheckFileExt()

	if instr("|gif|jpg|jpeg|png|","|"&FileExt&"|") > 0 then
		if split(FileMIME,"/")(0)<>"image" then Alert("后缀名与文件类型不符合")
	end if

	if UpClass="Face" then
		if instr("|gif|jpg|jpeg|png|","|"&FileExt&"|") <= 0 then Alert("对不起，头像只能上传后缀名为 gif、jpg、jpeg、png 格式的文件")
	else
		if instr("|"&SiteConfig("UpFileTypes")&"|","|"&FileExt&"|") <= 0 then Alert("对不起，管理员设定本论坛不允许上传 "&FileExt&" 格式的文件")
	end if
	
	if FileExt="asa" or FileExt="asp" or FileExt="cdx" or FileExt="cer" or FileExt="aspx" then Alert("对不起，管理员设定本论坛不允许上传 "&FileExt&" 格式的文件")

	if FileSize < 1 then Alert("当前文件为空文件")
	if FileSize > UpMaxFileSize then Alert("文件大小不得超过 "&CheckSize(UpMaxFileSize)&"\n当前的文件大小为 "&CheckSize(FileSize)&"")

	if UpClass<>"Face" then
		TotalUserPostAttachments=Execute("Select sum(ContentSize) from [BBSXP_PostAttachments] where UserName='"&CookieUserName&"'")(0)
		if TotalUserPostAttachments+FileSize>SiteConfig("MaxPostAttachmentsSize")*1024 then Alert("您的上传空间已满！")
	end if

End Sub


if ""&SiteConfig("UpFileOption")&""="" then
	Alert("对不起，管理员关闭文件上传功能")
elseif SiteConfig("UpFileOption")="ADODB.Stream" then
	set upfile=new upfile_class				'建立上传对象
	upfile.GetData ()					'取得上传数据
	FileName=upfile.file("file").FileName			'文件名
	FileExt=LCase(upfile.file("file").FileExt)		'小写后缀名
	FileMIME=upfile.file("file").FileMIME			'文件类型
	FileSize=upfile.file("file").FileSize			'文件大小
	SaveFile=""&UpFolder&"."&FileExt&""			'保存文件路径
	CheckFileExt()
	upfile.SaveToFile "file",Server.mappath(""&SaveFile&"")
elseif SiteConfig("UpFileOption")="SoftArtisans.FileUp" then
	Set FileUP = Server.CreateObject("SoftArtisans.FileUp")
	FileName=FileUP.ShortFilename				'文件名
	FileExt=LCase(mid(FileName,InStrRev(FileName, ".")+1))	'小写后缀名
	FileMIME=FileUP.ContentType				'文件类型
	FileSize=FileUP.TotalBytes				'文件大小
	SaveFile=""&UpFolder&"."&FileExt&""			'保存文件路径
	CheckFileExt()
	FileUP.SaveAs Server.mappath(""&SaveFile&"")
end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if SiteConfig("WatermarkOption")="Persits.Jpeg" and FileMIME="image/pjpeg" and UpClass<>"Face" then
	Set Jpeg = Server.CreateObject("Persits.Jpeg")
	Jpeg.Open Server.MapPath(""&SaveFile&"")
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if SiteConfig("WatermarkType")=0 then
		Jpeg.Canvas.Font.Color = Replace(SiteConfig("WatermarkFontColor"),"#","&h")	'颜色
		Jpeg.Canvas.Font.Family = SiteConfig("WatermarkFontFamily")  		'字体
		Jpeg.Canvas.Font.size = SiteConfig("WatermarkFontSize")			'大小
		Jpeg.Canvas.Font.Bold = CBool(SiteConfig("WatermarkFontIsBold"))	'是否加粗

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

		Jpeg.Canvas.DrawImage PositionWidth, PositionHeight, Jpeg2, 1, &HFFFFFF	'透明度, 透明颜色
	end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Jpeg.Save Server.MapPath(""&SaveFile&"")
	Set Jpeg = Nothing
end if

%>