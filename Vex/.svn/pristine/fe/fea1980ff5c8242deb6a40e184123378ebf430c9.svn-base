Attribute VB_Name = "A01_通用_Upgrade"
'本模块为VBA程序自动升级功能，一般无需更改,引用本模块并在Workbook_Open事件中加入宏Upgrade 并向管理员注册即可实现自动升级
'Public Sub Workbook_Open()
'    Upgrade '检测版本升级
'End Sub
' 编程:王秀宝  2013-06-24
'
'为了保持通用，请将下列函数GetLocalAppVersion粘贴到A02_配置模块中并按实际修改内容

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




Function CheckUrl(URL As String) As Boolean    '检测网络文件是否存在
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


Sub Upgrade()    '下载升级EXCEL的主程序
    Dim XMLStr As String
    On Error GoTo E
    XMLStr = "<Interface WSID=""d08c9759-f871-4f35-9ee4-88013da25837""" & _
             " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
             "<XML><ROOT><OPTYPE>GET</OPTYPE><LIST><ROW><CONDITION>AppName='" & GetAppName() & "'</CONDITION></ROW></LIST></ROOT></XML></Interface>"
    
    XMLStr = Replace(XMLStr, "'", "\u0027")  '将SQL查询条件中的逗号替换
    XMLStr = GetWsrrRlt(XMLStr)

'    MsgBox XMLStr

    Dim AppLastVersion As String, Upgrader As String, UpgradeTime As String, UpgradeLog As String, DownLoadUrl As String, ForceUpgrade As String
    Dim LocalAppVersion As String
    
    AppLastVersion = GetValueFromXml(XMLStr, "AppLastVersion")    '最新版本
    Upgrader = GetValueFromXml(XMLStr, "Upgrader")                '更新人
    UpgradeTime = GetValueFromXml(XMLStr, "UpgradeTime")          '更新日期
    UpgradeLog = Replace(GetValueFromXml(XMLStr, "UpgradeLog"), "\\n", Chr(10))    '更新日志
    DownLoadUrl = GetValueFromXml(XMLStr, "DownLoadUrl")                          '更新下载地址
    ForceUpgrade = GetValueFromXml(XMLStr, "ForceUpgrade")                        '是否强制升级,不等于0强制升级

    
    '获取本地版本号
    LocalAppVersion = GetLocalAppVersion()
    If LocalAppVersion >= AppLastVersion Or AppLastVersion = "" Then
        '本地版本大于等于服务器版本或获取服务器版本失败，退出升级
        Exit Sub
    End If
    
    If ForceUpgrade <> 0 Then   '不等于0强制升级
        MsgBox "检测到ExcelAppStore上有 " & GetAppName() & " 的新版本发布,版本号: " & AppLastVersion & Chr(10) & "更新时间:" & UpgradeTime & Chr(10) & "更新日志: " & Chr(10) & UpgradeLog & Chr(10) & "更新文件可能需要几分钟时间,点击确定按钮后开始更新...", vbOKOnly + vbInformation, "提示"
    Else
        If MsgBox("检测到ExcelAppStore上有 " & GetAppName() & " 的新版本发布,版本号: " & AppLastVersion & Chr(10) & "更新时间:" & UpgradeTime & Chr(10) & "更新日志: " & Chr(10) & UpgradeLog & Chr(10) & "更新文件可能需要几分钟时间,点击确定按钮后开始更新...", vbYesNo + vbInformation, "提示") = vbNo Then Exit Sub
    End If
    
    If CheckUrl(DownLoadUrl) = False Then
        MsgBox "新版本Excel文件不存在，请与系统管理员联系!", vbOKOnly + vbInformation, "更新提示"
        Exit Sub    '如果没有在升级网址没有找到当前版本则结束升级
    End If
    
    '开始升级
    Dim LocalAppFileName As String, LocalAppPathStr As String, DownOk As Long, tmpFileName As String
    LocalAppFileName = ThisWorkbook.Name       '这是原文件名
    LocalAppPathStr = ThisWorkbook.FullName    '文件存放路径
    tmpFileName = ThisWorkbook.Path & "\Upgrade_" & ThisWorkbook.Name   '升级临时文件
    
    
    DownOk = URLDownloadToFile(0, DownLoadUrl, tmpFileName, 0, 0)    '下载的文件以原本地文件命名
    Call DeleteUrlCacheEntry(DownLoadUrl)                            '删除缓存中下载的新程序文件
    If DownOk = 0 Then
        Application.DisplayAlerts = False
        ThisWorkbook.Saved = True
        ThisWorkbook.ChangeFileAccess xlReadOnly   '设为只读后才可对原旧文件进行操作
        Name LocalAppPathStr As ThisWorkbook.Path & "\Backup_" & ThisWorkbook.Name
        Name tmpFileName As LocalAppPathStr
        
        '删除旧文件
        Kill ThisWorkbook.Path & "\Backup_" & ThisWorkbook.Name
        
        MsgBox "ExcelApp升级成功，请重新打开文件 " & LocalAppPathStr & " 执行相关操作!", vbInformation, "提示"
        Application.DisplayAlerts = True
        
        ThisWorkbook.Close False '关闭文件
    End If
    
E:
    '升级失败强制退出
    ThisWorkbook.Close False '关闭文件
End Sub





