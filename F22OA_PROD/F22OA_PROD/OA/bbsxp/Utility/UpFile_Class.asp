<%
'BBSXP�ļ��ϴ���
Class UpFile_Class

Dim Form,File
Private	oUpFileStream	'�ϴ���������

'�����
Private Sub Class_Terminate
	'�������������
	Form.RemoveAll
	Set Form = Nothing
	File.RemoveAll
	Set File = Nothing
	oUpFileStream.Close
	Set oUpFileStream = Nothing
End Sub

'�����ϴ�������
Public Sub GetData ()
	 '�������
	Dim RequestBinDate,sSpace,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo
	Dim sFormValue,sFileName
	Dim iFindStart,iFindEnd
	Dim iFormStart,iFormEnd,sFormName
	'���뿪ʼ
	Set Form = Server.CreateObject ("Scripting.Dictionary")
	Form.CompareMode = 1
	Set File = Server.CreateObject ("Scripting.Dictionary")
	File.CompareMode = 1
	Set tStream = Server.CreateObject ("ADODB.Stream")
	Set oUpFileStream = Server.CreateObject ("ADODB.Stream")
	oUpFileStream.Type = 1
	oUpFileStream.Mode = 3
	oUpFileStream.Open 
	oUpFileStream.Write Request.BinaryRead (Request.TotalBytes)
	oUpFileStream.Position = 0
	RequestBinDate = oUpFileStream.Read 
	iFormEnd = oUpFileStream.Size
	bCrLf = ChrB (13) & ChrB (10)
	'ȡ��ÿ����Ŀ֮��ķָ���
	sSpace = MidB (RequestBinDate,1, InStrB (1,RequestBinDate,bCrLf)-1)
	iStart = LenB(sSpace)
	iFormStart = iStart+2
	'�ֽ���Ŀ
	Do
		iInfoEnd = InStrB (iFormStart,RequestBinDate,bCrLf & bCrLf)+3
		tStream.Type = 1
		tStream.Mode = 3
		tStream.Open
		oUpFileStream.Position = iFormStart
		oUpFileStream.CopyTo tStream,iInfoEnd-iFormStart
		tStream.Position = 0
		tStream.Type = 2
		tStream.CharSet = "gb2312"
		sInfo = tStream.ReadText			
		'ȡ�ñ���Ŀ����
		iFormStart = InStrB (iInfoEnd,RequestBinDate,sSpace)-1
		iFindStart = InStr (22,sInfo,"name=""",1)+6
		iFindEnd = InStr (iFindStart,sInfo,"""",1)
		sFormName = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
		'������ļ�
		If InStr (45,sInfo,"filename=""",1) > 0 Then
			Set oFileInfo = new FileInfo_Class
			'ȡ���ļ�����
			iFindStart = InStr (iFindEnd,sInfo,"filename=""",1)+10
			iFindEnd = InStr (iFindStart,sInfo,""""&vbCrLf,1)
			sFileName = Trim(Mid(sinfo,iFindStart,iFindEnd-iFindStart))
			oFileInfo.FileName = GetFileName(sFileName)
			oFileInfo.FilePath = GetFilePath(sFileName)
			oFileInfo.FileExt = GetFileExt(sFileName)
			iFindStart = InStr (iFindEnd,sInfo,"Content-Type: ",1)+14
			iFindEnd = InStr (iFindStart,sInfo,vbCr)
			oFileInfo.FileMIME = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
			oFileInfo.FileStart = iInfoEnd
			oFileInfo.FileSize = iFormStart -iInfoEnd -2
			oFileInfo.FormName = sFormName
			file.add sFormName,oFileInfo
		else
		'����Ǳ���Ŀ
			tStream.Close
			tStream.Type = 1
			tStream.Mode = 3
			tStream.Open
			oUpFileStream.Position = iInfoEnd 
			oUpFileStream.CopyTo tStream,iFormStart-iInfoEnd-2
			tStream.Position = 0
			tStream.Type = 2
			tStream.CharSet = "gb2312"
			sFormValue = tStream.ReadText
			If Form.Exists (sFormName) Then
				Form (sFormName) = Form (sFormName) & ", " & sFormValue
				else
				Form.Add sFormName,sFormValue
			End If
		End If
		tStream.Close
		iFormStart = iFormStart+iStart+2
		'������ļ�β�˾��˳�
	Loop Until (iFormStart+2) >= iFormEnd 
	RequestBinDate = ""
	Set tStream = Nothing
End Sub

'���浽�ļ�,�Զ������Ѵ��ڵ�ͬ���ļ� by yuzi
Public Function SaveToFile(Item,Path)
	Set oFileStream = CreateObject ("ADODB.Stream")
	oFileStream.Type = 1
	oFileStream.Open
	oUpFileStream.Position = File(Item).FileStart
	oUpFileStream.CopyTo oFileStream,File(Item).FileSize
	oFileStream.SaveToFile Path,2
	oFileStream.Close
	Set oFileStream = Nothing
End Function


'ȡ���ļ�����
Public Function FileData(Item)
	oUpFileStream.Position = File(Item).FileStart
	FileData = oUpFileStream.Read (File(Item).FileSize)
End Function


'ȡ���ļ�·��
Public function GetFilePath(FullPath)
  If FullPath <> "" Then
    GetFilePath = Left(FullPath,InStrRev(FullPath, "\"))
    Else
    GetFilePath = ""
  End If
End function

'ȡ���ļ���
Public Function GetFileName(FullPath)
  If FullPath <> "" Then
    GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
    Else
    GetFileName = ""
  End If
End function

'ȡ���ļ��ĺ�׺��
Public Function GetFileExt(FullPath)
  If FullPath <> "" Then
    GetFileExt = LCase(Mid(FullPath,InStrRev(FullPath, ".")+1))
    Else
    GetFileExt = ""
  End If
End function

End Class


'�ļ�������
Class FileInfo_Class
Dim FormName,FileName,FilePath,FileSize,FileMIME,FileStart,FileExt
End Class
%>
