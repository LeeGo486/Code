Attribute VB_Name = "A01_ͨ��_Upgrade"
'��ģ��ΪVBA�����Զ��������ܣ�һ���������,���ñ�ģ�鲢��Workbook_Open�¼��м����Upgrade �������Աע�ἴ��ʵ���Զ�����
'Public Sub Workbook_Open()
'    Upgrade '���汾����
'End Sub
' ���:���㱦  2013-06-24
'
'Ϊ�˱���ͨ�ã��뽫���к���GetLocalAppVersionճ����A02_����ģ���в���ʵ���޸�����

Option Explicit

#If VBA7 Then
    #If Win64 Then
        Declare PtrSafe Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
        Declare PtrSafe Function DeleteUrlCacheEntry Lib "wininet" Alias "DeleteUrlCacheEntryA" (ByVal lpszUrlName As String) As Long
    #Else
        Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
        Declare Function DeleteUrlCacheEntry Lib "wininet" Alias "DeleteUrlCacheEntryA" (ByVal lpszUrlName As String) As Long
    #End If
#Else
    Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
    Declare Function DeleteUrlCacheEntry Lib "wininet" Alias "DeleteUrlCacheEntryA" (ByVal lpszUrlName As String) As Long
#End If




Function CheckUrl(URL As String) As Boolean    '��������ļ��Ƿ����
    On Error GoTo E
        Dim objHTTP As Object
        Set objHTTP = CreateObject("Microsoft.XMLHTTP")
        objHTTP.Open "GET", URL, False
        objHTTP.send ""
        If objHTTP.Status = 200 Then
            CheckUrl = True
        Else
            CheckUrl = False
        End If
        Set objHTTP = Nothing
        Exit Function
E:
    CheckUrl = False
    Set objHTTP = Nothing
End Function


Sub Upgrade()    '��������EXCEL��������
    Dim XMLStr As String
    On Error GoTo E
    XMLStr = "<Interface WSID=""d08c9759-f871-4f35-9ee4-88013da25837""" & _
             " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
             "<XML><ROOT><OPTYPE>GET</OPTYPE><LIST><ROW><CONDITION>AppName='" & GetAppName() & "'</CONDITION></ROW></LIST></ROOT></XML></Interface>"
    
    XMLStr = Replace(XMLStr, "'", "\u0027")  '��SQL��ѯ�����еĶ����滻
    XMLStr = GetWsrrRlt(XMLStr)

'    MsgBox XMLStr

    Dim AppLastVersion As String, Upgrader As String, UpgradeTime As String, UpgradeLog As String, DownLoadUrl As String, ForceUpgrade As String
    Dim LocalAppVersion As String
    
    AppLastVersion = GetValueFromXml(XMLStr, "AppLastVersion")    '���°汾
    Upgrader = GetValueFromXml(XMLStr, "Upgrader")                '������
    UpgradeTime = GetValueFromXml(XMLStr, "UpgradeTime")          '��������
    UpgradeLog = Replace(GetValueFromXml(XMLStr, "UpgradeLog"), "\\n", Chr(10))    '������־
    DownLoadUrl = GetValueFromXml(XMLStr, "DownLoadUrl")                          '�������ص�ַ
    ForceUpgrade = GetValueFromXml(XMLStr, "ForceUpgrade")                        '�Ƿ�ǿ������,������0ǿ������

    
    '��ȡ���ذ汾��
    LocalAppVersion = GetLocalAppVersion()
    If LocalAppVersion >= AppLastVersion Or AppLastVersion = "" Then
        '���ذ汾���ڵ��ڷ������汾���ȡ�������汾ʧ�ܣ��˳�����
        Exit Sub
    End If
    
    If ForceUpgrade <> 0 Then   '������0ǿ������
        MsgBox "��⵽ExcelAppStore���� " & GetAppName() & " ���°汾����,�汾��: " & AppLastVersion & Chr(10) & "����ʱ��:" & UpgradeTime & Chr(10) & "������־: " & Chr(10) & UpgradeLog & Chr(10) & "�����ļ�������Ҫ������ʱ��,���ȷ����ť��ʼ����...", vbOKOnly + vbInformation, "��ʾ"
    Else
        If MsgBox("��⵽ExcelAppStore���� " & GetAppName() & " ���°汾����,�汾��: " & AppLastVersion & Chr(10) & "����ʱ��:" & UpgradeTime & Chr(10) & "������־: " & Chr(10) & UpgradeLog & Chr(10) & "�����ļ�������Ҫ������ʱ��,���ȷ����ť��ʼ����...", vbYesNo + vbInformation, "��ʾ") = vbNo Then Exit Sub
    End If
    
    If CheckUrl(DownLoadUrl) = False Then
        MsgBox "�°汾Excel�ļ������ڣ�����ϵͳ����Ա��ϵ!", vbOKOnly + vbInformation, "������ʾ"
        Exit Sub    '���û����������ַû���ҵ���ǰ�汾���������
    End If
    
    '��ʼ����
    Dim LocalAppFileName As String, LocalAppPathStr As String, DownOk As Long, tmpFileName As String
    LocalAppFileName = ThisWorkbook.Name       '����ԭ�ļ���
    LocalAppPathStr = ThisWorkbook.FullName    '�ļ����·��
    tmpFileName = ThisWorkbook.Path & "\Upgrade_" & ThisWorkbook.Name   '������ʱ�ļ�
    
    
    DownOk = URLDownloadToFile(0, DownLoadUrl, tmpFileName, 0, 0)    '���ص��ļ���ԭ�����ļ�����
    Call DeleteUrlCacheEntry(DownLoadUrl)                            'ɾ�����������ص��³����ļ�
    If DownOk = 0 Then
        Application.DisplayAlerts = False
        ThisWorkbook.Saved = True
        ThisWorkbook.ChangeFileAccess xlReadOnly   '��Ϊֻ����ſɶ�ԭ���ļ����в���
        Name LocalAppPathStr As ThisWorkbook.Path & "\Backup_" & ThisWorkbook.Name
        Name tmpFileName As LocalAppPathStr
        
        'ɾ�����ļ�
        Kill ThisWorkbook.Path & "\Backup_" & ThisWorkbook.Name
        
        MsgBox "ExcelApp�����ɹ��������´��ļ� " & LocalAppPathStr & " ִ����ز���!", vbInformation, "��ʾ"
        Application.DisplayAlerts = True
        
        ThisWorkbook.Close False '�ر��ļ�
    End If
    
E:
    '����ʧ��ǿ���˳�
    ThisWorkbook.Close False '�ر��ļ�
End Sub





