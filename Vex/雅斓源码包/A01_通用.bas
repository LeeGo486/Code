Attribute VB_Name = "A01_通用"
''此模块为通用的方法，一般不变
Public IsLogin As Boolean
Public WinSessionId As String
#If VBA7 Then
    #If Win64 Then
        Public Declare PtrSafe Function CoCreateGuid Lib "ole32" (id As Any) As LongPtr
        Public Declare PtrSafe Function GetSystemMetrics Lib "user32" (ByVal nIndex As LongPtr) As LongPtr
        Public Declare PtrSafe Function EnumWindows Lib "user32" (ByVal lpEnumFunc As LongPtr, ByVal lParam As LongPtr) As LongPtr
        Public Declare PtrSafe Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As LongPtr, ByVal lpString As String, ByVal cch As LongPtr) As LongPtr
    #Else
        Public Declare Function CoCreateGuid Lib "ole32" (id As Any) As Long
        Public Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
        Public Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long
        Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
    #End If
#Else
    Public Declare Function CoCreateGuid Lib "ole32" (id As Any) As Long
    Public Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
    Public Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long
    Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
#End If

'枚举窗体
Public Function EnumWndProc(ByVal lhWnd As Long, ByVal lParam As Long) As Long  'EnumWindows 遍历窗口的回调函数
    Dim Title1 As String * 255                                                  '处理前窗口标题
    Dim Title2 As String                                                        '处理后窗口标题
    Call GetWindowText(lhWnd, Title1, 255&)                                     '获取窗口标题
    If (InStr(Title1, Chr(0&)) > 0&) Then
        Title2 = Left(Title1, InStr(Title1, Chr(0&)) - 1&)                      '处理空白字符
        If Len(Title2) > 0 And Title2 Like GetSessionWin & "????????-????-????-????-????????????*" Then                                                 '处理空字符
        WinSessionId = Right(Left(Title2, 16 + 36), 36)
    End If
End If
EnumWndProc = True                                                          '继续下一个
End Function
Function RunSqlInDSN(DSN As String, Uid As String, Password As String, SqlStr As String) As Boolean
    '将SQL语句传入ODBC进行执行
    RunSqlInDSN = False
    Dim conn As New ADODB.Connection
    conn.ConnectionString = DSN
    conn.Open conn.ConnectionString, Uid, Password
    
    On Error GoTo dspsql
    conn.Execute SqlStr
    conn.Close
    AddLog "成功：" & SqlStr
    RunSqlInDSN = True
    Exit Function
dspsql:
    AddLog "失败：" & SqlStr
End Function
Function RunSqlInSQL(SqlSrv As String, DB As String, Uid As String, Password As String, SqlStr As String) As Boolean
    '将SQL语句传入数据库进行执行
    RunSqlInSQL = False
    Dim conn As New ADODB.Connection
    conn.ConnectionString = "Driver={SQL Server};server=" & SqlSrv & ";UID=" & Uid & ";pwd=" & Password & ";database=" & DB & ""
    conn.Open conn.ConnectionString
    
    On Error GoTo dspsql
    conn.Execute SqlStr
    conn.Close
    AddLog "成功：" & SqlStr
    RunSqlInSQL = True
    Exit Function
dspsql:
    AddLog "失败：" & SqlStr
End Function
Function Msg(DspType As String, MsgType As VbMsgBoxStyle, SheetName As String, RangeName As String, Str1 As String)
    '提示，可以有单元格、MSGBOX、窗体多种
    If DspType = "MSGBOX" Then
        MsgBox Str1, DspType, "提示"
    End If
    
    If DspType = "Cell" Then
        AddEditRange SheetName, RangeName
        SetCellValueByRange SheetName, RangeName, Str1
    End If
    
    If DspType = "FORM" Then
        MsgForm.MsgTxt = Str1
        MsgForm.Show
    End If
    
End Function
Function GetNewGUID() As String
    '创建新的GUID，不含-
    Dim id(0 To 15) As Byte
    Dim Cnt As Long, Guid As String
    If CoCreateGuid(id(0)) = 0 Then
        For Cnt = 0 To 15
            GetNewGUID = GetNewGUID + IIf(id(Cnt) < 16, "0", "") + Hex$(id(Cnt))
        Next Cnt
    Else
        MsgBox "Error while creating GUID!"
    End If
End Function


Function CheckLogin_DB(Usr As String, Pwd As String) As Boolean
    '根据数据库来登录
    SetCellValueByRange "Main", "B1", ""
    Dim conn As New ADODB.Connection
    Dim Rst As ADODB.Recordset
    CheckLogin_DB = False
    If Pwd Like "*[*]*" Or Pwd Like "* or *" Then
        GoTo N
    End If
    conn.ConnectionString = "Driver={SQL Server};server=" & "asdfasdfasdf" & ";UID=" & "asdfasd" & ";pwd=" & "asdfasdfasdfasdf" & ";database=" & "asdfasd" & ""
    conn.Open conn.ConnectionString
    Set Rst = New ADODB.Recordset
    Rst.CursorType = adOpenDynamic
    Rst.LockType = adLockPessimistic
    Rst.Open "select [Name] from mdm_Employees  where [Name]='" & Usr & "' and SSO_Password='" & Pwd & "'", conn, 3, 3
    '', , , adCmdTable
    If Rst.RecordCount > 0 Then
        CheckLogin_DB = True
        SetCellValueByRange "Main", "B1", Usr
        SetValueByName "USR", Usr
    Else
        CheckLogin_DB = False
    End If
    Rst.Close
    conn.Close
    
N:
    
End Function

Function AddEditRange(SheetName As String, RangeStr As String)
    '将某工作表、某区域设置为可编辑区域
    SetEditRange "SHEET", SheetName, RangeStr, "ADD"
End Function

Function SetEditRange(ObjType As String, ObjName As String, RangeStr As String, SetType As String)
    '将某工作表、某区域设置为可编辑区域,objType(SHEET或者TABLE),SetType(ADD增加或SET覆盖)
    Dim SheetName As String, StyleRange As Range
    If UCase(ObjType) = "SHEET" Then
        SheetName = ObjName
        ObjType = "SHEET"
    End If
    
    If UCase(ObjType) = "TABLE" Then
        SheetName = GetSheetNameOfListObject(ObjName)
        ObjType = "TABLE"
    End If
    
    If UCase(SetType) = "ADD" Then
        SetType = "ADD"
    Else
        SetType = "SET"
    End If
    Set StyleRange = Sheets("Main").Range("E1")
    Dim IsSheetProtect As Boolean, HaveRange As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    With Sheets(SheetName).Range(RangeStr)
        .Interior.Pattern = xlSolid
        .Interior.PatternColorIndex = xlAutomatic
        .Interior.ThemeColor = xlThemeColorDark1
        .Interior.TintAndShade = 0
        .Interior.PatternTintAndShade = 0
    End With
    
    For Each RG In Sheets(SheetName).Protection.AllowEditRanges
        If SetType = "SET" Then
            RG.Delete
        End If
        
    Next
    
B:
    
    If ObjType = "SHEET" Then
        Sheets(SheetName).Protection.AllowEditRanges.Add Title:="工作表区域" & GetNewGUID(), Range:=Range(RangeStr)
    End If
    
    If ObjType = "TABLE" Then
        Sheets(SheetName).Protection.AllowEditRanges.Add Title:=ObjName & "表区域" & GetNewGUID(), Range:=Range(RangeStr)
    End If
    
N:
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function
Function AddEditRangeByHead(TableName As String, RowId As Long, HeadStr As String)
    '将列表对象某行某字段列表，以【】隔开，设置为可编辑区域
    Dim SheetName As String
    SheetName = GetSheetNameOfListObject(TableName)
    
    Dim ColumnStr As String, ColumnStrNew As String
    Dim FromI As Long, ToI As Long
    FromI = InStr(1, HeadStr, "【")
    ToI = InStr(1, HeadStr, "】")
    ColumnStrNew = ""
    Do While FromI > 0 And ToI > 0
        FromI = FromI + 1
        ToI = ToI - 1
        If FromI > ToI Then ColumnStr = ""
        If FromI <= ToI Then ColumnStr = Right(Left(HeadStr, ToI), ToI - FromI + 1)
        ColumnStr = Replace(ColumnStr, " ", "")
        If ColumnStr <> "" And IsInTableColumns(TableName, ColumnStr) Then
            ColumnStrNew = ColumnStrNew & GetRangeStrByHead(TableName, RowId, ColumnStr) & ","
            'MsgBox ColumnStrNew
        End If
        
        HeadStr = Replace(HeadStr, "【" & ColumnStr & "】", "")
        
        FromI = InStr(1, HeadStr, "【")
        ToI = InStr(1, HeadStr, "】")
    Loop
    
    If ColumnStrNew <> "" Then AddEditRange SheetName, Left(ColumnStrNew, Len(ColumnStrNew) - 1)
    
End Function

Function ClearEditRange(SheetName As String)
    '清除某工作表的所有可编辑区域
    If Sheets(SheetName).Protection.AllowEditRanges.Count = 0 Then Exit Function
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Dim Counti As Long
    For Each A In Sheets(SheetName).Protection.AllowEditRanges
        On Error GoTo N
        A.Delete
    Next
N:
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function

Function ProtectSheet(SheetName As String, ToProtect As Boolean)
    '保护工作表
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect <> ToProtect Then
        If ToProtect Then
            Sheets(SheetName).Protect Password:=GetPwd, AllowFormattingCells:=True, AllowFormattingColumns:=True
        Else
            Sheets(SheetName).Unprotect Password:=GetPwd
        End If
    End If
End Function

Function ProtectSheetWithEnableAllowFiltering(SheetName As String, ToProtect As Boolean)
    '保护工作表,允许筛选功能
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect <> ToProtect Then
        If ToProtect Then
            Sheets(SheetName).Protect Password:=GetPwd, AllowFormattingCells:=True, AllowFormattingColumns:=True, AllowFiltering:=True
        Else
            Sheets(SheetName).Unprotect Password:=GetPwd
        End If
    End If
End Function

Function ProtectBook(ToProtect As Boolean)
    '保护工作薄
    Dim IsBookProtect As Boolean
    IsBookProtect = GetBookIsProtect()
    If IsBookProtect <> ToProtect Then
        If ToProtect Then
            ThisWorkbook.Protect Password:=GetPwd
        Else
            ThisWorkbook.Unprotect Password:=GetPwd
        End If
    End If
End Function
Function GenSql(TblName As String, RowId As Long, SqlStr As String) As String
    '将以【字段名】表述的SQL语句转换成数据库理解的格式
    Dim ColumnStr As String, ColumnStrNew As String, SheetName As String
    
    Dim FromI As Long, ToI As Long
    SheetName = GetSheetNameOfListObject(TblName)
    FromI = InStr(1, SqlStr, "【")
    ToI = InStr(1, SqlStr, "】")
    Do While FromI > 0 And ToI > 0
        FromI = FromI + 1
        ToI = ToI - 1
        If FromI > ToI Then ColumnStr = ""
        If FromI <= ToI Then ColumnStr = Right(Left(SqlStr, ToI), ToI - FromI + 1)
        ColumnStr = Replace(ColumnStr, " ", "")
        If ColumnStr <> "" Then
            
            If Left(ColumnStr, 6) = "(Date)" And Len(ColumnStr) > 6 Then
                ColumnStrNew = Right(ColumnStr, Len(ColumnStr) - 6)
                If Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Value = 0 Then
                    SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "NULL")
                Else
                    SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "'" & Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Value & "'")
                End If
            End If
            
            If Left(ColumnStr, 8) = "(String)" And Len(ColumnStr) > 8 Then
                ColumnStrNew = Right(ColumnStr, Len(ColumnStr) - 8)
                SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "'" & Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Value & "'")
            End If
            
            If Left(ColumnStr, 8) = "(Number)" And Len(ColumnStr) > 8 Then
                ColumnStrNew = Right(ColumnStr, Len(ColumnStr) - 8)
                If Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Value = "" Then
                    SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "NULL")
                Else
                    SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "'" & Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Value & "'")
                End If
            End If
            
            If Left(ColumnStr, 9) = "(Comment)" And Len(ColumnStr) > 9 Then
                ColumnStrNew = Right(ColumnStr, Len(ColumnStr) - 9)
                On Error GoTo A
                SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "'" & Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Comment.Text & "'")
A:
                SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "''")
                
            End If
            
            
            If Left(ColumnStr, 8) <> "(Number)" And Left(ColumnStr, 8) <> "(String)" And Left(ColumnStr, 6) <> "(Date)" And Left(ColumnStr, 9) <> "(Comment)" And Len(ColumnStr) > 1 Then
                ColumnStrNew = ColumnStr
                SqlStr = Replace(SqlStr, "【" & ColumnStr & "】", "'" & Sheets(SheetName).Cells(RowId, Range(TblName & "[[" & ColumnStrNew & "]]").Column).Value & "'")
            End If
            
        End If
        
        FromI = InStr(1, SqlStr, "【")
        ToI = InStr(1, SqlStr, "】")
    Loop
    
    GenSql = SqlStr
End Function
Function CopyValueByHeadFromUp(TableName As String, RowId As Long, str As String)
    '从上面一行复制列表对象某行某字段值
    Dim SheetName As String, ColumnId As Long
    SheetName = GetSheetNameOfListObject(TableName)
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    ColumnId = Range(TableName & "[[" & str & "]]").Column
    SetCellValueByRCId SheetName, RowId, ColumnId, Sheets(SheetName).Cells(RowId - 1, ColumnId).Value
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function

Function GetValueByHead(TableName As String, RowId As Long, str As String) As String
    '根据列表对象某行、某字段，获取值；
        GetValueByHead = Sheets(GetSheetNameOfListObject(TableName)).Cells(RowId, Range(TableName & "[[" & str & "]]").Column).Value
    ''cells().Value=
End Function
Function SetValueByHead(TableName As String, RowId As Long, str As String, Val As String)
    '设置列表对象某行某字段的值
    Dim SheetName As String, ColumnId As Long
    SheetName = GetSheetNameOfListObject(TableName)
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    ColumnId = Range(TableName & "[[" & str & "]]").Column
    SetCellValueByRCId SheetName, RowId, ColumnId, Val
    If IsSheetProtect Then ProtectSheet SheetName, True
    
    ''cells().Value=
End Function

Function GetRangeStrByHead(TableName As String, RowId As Long, str As String) As String
    '根据列表对象和行号、字段名获取区域符号；当ROWID为0时，获取整个；>0时，获取单元格
    Dim col As Long
    Dim MinRowId As Long, MaxRowId As Long, RangeStr As String, ColumnName As String
    MinRowId = GetRowId(TableName, "MIN")
    MaxRowId = GetRowId(TableName, "MAX")
    col = Range(TableName & "[[" & str & "]]").Column
    ColumnName = GetColumnNameById(col)
    If RowId <= 0 Then
        GetRangeStrByHead = ColumnName & MinRowId & ":" & ColumnName & MaxRowId
    Else
        GetRangeStrByHead = ColumnName & RowId
    End If
End Function
Function GetRangeStrByRow(TableName As String, RowId As Long) As String
    '根据列表对象和行号获取区域符号；当ROWID为0时，获取整个；>0时，获取单元格
    Dim col As Long, I As Long
    I = 0
    Dim ColumnName As String, FCol As String
    
    If RowId <= 0 Then GetRangeStrByRow = Range(TableName & "[#headers]").Cells(1, 1).ListObject.DataBodyRange.Address()
    If RowId > 0 Then
        For Each cl In Range(TableName & "[#headers]")
            I = I + 1
            col = cl.Column
            ColumnName = GetColumnNameById(col)
            If I = 1 Then FCol = ColumnName & RowId
            If I > 1 Then GetRangeStrByRow = FCol & ":" & ColumnName & RowId
            
        Next
    End If
    
End Function

Function GetColumnNameById(ColumnId As Long) As String
    '根据列号，获取列的字母
    GetColumnNameById = GetSheetColumnNameByAddress(Cells(1, ColumnId).Address)
End Function

Function RefreshTable(TblName As String)
    '刷新列表对象
    ProtectSheet GetSheetNameOfListObject(TblName), False
    Range(TblName & "[[#ALL]]").ListObject.QueryTable.Refresh BackgroundQuery:=False
    ProtectSheet GetSheetNameOfListObject(TblName), True
End Function
Function CreateTableForSql(TableName As String, SqlSrv As String, Uid As String, Pwd As String, DB As String, SheetName As String, RangeStr As String, SqlStr As String, Unlink As Boolean)
    '根据SQL语句和未加密的密码创建列表对象
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Sheets(SheetName).Activate
    With Sheets(SheetName).ListObjects.Add(SourceType:=0, Source:=Array( _
        "OLEDB;Provider=SQLOLEDB.1;Password=" & Pwd & ";Persist Security Info=True;User ID=" & Uid & ";Data Source=" & SqlSrv & ";Use Procedure for Prepar" _
        , _
        "e=1;Auto Translate=True;Packet Size=4096;  Use Encryption for Data=False;Tag with column collation wh" _
        , "en possible=False;Initial Catalog=" & DB), Destination:=Range(RangeStr)). _
        QueryTable
        .CommandType = xlCmdSql
        .CommandText = SqlStr
        .RowNumbers = False
        .FillAdjacentFormulas = False
        .PreserveFormatting = True
        .RefreshOnFileOpen = False
        .BackgroundQuery = True
        .RefreshStyle = xlInsertDeleteCells
        .SavePassword = False
        .SaveData = True
        .AdjustColumnWidth = True
        .RefreshPeriod = 0
        .PreserveColumnInfo = True
        .SourceConnectionFile = _
        "C:\Users\Administrator\Documents\我的数据源\" & SqlSrv & " " & DB & ".odc"
        .ListObject.DisplayName = TableName
        .Refresh BackgroundQuery:=False
    End With
    If Unlink Then Sheets(SheetName).ListObjects(TableName).Unlink
    Sheets(SheetName).ListObjects(TableName).TableStyle = "TableStyleMedium23"
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function

Function GetValueFromSQL(SqlSrv As String, Uid As String, Pwd As String, DB As String, SqlStr As String, FieldName As String) As String
    Dim conn As New ADODB.Connection
    Dim Rst As ADODB.Recordset
    Dim CompanyDropList As String
    CompanyDropList = ""
    conn.ConnectionString = "Driver={SQL Server};server=" & SqlSrv & ";UID=" & Uid & _
    ";pwd=" & Pwd & ";database=" & DB & ""
    conn.Open conn.ConnectionString
    Set Rst = New ADODB.Recordset
    Rst.CursorType = adOpenDynamic
    Rst.LockType = adLockPessimistic
    Rst.Open SqlStr, conn, 3, 3
    '', , , adCmdTable
    If Rst.RecordCount > 0 Then
        Rst.MoveFirst
        GetValueFromSQL = Rst.Fields(FieldName)
    End If
    Rst.Close
    conn.Close
    
N:
End Function
Function CreateTableBySession(TableName As String, SystemName As String, Envo As String, Uid As String, Pwd As String, SheetName As String, RangeStr As String, SqlStr As String, Unlink As Boolean)
    '根据未加密的密码和SQL创建列表对象
    Dim SqlSrv As String, DB As String, XMLStr As String
    XMLStr = GetDBInfo(SystemName, Envo, Uid, Pwd)
    Uid = GetValueFromXml(XMLStr, "DB_USERID")
    Pwd = GetValueFromXml(XMLStr, "DB_PASSWORD")
    SqlSrv = GetValueFromXml(XMLStr, "IP")
    DB = GetValueFromXml(XMLStr, "DBNAME")
    CreateTableForSql TableName, SqlSrv, Uid, Pwd, DB, SheetName, RangeStr, SqlStr, Unlink
End Function

Function FreezeCell(SheetName As String, CellStr As String, isFreeze As Boolean)
    '冻结窗体
    Dim IsSheetProtect As Boolean, IsSheetVisible As Boolean, CurSheetName As String
    IsSheetProtect = GetSheetIsProtect(SheetName)
    IsSheetVisible = GetSheetIsVisible(SheetName)
    CurSheetName = ActiveSheet.Name
    If IsSheetVisible Then HideSheet SheetName, False
    If IsSheetProtect Then ProtectSheet SheetName, False
    Sheets(SheetName).Activate
    
    Sheets(SheetName).Range(CellStr).Select
    If isFreeze Then ActiveWindow.FreezePanes = False
    ActiveWindow.FreezePanes = isFreeze
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    Sheets(CurSheetName).Activate
End Function

Function CopyCellFormat(SrcSheetName As String, SrcRangeStr As String, DstRange As Range)
    '复制单元格格式，底色和边框
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    With DstRange.Interior
        .Pattern = Sheets(SrcSheetName).Range(SrcRangeStr).Interior.Pattern
        .PatternColorIndex = Sheets(SrcSheetName).Range(SrcRangeStr).Interior.PatternColorIndex
        .Color = Sheets(SrcSheetName).Range(SrcRangeStr).Interior.Color
        .TintAndShade = Sheets(SrcSheetName).Range(SrcRangeStr).Interior.TintAndShade
        .PatternTintAndShade = Sheets(SrcSheetName).Range(SrcRangeStr).Interior.PatternTintAndShade
    End With
    
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function CopyCellFontFormat(SrcSheetName As String, SrcRangeStr As String, DstRange As Range)
    '复制字体格式
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    With DstRange.Font
        .Name = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Name
        .Size = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Size
        .Strikethrough = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Strikethrough
        .Superscript = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Superscript
        .Subscript = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Subscript
        .OutlineFont = Sheets(SrcSheetName).Range(SrcRangeStr).Font.OutlineFont
        .Shadow = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Shadow
        .Underline = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Underline
        '        .ThemeColor = Sheets(SrcSheetName).Range(SrcRangeStr).Font.ThemeColor
        .TintAndShade = Sheets(SrcSheetName).Range(SrcRangeStr).Font.TintAndShade
        .ThemeFont = Sheets(SrcSheetName).Range(SrcRangeStr).Font.ThemeFont
        .Color = Sheets(SrcSheetName).Range(SrcRangeStr).Font.Color
    End With
    If IsSheetProtect Then ProtectSheet SheetName, True
    
    
End Function
Function CopyIconSetFormat(SrcSheetName As String, SrcRangeStr As String, DstRange As Range)
    '复制图标条件格式
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    DstRange.FormatConditions.AddIconSetCondition
    DstRange.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With DstRange.FormatConditions(1)
        .ReverseOrder = False
        .ShowIconOnly = False
        .IconSet = Sheets(SrcSheetName).Range(SrcRangeStr).FormatConditions(1).IconSet
        ''ActiveWorkbook.IconSets (xl4TrafficLights)
    End With
    With DstRange.FormatConditions(1).IconCriteria(2)
        .Type = xlConditionValuePercent
        .Value = 25
        .Operator = 7
    End With
    With DstRange.FormatConditions(1).IconCriteria(3)
        .Type = xlConditionValuePercent
        .Value = 50
        .Operator = 7
    End With
    With DstRange.FormatConditions(1).IconCriteria(4)
        .Type = xlConditionValuePercent
        .Value = 75
        .Operator = 7
    End With
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function SetIconSetFormat_xl4TrafficLights(DstRange As Range)
    '设置目标区域的条件格式为信号灯
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    DstRange.FormatConditions.AddIconSetCondition
    DstRange.FormatConditions(DstRange.FormatConditions.Count).SetFirstPriority
    With DstRange.FormatConditions(1)
        .ReverseOrder = False
        .ShowIconOnly = False
        .IconSet = ActiveWorkbook.IconSets(xl4TrafficLights)
    End With
    With DstRange.FormatConditions(1).IconCriteria(2)
        .Type = xlConditionValuePercent
        .Value = 25
        .Operator = 7
    End With
    With DstRange.FormatConditions(1).IconCriteria(3)
        .Type = xlConditionValuePercent
        .Value = 50
        .Operator = 7
    End With
    With DstRange.FormatConditions(1).IconCriteria(4)
        .Type = xlConditionValuePercent
        .Value = 75
        .Operator = 7
    End With
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function


Function SetValidationStr(DstRange As Range, VlStr As String)
    '设置目标区域的值，下拉必须为选定的文本
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    With DstRange.Validation
        .Delete
        If VlStr <> "" Then
            .Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, Operator:= _
            xlBetween, Formula1:=VlStr
            .IgnoreBlank = True
            .InCellDropdown = True
            .InputTitle = ""
            .ErrorTitle = ""
            .InputMessage = ""
            .ErrorMessage = ""
            .IMEMode = xlIMEModeNoControl
            .ShowInput = True
            .ShowError = True
        End If
    End With
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function

Function SetValidationDate(DstRange As Range)
    '设置目标区域的值，必须为日期
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    With DstRange.Validation
        .Delete
        .Add Type:=xlValidateDate, AlertStyle:=xlValidAlertStop, Operator:= _
        xlGreaterEqual, Formula1:=CStr(Date)
        .IgnoreBlank = True
        .InCellDropdown = True
        .InputTitle = ""
        .ErrorTitle = ""
        .InputMessage = ""
        .ErrorMessage = ""
        .IMEMode = xlIMEModeNoControl
        .ShowInput = True
        .ShowError = True
    End With
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function
Function SetValidationNumber(DstRange As Range)
    '设置目标区域的值，必须为数字
    Dim SheetName As String
    SheetName = DstRange.Parent.Name
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    With DstRange.Validation
        .Delete
        .Add Type:=xlValidateDecimal, AlertStyle:=xlValidAlertStop, Operator _
        :=xlGreaterEqual, Formula1:="0"
        .IgnoreBlank = True
        .InCellDropdown = True
        .InputTitle = ""
        .ErrorTitle = ""
        .InputMessage = ""
        .ErrorMessage = ""
        .IMEMode = xlIMEModeNoControl
        .ShowInput = True
        .ShowError = True
    End With
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
    
End Function
Function CheckValidation(Val As String, MsgColumn As String, DataType As String, IsNotNull As Boolean, IsWarnning As Boolean) As Boolean
    '检查某个值，是否符合格式、是否能为空，并给与不同的提示
    CheckValidation = True
    ''Dim val As String
    Val = Replace(Val, " ", "")
    
    If DataType = "日期" Then
        If IsDate(Val) = False And Val <> "" Then
            If IsWarnning Then MsgBox MsgColumn & "必须为日期格式！            ", vbCritical, "提示"
            CheckValidation = False
            GoTo E
        End If
        
        If Val = "" And IsNotNull Then
            If IsWarnning Then MsgBox MsgColumn & "必须为日期格式，并且必须填写！            ", vbCritical, "提示"
            CheckValidation = False
            GoTo E
        End If
        
    End If
    
    
    If DataType = "数字" Then
        If IsNumeric(Val) = False And Val <> "" Then
            If IsWarnning Then MsgBox MsgColumn & "必须为数字格式！            ", vbCritical, "提示"
            CheckValidation = False
            GoTo E
        End If
        
        If Val = "" And IsNotNull Then
            If IsWarnning Then MsgBox MsgColumn & "必须为数字格式，并且必须填写！            ", vbCritical, "提示"
            CheckValidation = False
            GoTo E
        End If
        
    End If
    
    
    If DataType = "文本" Then
        If Val = "" And IsNotNull Then
            If IsWarnning Then MsgBox MsgColumn & "必须为文本格式，并且必须填写！            ", vbCritical, "提示"
            CheckValidation = False
            GoTo E
        End If
        
    End If
    
E:
    
End Function
Function CheckValidationByHead _
    (TblName As String, RowId As Long, ColumnStr As String, _
    DataType As String, IsNotNull As Boolean, IsWarnning As Boolean, IsSetFocus) As Boolean
    '根据列表对象、字段名、行号来检查数据
    Dim SheetName As String
    SheetName = GetSheetNameOfListObject(TblName)
    CheckValidationByHead = CheckValidation(GetValueByHead(TblName, RowId, ColumnStr), _
    ColumnStr, DataType, IsNotNull, IsWarnning)
    
    If CheckValidationByHead = False And IsSetFocus Then
        Sheets(SheetName).Range(GetRangeStrByHead(TblName, RowId, ColumnStr)).Select
    End If
    
End Function
Function GetSheetNameOfListObject(TblName As String) As String
    '根据列表对象，获取工作表名称
    For Each S In ThisWorkbook.Sheets
        If S.ListObjects.Count > 0 Then
            For Each L In Sheets(S.Name).ListObjects
                If UCase(L.Name) = UCase(TblName) Then
                    GetSheetNameOfListObject = S.Name
                    GoTo E
                End If
            Next
        End If
    Next
    
E:
    
End Function
Function SetCommentByHead(TblName As String, RowId As Long, ColumnStr As String, CommentStr As String)
    '根据列表对象、字段名、行号来设置批注
    Dim SheetName As String
    SheetName = GetSheetNameOfListObject(TblName)
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    If Replace(CommentStr, " ", "") <> "" Then
        Sheets(SheetName).Range(GetRangeStrByHead_IT_TASK_MGR(RowId, ColumnStr)).ClearComments
        Sheets(SheetName).Range(GetRangeStrByHead_IT_TASK_MGR(RowId, ColumnStr)).AddComment
        Sheets(SheetName).Range(GetRangeStrByHead_IT_TASK_MGR(RowId, ColumnStr)).Comment.Visible = False
        Sheets(SheetName).Range(GetRangeStrByHead_IT_TASK_MGR(RowId, ColumnStr)).Comment.Text Text:=CommentStr
        Sheets(SheetName).Range(GetRangeStrByHead_IT_TASK_MGR(RowId, ColumnStr)).Comment.Shape.ScaleWidth 2, msoFalse, msoScaleFromTopLeft
    Else
        Sheets(SheetName).Range(GetRangeStrByHead_IT_TASK_MGR(RowId, ColumnStr)).ClearComments
    End If
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function

Function AddLog(LogStr As String)
    '向LOG工作表增加日志
    Dim RowId As Long
    ProtectSheet "Log", False
    If Sheets("Log").Range("B1").Value = "" Then SetCellValueByRange "LOG", "B1", 2
    RowId = Sheets("Log").Range("B1").Value + 1
    Msg "CELL", vbOKOnly, "LOG", "B" & RowId, LogStr
    SetCellValueByRange "LOG", "B" & RowId, LogStr
    SetCellValueByRange "LOG", "A" & RowId, Date & " " & Time
    ProtectSheet "Log", False
    Sheets("Log").Range("A" & RowId).NumberFormatLocal = "yyy-mm-dd hh:mm:ss"
    SetCellValueByRange "LOG", "B1", CStr(RowId)
    ProtectSheet "Log", True
End Function
Function ClearLog()
    '清楚LOG工作表的内容
    ProtectSheet "Log", False
    If Sheets("Log").Range("B1").Value = "" Then SetCellValueByRange "LOG", "B1", 2
    If Sheets("Log").Range("B1").Value <= 2 Then SetCellValueByRange "LOG", "B1", 2
    If Sheets("Log").Range("B1").Value > 2 Then
        For Each rw In Sheets("LOG").Rows("3:" & Sheets("LOG").Range("B1").Value).Rows
            rw.Delete
        Next
        'Sheets("LOG").Rows("3:" & Sheets("LOG").range("B1").Value).Select
        'Selection.Delete Shift:=xlUp
        SetCellValueByRange "LOG", "B1", 2
    End If
    ProtectSheet "Log", True
End Function
Function GetSelectionMinRowid() As Long
    '获取选定区域的最小行号
    GetSelectionMinRowid = Selection.Cells(1, 1).Row
End Function
Function GetSelectionMaxRowid() As Long
    '获取选定区域的最大行号
    GetSelectionMaxRowid = Selection.Cells(1, 1).Row + Selection.Rows.Count - 1
End Function
Function SetCellValueByRange(SheetName As String, RangeStr As String, Val As String) As Long
    '根据区域设置单元格值
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Sheets(SheetName).Range(RangeStr).Value = Val
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function SetCellFormulaByRange(SheetName As String, RangeStr As String, Val As String) As Long
    '根据区域设置单元格值
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Sheets(SheetName).Range(RangeStr).Formula = Val
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function SetCellValueByRCId(SheetName As String, RowId As Long, ColumnId As Long, Val As String) As Long
    '根据行号、列号来设置单元格的值；
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Sheets(SheetName).Cells(RowId, ColumnId).Value = Val
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function GetSheetIsProtect(SheetName As String) As Boolean
    '判断工作表是否被保护
    If Sheets(SheetName).Range("ZZ1").AllowEdit Then
        GetSheetIsProtect = False
    Else
        GetSheetIsProtect = True
    End If
End Function

Function GetBookIsProtect() As Boolean
    '判断工作薄是否被保护
    GetBookIsProtect = ThisWorkbook.HasPassword
End Function

Function SetRangeFontColor(SheetName As String, RangeStr As String, ColorName As String)
    '设置区域的字体颜色，常用绿、黄、红3种；
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    If ColorName = "绿色" Then Sheets(SheetName).Range(RangeStr).Font.ColorIndex = 14
    If ColorName = "黄色" Then Sheets(SheetName).Range(RangeStr).Font.ColorIndex = 46
    If ColorName = "红色" Then Sheets(SheetName).Range(RangeStr).Font.ColorIndex = 3
    
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function

Function HideSheet(SheetName As String, ToHide As Boolean)
    '隐藏SHEET
    ThisWorkbook.Unprotect GetPwd
    If Not Sheets(SheetName).Visible = ToHide Then Exit Function
    
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    Sheets(SheetName).Visible = Not ToHide
    
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
    ThisWorkbook.Protect GetPwd
End Function
Function GetListBoxValue(UserFormName As String, ListboxName As String, PrefixStr As String, AftfixStr As String, SplitStr As String, SelectAll As Boolean) As String
    '获取窗体的列表控件的所有项，并加入前缀后缀和分隔符，形成字符串
    GetListBoxValue = ""
    Dim I As Long, AllStr As String, J As Long
    J = 0
    AllStr = ""
    With UserForms(GetUserformIdByName(UserFormName)).Controls(ListboxName)
        For I = 0 To .ListCount - 1
            If .Selected(I) Then
                If GetListBoxValue = "" Then
                    GetListBoxValue = PrefixStr & .List(I) & AftfixStr
                Else
                    GetListBoxValue = GetListBoxValue & SplitStr & PrefixStr & .List(I) & AftfixStr
                End If
                J = J + 1
            End If
            
            If AllStr = "" Then
                AllStr = PrefixStr & .List(I) & AftfixStr
            Else
                AllStr = AllStr & SplitStr & PrefixStr & .List(I) & AftfixStr
            End If
        Next
    End With
    
    If SelectAll And J = 0 Then
        GetListBoxValue = AllStr
    End If
    
End Function
Function ListBoxValueSelect(UserFormName As String, ListboxName As String, SelectType As String)
    '列表控件的全选全不选方法；
    Dim I As Long, J As Long
    J = 0
    AllStr = ""
    With UserForms(GetUserformIdByName(UserFormName)).Controls(ListboxName)
        For I = 0 To .ListCount - 1
            If .Selected(I) Then
                If SelectType = "反选" Then .Selected(I) = False
            Else
            End If
            
            If SelectType = "全选" Then .Selected(I) = True
            If SelectType = "全不选" Then .Selected(I) = False
        Next
        
    End With
    
End Function

Function ListBoxValueSelectItems(UserFormName As String, ListboxName As String, SelectType As Boolean, ItemString As String)
    '列表控件的项目选择；
    Dim I As Long, J As Long
    J = 0
    AllStr = ""
    ItemString = Replace(ItemString, "'", "")
    With UserForms(GetUserformIdByName(UserFormName)).Controls(ListboxName)
        For I = 0 To .ListCount - 1
            If UCase(ItemString) Like "*," & UCase(.List(I)) & ",*" _
            Or UCase(ItemString) Like UCase(.List(I)) & ",*" _
            Or UCase(ItemString) Like "*," & UCase(.List(I)) _
            Or UCase(ItemString) = UCase(.List(I)) _
            Then
            .Selected(I) = SelectType
        Else
            .Selected(I) = Not SelectType
        End If
    Next
    
End With

End Function

Function GetUserformIdByName(FormName As String) As Long
    '通过窗体名称获取窗体内置的编号
    For I = 0 To UserForms.Count - 1
        If UCase(UserForms(I).Name) = UCase(FormName) Then
            GetUserformIdByName = I
            GoTo N
        End If
    Next
N:
End Function
Function GetValueFromXml(XMLStr As String, ElementStr As String) As String
    '根据XML的元素名，获取对应的值；
    Dim FromI As Long, ToI As Long, NXmlStr As String
    ElementStr = Replace(UCase(ElementStr), " ", "")
    
    GetValueFromXml = ""
    If ElementStr = "" Then GoTo N
    NXmlStr = UCase(XMLStr)
    FromI = InStr(1, NXmlStr, "<" & ElementStr & ">")
    ToI = InStr(1, NXmlStr, "</" & ElementStr & ">")
    If FromI <= 0 And ToI <= 0 Then GoTo N
    GetValueFromXml = Left(XMLStr, ToI)
    GetValueFromXml = Right(GetValueFromXml, ToI - FromI)
    GetValueFromXml = Left(GetValueFromXml, Len(GetValueFromXml) - 1)
    If Len(GetValueFromXml) - 1 - Len(ElementStr) = 0 Then
        GetValueFromXml = ""
    Else
        GetValueFromXml = Right(GetValueFromXml, Len(GetValueFromXml) - 1 - Len(ElementStr))
    End If
N:
    
End Function

Function GetDBInfo(SystemName As String, _
    Envo As String, UserName As String, Pwd As String) As String
    '通过WS获取数据库链接信息
    Dim XMLStr As String
    XMLStr = "<Interface WSID=""294CC87B-9E18-48FF-A226-FEE8A7C4D06B"" " & _
    " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
    "<SystemName>" & SystemName & "</SystemName>" & _
    "<Envo>" & Envo & "</Envo>" & _
    "<USERNAME>" & UserName & "</USERNAME>" & _
    "<PASSWORD>" & Pwd & "</PASSWORD>" & _
    "</Interface>"
    
    GetDBInfo = GetWsrrRlt(XMLStr)
End Function

Function GetWsrrRlt(XMLStr As String) As String
    '调用WSRR的通用WS
    Dim objHTTP, xmlDOC
    
    '调用webservice方法
    Set objHTTP = CreateObject("MSXML2.XMLHTTP")
    strWebserviceURL = GetWsrrUrl
    objHTTP.Open "POST", strWebserviceURL, False
    objHTTP.setRequestHeader "Content-Type", "application/json"
    
    objHTTP.send ("{XmlInput:'" & XMLStr & "'}")
    
    GetWsrrRlt = BytesToBstr((objHTTP.responseBody), "utf-8")
    GetWsrrRlt = GetStringByJson(GetWsrrRlt)
    
End Function
Function BytesToBstr(body, Cset)
    '将流转换为文本
    Dim SizeI As Long, TStr As String, SizeT As Long
    Dim I As Long
    I = 1
    Dim objstream
    SizeI = 30000
    Set objstream = CreateObject("adodb.stream")
    objstream.Type = 1
    objstream.Mode = 3
    objstream.Open
    objstream.Write body
    objstream.Position = 0
    'SizeT = objstream.Size
    objstream.Type = 2
    objstream.Charset = Cset
    
    BytesToBstr = objstream.ReadText
    objstream.Close
    Set objstream = Nothing
    
    
End Function
Function GetStringByJson(Str1 As String) As String
    '将Json格式转换为XML格式
    Str1 = Replace(Str1, "{""d"":""", "", 1, 1)
    Str1 = Replace(Str1, """}", "")
    Str1 = Replace(Str1, "\u003c", "<")
    Str1 = Replace(Str1, "\u003e", ">")
    GetStringByJson = Replace(Str1, "\""", """")
End Function
Function GetUserNameBySessionId(SessionId As String) As String
    '通过SESSIONID获取用户名,空代表没有用户
    Dim XMLStr As String
    XMLStr = "<Interface WSID=""00e8a046-2edc-4c11-b227-4f3c27385887"" App=""" & GetAppName & """ SessionID=""" & _
    SessionId & """>" & "<SessionID>" & SessionId & "</SessionID> </Interface>"
    GetUserNameBySessionId = GetValueFromXml(GetWsrrRlt(XMLStr), "SSO_UserName")
End Function
Function CheckLogin_WS(Usr As String, Pwd As String, LoginSrv As String) As Boolean
    '以WebService的方式来登录
    Dim XMLStr As String, SessionId As String
    SessionId = ""
    
    SetCellValueByRange "CONF", "A1", "SessionId"
    SetCellValueByRange "CONF", "B1", SessionId
    
    XMLStr = "<Interface WSID=""550fc164-adc8-4f88-bc9d-73c4248050bc""" & _
    " App=""" & GetAppName & """ SessionID=""""><AppSn>" & GetAppName & "</AppSn><LoginApp>" & LoginSrv & "</LoginApp>" & _
    "<UserName>" & Usr & "</UserName><Password>" & Pwd & "</Password></Interface>"
    
    SetCellValueByRange "Main", "B1", ""
    CheckLogin_WS = False
    
    If Pwd Like "*[*]*" Or Pwd Like "* or *" Then
        GoTo N
    End If
    
    SessionId = GetWsrrRlt(XMLStr)
    If SessionId Like "????????-????-????-????-????????????" Then
        CheckLogin_WS = True
        IsLogin = True
        SetCellValueByRange "Main", "B1", Usr
        SetValueByName "USR", Usr
        Application.Caption = Usr
        SetCellValueByRange "Main", "C1", SessionId
        SetValueByName "SessionId", SessionId
    Else
        CheckLogin_WS = False
    End If
    
N:
    
End Function


Function GetSessionId() As String
    GetSessionId = GetValueByName("SessionId")
End Function
Function GetSessionIdByFileTitle()
    '根据EXCEL TITLE属性来获取SESSIONID
    Dim FileName As String, I As Long
    FileName = ThisWorkbook.Title
    WinSessionId = ""
    If FileName Like "*????????-????-????-????-????????????" Then
        WinSessionId = Right(FileName, 36)
        SetValueByName "Sessionid", WinSessionId
    End If
End Function
Function GetSessionIdByWindow()
    '通过枚举WINDOWS窗口标题来获取SESSIONID,目前采用的方式
    WinSessionId = ""
    Call EnumWindows(AddressOf EnumWndProc, 0&)
    SetValueByName "Sessionid", WinSessionId
End Function
Function SessionLogin()
    '单点登录
    Dim Usr As String
    Usr = GetUserNameBySessionId(GetValueByName("sessionid"))
    If Usr <> "" Then
        LoginAction Usr
    Else
        'Login.Show
    End If
End Function

Function CheckIsLogin() As Boolean
    '检查是否已经登录
    CheckIsLogin = False
    If GetValueByName("USR") = "" Then
'        MsgBox "请先登录！                   ", vbCritical, "提示"
        Login.Show
        Exit Function
    Else
        CheckIsLogin = True
    End If
End Function

Function FindValueLocation(Val As String, SheetName As String, RangeStr As String, Seq As Long) As String
    '根据SHEET、区域、搜索的值、序号，找到对应的行号和列号，以"行号,列号"方式返回，不区分大小写,Seq <=0取最后一个
    Dim I As Long
    I = 0
    If Seq > 0 Then
        
        For Each cl In Sheets(SheetName).Range(RangeStr)
            If UCase(Trim(cl.Value)) = UCase(Trim(Val)) Then
                FindValueLocation = cl.Row & "," & cl.Column
                I = I + 1
                If I = Seq Then Exit Function
            End If
            
        Next
    End If
    
    If Seq <= 0 Then
        
        For Each cl In Sheets(SheetName).Range(RangeStr)
            If UCase(Trim(cl.Value)) = UCase(Trim(Val)) Then
                FindValueLocation = cl.Row & "," & cl.Column
                I = I + 1
            End If
        Next
        
    End If
End Function
Function FindValueLocationByHead(Val As String, TableName As String, ColumnStr As String, Seq As Long) As String
    '根据列表对象、字段名、搜索的值、序号，找到对应的行号和列号，以"行号,列号"方式返回
    FindValueLocationByHead = _
    FindValueLocation(Val, GetSheetNameOfListObject(TableName), TableName & "[[" & ColumnStr & "]]", Seq)
End Function
Function FindValueRowByHead(Val As String, TableName As String, ColumnStr As String, Seq As Long) As String
    '根据列表对象、字段名、搜索的值、序号，找到对应的行号
    Dim Str1 As String
    Str1 = _
    FindValueLocation(Val, GetSheetNameOfListObject(TableName), TableName & "[[" & ColumnStr & "]]", Seq)
    If Str1 <> "" Then
        FindValueRowByHead = Left(Str1, InStr(1, Str1, ",") - 1)
    Else
        FindValueRowByHead = ""
    End If
End Function
Function GetValueByName(ValueName As String) As String
    '获取CONF SHEET表中的变量值
    For Each cl In Sheets("CONF").Range("A1:A200")
        If UCase(cl.Value) = UCase(ValueName) Then
            GetValueByName = Sheets("CONF").Cells(cl.Row, cl.Column + 1).Value
            Exit Function
        End If
    Next
End Function

Function SetValueByName(ValueName As String, ValueStr As String)
    '根据CONF表变量名设置变量值
    ProtectSheet "Conf", False
    For Each cl In Sheets("CONF").Range("A1:A200")
        If UCase(cl.Value) = UCase(ValueName) Then
            Sheets("CONF").Cells(cl.Row, cl.Column + 1).Value = ValueStr
            I = cl.Row
            GoTo N
        End If
    Next
    
    For Each cl In Sheets("CONF").Range("A1:A200")
        If cl.Value = "" Then
            cl.Value = ValueName
            Sheets("CONF").Cells(cl.Row, cl.Column + 1).Value = ValueStr
            GoTo N
        End If
    Next
    
N:
    ProtectSheet "Conf", True
End Function
Function ClearConf()
    '清除CONF数据,但不清除SESSIONID的变量
    ProtectSheet "CONF", False
    For Each cl In Sheets("CONF").Range("A1:A200")
        If UCase(cl.Value) <> "SESSIONID" Then
            Sheets("CONF").Cells(cl.Row, cl.Column + 1).Value = ""
            cl.Value = ""
        End If
    Next
    ProtectSheet "CONF", True
End Function

Function CopyRows(SrcSheetName As String, SrcRowStr As String, DstSheetName As String, DstRowId As Long)
    '复制行
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(DstSheetName)
    If IsSheetProtect Then ProtectSheet DstSheetName, False
    
    Sheets(SrcSheetName).Rows(SrcRowStr).Copy
    Sheets(DstSheetName).Rows(DstRowId).Insert Shift:=xlDown
    
    If IsSheetProtect Then ProtectSheet DstSheetName, True
End Function

Function ClearTable(TableName As String)
    '删除列表对象
    Dim SheetName As String, RowStr As String
    SheetName = GetSheetNameOfListObject(TableName)
    If SheetName = "" Then Exit Function
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    If Sheets(SheetName).AutoFilterMode = True Then Range("TableName[#headers]").AutoFilter
    If Sheets(SheetName).FilterMode Then Sheets(SheetName).ShowAllData
    
    
    ClearTableEditRange TableName
    If GetXMLMapNameByTableName(TableName) <> "" Then DeleteXMLMap GetXMLMapNameByTableName(TableName)
    
    'Range(TableName & "[#all]").ClearContents
    Range(TableName & "[#all]").Clear
    
    'RowStr = Range(TableName & "[#Headers]").Row & ":" & Range(TableName & "[#Headers]").Row + Range(TableName & "[#All]").Rows.Count - 1
    'DeleteRows SheetName, RowStr
    
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function

Function ClearTableEditRange(TableName As String)
    '清除某TABLE的所有可编辑区域
    Dim SheetName As String
    SheetName = GetSheetNameOfListObject(TableName)
    
    If Sheets(SheetName).Protection.AllowEditRanges.Count = 0 Then Exit Function
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    For Each RG In Sheets(SheetName).Protection.AllowEditRanges
        If RG.Title Like TableName & "表区域*" Then
            On Error GoTo N
            RG.Delete
        End If
    Next
    
N:
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function

Function DeleteRows(SheetName As String, RangeStr As String)
    '根据SHEET名称和区域名，删除行
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    Dim MaxRowId As Long, MinRowId As Long, I As Long, RowStr As String
    For Each rw In Sheets(SheetName).Range(RangeStr).Rows
        If rw.Row > MaxRowId Then MaxRowId = rw.Row
        If rw.Row < MinRowId Then MinRowId = rw.Row
        RowStr = RowStr & "【" & rw.Row & ":" & rw.Row & "】"
        'MsgBox RowStr
    Next
    
    
    For I = 1 To MaxRowId - MinRowId + 1
        If RowStr Like "*【" & MaxRowId - I + 1 & ":" & MaxRowId - I + 1 & "】*" Then
            Sheets(SheetName).Rows(MaxRowId - I + 1 & ":" & MaxRowId - I + 1).Delete Shift:=xlUp
        End If
    Next I
    
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function

Function IsInTableRows(RowId As Long, TableName As String) As Boolean
    '判断行号是否在列表对象中
    IsInTableRows = False
    If RowId > Range(TableName & "[#headers]").Row _
        And RowId <= Range(TableName & "[#headers]").Row + Range(TableName & "[#ALL]").Rows.Count - 1 Then
        IsInTableRows = True
    End If
End Function
Function GetTableRowId(TableName As String, TypeId As Long) As Long
    '获取列表对象的行号，0代表头，1代表第一行数据，-1代表最后一行;与GetRowId方法类似
    If TypeId = 0 Then GetTableRowId = Range(TableName & "[#headers]").Row
    If TypeId = 1 Then GetTableRowId = Range(TableName & "[#headers]").Row + 1
    If TypeId = -1 Then GetTableRowId = Range(TableName & "[#headers]").Row + Range(TableName & "[#ALL]").Rows.Count - 1
    
End Function
Function SetApplication()
    '设置EXCEL的回车方向和窗口最大
    Application.MoveAfterReturnDirection = xlToRight
    Application.WindowState = xlMaximized
End Function

Function GetSessionIdByUrl()
    '根据浏览器的URL地址获取SESSIONID，注意：仅适用于微软IE浏览器
    WinSessionId = ""
    Dim Guid As String
    Dim obj As Object
    On Error Resume Next
    For Each obj In CreateObject("Shell.Application").Windows
        If obj.LocationURL Like "*" & GetUrlPath & "????????-????-????-????-????????????*" Then
            WinSessionId = Left(obj.LocationURL, InStr(1, obj.LocationURL, GetUrlPath) + Len(GetUrlPath) - 1 + 36)
            WinSessionId = Right(WinSessionId, 36)
            Exit For
        End If
    Next
    SetValueByName "Sessionid", WinSessionId
End Function
Function CreateTableForXML(TableName As String, XMLStr As String, ElementName As String, SheetName As String, RangeStr As String)
    '根据XML和元素名称建立一个列表对象
    Dim IsSheetProtect As Boolean, IsBookProtect As Boolean
    IsBookProtect = GetBookIsProtect()
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsBookProtect Then ProtectBook False
    If IsSheetProtect Then ProtectSheet SheetName, False
    'XMLStr = FormatXMLForListObject(XMLStr)
    
    If ElementName <> "" Then XMLStr = GetXMLUnderElement(XMLStr, ElementName)
    XMLStr = FormatXMLHead(XMLStr)
    XMLStr = FormatXMLNullElement(XMLStr)
    
    ThisWorkbook.XmlImportXml XMLStr, ImportMap:=Nothing, _
    Overwrite:=True, Destination:=Sheets(SheetName).Range(RangeStr)
    Sheets(SheetName).Range(RangeStr).ListObject.Name = TableName
    Sheets(SheetName).ListObjects(TableName).TableStyle = "TableStyleMedium23"
    If IsSheetProtect Then ProtectSheet SheetName, True
    If IsBookProtect Then ProtectBook True
End Function
Function ConvertTableToXML(TableName As String) As String
    '将列表对象的记录，转换为XML字符串
    Dim XMLStr As String
    Dim XMLMapName As String
    XMLMapName = GetXMLMapNameByTableName(TableName)
    ThisWorkbook.XmlMaps(XMLMapName).ExportXml Data:=XMLStr
    ConvertTableToXML = XMLStr
End Function
Function DeleteXMLMap(XMLMapName As String)
    '删除映射对象
    Dim IsBookProtect As Boolean
    IsBookProtect = GetBookIsProtect()
    If IsBookProtect Then ProtectBook False
    
    ThisWorkbook.XmlMaps(XMLMapName).Delete
    
    If IsBookProtect Then ProtectBook True
End Function
Function GetXMLMapNameByTableName(TableName As String) As String
    '根据列表对象获取对应的映射名称
    Dim SheetName As String
    On Error GoTo N
    SheetName = GetSheetNameOfListObject(TableName)
    GetXMLMapNameByTableName = Sheets(SheetName).Range(TableName & "[#headers]").Cells(1, 1).XPath.Map.Name
N:
End Function
Function GetListElementNameOfXML(XMLStr As String) As String
    '获取XML里层记录集，对应的元素名
    Dim I As Long, MaxI As Long, MaxJ As Long
    Dim Str1 As String
    I = InStr(1, XMLStr, "<")
    Do While I > 0
        str2 = Mid(XMLStr, I, 2)
        If str2 <> "</" Then MaxI = I
        I = InStr(I + 1, XMLStr, "<")
    Loop
    
    For I = 1 To 3
        MaxI = InStr(MaxI + 1, XMLStr, "<")
    Next I
    
    MaxJ = InStr(MaxI, XMLStr, ">")
    GetListElementNameOfXML = Mid(XMLStr, MaxI + 2, MaxJ - MaxI - 2)
End Function
Function GetRowElementNameOfXML(XMLStr As String) As String
    '获取XML里层记录集，对应的元素名
    Dim I As Long, MaxI As Long, MaxJ As Long
    Dim Str1 As String
    I = InStr(1, XMLStr, "<")
    Do While I > 0
        str2 = Mid(XMLStr, I, 2)
        If str2 <> "</" Then MaxI = I
        I = InStr(I + 1, XMLStr, "<")
    Loop
    
    For I = 1 To 2
        MaxI = InStr(MaxI + 1, XMLStr, "<")
    Next I
    
    MaxJ = InStr(MaxI, XMLStr, ">")
    GetRowElementNameOfXML = Mid(XMLStr, MaxI + 2, MaxJ - MaxI - 2)
End Function
Function FormatXMLForListObject(XMLStr As String, SubElementStr As String) As String
    '将XML格式转化为符合列表对象要求的XML格式,即最少2个记录行；
    Dim I As Long, J As Long, RowElementStr As String, ListElementStr As String
    
    'Msg "FORM", vbCritical, "", "", XMLStr
    ListElementStr = GetListElementNameOfXML(XMLStr)
    I = InStr(1, XMLStr, "<" & ListElementStr & ">")
    I = InStr(I, XMLStr, ">")
    FormatXMLForListObject = Left(XMLStr, I)
    I = InStr(I + 1, XMLStr, "<")
    J = InStr(I + 1, XMLStr, ">")
    RowElementStr = Mid(XMLStr, I + 1, J - I - 1)
    FormatXMLForListObject = FormatXMLForListObject & "<" & RowElementStr & ">" & SubElementStr & "</" & RowElementStr & ">"
    FormatXMLForListObject = FormatXMLForListObject & Mid(XMLStr, I, Len(XMLStr) - I + 1)
    
    Exit Function
    I = InStr(1, XMLStr, "</" & RowElementStr & ">")
    J = InStr(I + 1, XMLStr, "</" & RowElementStr & ">")
    If J <= 0 Then
        FormatXMLForListObject = Mid(XMLStr, 1, I + 2 + Len(RowElementStr)) & "<" & RowElementStr & ">" & SubElementStr & "</" & RowElementStr & ">"
        FormatXMLForListObject = FormatXMLForListObject & Mid(XMLStr, I + Len(RowElementStr) + 3, Len(XMLStr) - I + 1 - Len(RowElementStr) - 3)
    Else
        FormatXMLForListObject = XMLStr
    End If
End Function

Function GetXMLUnderElement(XMLStr As String, ElementName As String) As String
    '获取XML某个元素下面的记录
    GetXMLUnderElement = Mid(XMLStr, InStr(1, XMLStr, "<" & ElementName & ">"), Len(XMLStr) - InStr(1, XMLStr, "<" & ElementName & ">") + 1)
    GetXMLUnderElement = Left(GetXMLUnderElement, InStr(1, GetXMLUnderElement, "</" & ElementName & ">") - 1 + Len(ElementName) + 3)
End Function
Function FormatXMLNullElement(XMLStr As String) As String
    '将XML格式的<XXX/>改为<XXX></XXX>,适用于数据库返回的XML
    Dim I As Long, J As Long
    Dim Str1 As String, ElementName As String
    I = InStr(1, XMLStr, "/>")
    Do While I > 0
        Str1 = Mid(XMLStr, 1, I - 1)
        J = InStrRev(Str1, "<")
        ElementName = Replace(Mid(XMLStr, J + 1, I - J - 1), " ", "")
        XMLStr = Replace(XMLStr, Mid(XMLStr, J, I - J + 2), "<" & ElementName & "></" & ElementName & ">", 1)
        I = InStr(1, XMLStr, "/>")
    Loop
    FormatXMLNullElement = XMLStr
End Function

Function GetXMLHead() As String
    '设定XML头字符编码常量
    GetXMLHead = "<?xml version=""1.0"" encoding=""gb2312"" standalone=""yes""?>"
End Function

Function FormatXMLHead(XMLStr As String) As String
    '更改XML的格式，添加字符编码
    XMLStr = LTrim(XMLStr)
    If Not UCase(Left(XMLStr, 20)) Like "<?XML VERSION=*" Then
        XMLStr = "<?xml version=""1.0"" encoding=""utf-8"" standalone=""yes""?>" & XMLStr
    Else
        XMLStr = GetXMLHead & Right(XMLStr, Len(XMLStr) - InStr(1, XMLStr, ">"))
    End If
    FormatXMLHead = XMLStr
End Function

Function ReplaceTableHead(TableName As String, HeadMapString As String)
    '设置列表对象 字段名进行替换【旧列名,新列名】
    Dim SheetName As String, OldColumnName As String, NewColumnName As String
    Dim I As Long, J As Long, K As Long, M As Long
    SheetName = GetSheetNameOfListObject(TableName)
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    HeadMapString = Replace(HeadMapString, "，", ",")
    I = 1
    Do While Mid(HeadMapString, I, Len(HeadMapString) - I + 1) Like "*【*,*】*"
        I = InStr(I, HeadMapString, "【")
        J = InStr(I, HeadMapString, ",")
        K = InStr(J, HeadMapString, "】")
        OldColumnName = Mid(HeadMapString, I + 1, J - I - 1)
        NewColumnName = Mid(HeadMapString, J + 1, K - J - 1)
        On Error GoTo N
        Sheets(SheetName).Cells(Range(TableName & "[#headers]").Row, _
        Range(TableName & "[[" & OldColumnName & "]]").Column).Value = NewColumnName
N:
        If K < Len(HeadMapString) Then
            I = K + 1
        Else
            Exit Function
        End If
    Loop
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function HideTableColumns(TableName As String, ColumnsName As String, ToHide As Boolean)
    '设置列表对象字段名集合是否隐藏【*,列名】或【列名】
    Dim I As Long, J As Long
    Dim ColumnName As String
    
    For Each cell In Range(TableName & "[#headers]")
        ColumnName = cell.Value
        
        If UCase(ColumnsName) Like "*【" & UCase(ColumnName) & "】*" Or UCase(ColumnsName) Like "*【*," & UCase(ColumnName) & "】*" Then
            Range(TableName & "[[" & ColumnName & "]]").Columns.Hidden = ToHide
        Else
            Range(TableName & "[[" & ColumnName & "]]").Columns.Hidden = Not ToHide
        End If
        
    Next
    
End Function

Function SetRangeFormula(SheetName As String, RangeStr As String, FormulaStr As String)
    '设置单元格公式
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    Sheets(SheetName).Range(RangeStr).Formula = FormulaStr
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
End Function
Function IsInTable(TableName As String, RowId As Long, ColumnId As Long) As Boolean
    '判断单元格是否在列表对象中
    IsInTable = False
    If GetSheetNameOfListObject(TableName) = "" Then Exit Function
    If RowId >= GetRowId(TableName, "Min") And RowId <= GetRowId(TableName, "Max") Then
    Else
        Exit Function
    End If
    
    If ColumnId >= GetColumnId(TableName, "Min") And ColumnId <= GetColumnId(TableName, "Max") Then
    Else
        Exit Function
    End If
    IsInTable = True
End Function
Function IsInTableColumns(TableName As String, ColumnName As String) As Boolean
    '判断列名是否在列表对象中
    IsInTableColumns = False
    For Each cl In Range(TableName & "[#headers]")
        If UCase(cl.Value) = UCase(ColumnName) Then
            IsInTableColumns = True
            Exit Function
        End If
    Next
End Function
Function GetRowId(TableName As String, TypeStr As String) As Long
    '获取列表对象的最小最大行号,表头行号
    Dim I As Long
    If Trim(UCase(TypeStr)) = "MIN" Then GetRowId = Range(TableName & "[#headers]").Cells(1, 1).Row + 1
    
    On Error GoTo E
    I = Range(TableName & "[#headers]").Cells(1, 1).ListObject.DataBodyRange.Rows.Count
    If Trim(UCase(TypeStr)) = "MAX" Then
        GetRowId = Range(TableName & "[#headers]").Cells(1, 1).Row + Range(TableName & "[#headers]").Cells(1, 1).ListObject.DataBodyRange.Rows.Count
        GoTo N
    End If
E:
    GetRowId = Range(TableName & "[#headers]").Cells(1, 1).Row + 1
N:
    If Trim(UCase(TypeStr)) = "HEAD" Then GetRowId = Range(TableName & "[#headers]").Cells(1, 1).Row
    
End Function

Function GetTableColumnNameById(TableName As String, ColumnId As Long) As String
    '根据单元格行号、列号获取Table行名
    GetTableColumnNameById = Sheets(GetSheetNameOfListObject(TableName)).Cells(GetRowId(TableName, "Head"), ColumnId).Value
    
End Function
Function GetColumnId(TableName As String, TypeStr As String) As Long
    '获取列表对象的最小最大列号
    If Trim(UCase(TypeStr)) = "MIN" Then GetColumnId = Range(TableName & "[#headers]").Cells(1, 1).Column
    If Trim(UCase(TypeStr)) = "MAX" Then GetColumnId = Range(TableName & "[#headers]").Cells(1, 1).Column + Range(TableName & "[#headers]").Columns.Count - 1
End Function

Function KeepElementFromXML(XMLStr As String, F_ElementName As String, ElementName As String, ElementValue As String, TypeStr As String)
    '从XML里去掉不符合条件的记录
    Dim I As Long, J As Long, K As Long, L As Long
    Dim M As Boolean
    Dim EV As String
    
    '删除不符合记录的
    I = 1
    L = 1
    I = InStr(1, XMLStr, "<" & ElementName & ">")
    If I <= 0 Then
        KeepElementFromXML = ""
        Exit Function
    End If
    KeepElementFromXML = Left(XMLStr, InStr(L, XMLStr, "<" & F_ElementName & ">") - 1)
    Do While I > 0
        M = False
        I = InStr(I, XMLStr, "<" & ElementName & ">")
        J = InStr(I, XMLStr, ">")
        K = InStr(J, XMLStr, "</")
        EV = Mid(XMLStr, J + 1, K - J - 1)
        If EV = ElementValue And TypeStr = "=" Then
            M = True
        End If
        
        If EV <> ElementValue And TypeStr = "<>" Then
            M = True
        End If
        
        If M Then
            I = InStr(L, XMLStr, "<" & F_ElementName & ">")
            If I > 0 Then
            Else
                I = InStr(L, XMLStr, "<" & F_ElementName & " ")
            End If
            J = InStr(I, XMLStr, "</" & F_ElementName & ">")
            J = InStr(J, XMLStr, ">")
            KeepElementFromXML = KeepElementFromXML & Mid(XMLStr, I, J - I + 1)
            
        End If
        L = J
        I = InStr(J, XMLStr, "<" & ElementName & ">")
        
        
    Loop
    
    I = InStrRev(XMLStr, "</" & F_ElementName & ">")
    I = InStr(I, XMLStr, ">")
    KeepElementFromXML = KeepElementFromXML & Mid(XMLStr, I + 1, Len(XMLStr) - I)
    
N:
End Function
Function AddElementFromXML(XMLStr As String, F_ElementName As String, NewElmentName As String) As String
    '向XML里增加一个元素
    Dim I As Long, J As Long
    XMLStr = " " & XMLStr & " "
    I = InStr(1, XMLStr, "<" & F_ElementName & ">")
    If I > 0 Then
    Else
        I = InStr(1, XMLStr, "<" & F_ElementName & " ")
    End If
    J = InStr(I, XMLStr, ">")
    AddElementFromXML = Left(XMLStr, J) & "<" & NewElmentName & "></" & NewElmentName & ">"
    AddElementFromXML = AddElementFromXML & Right(XMLStr, Len(XMLStr) - J)
End Function
Function DeleteElementFromXML(XMLStr As String, F_ElementName As String, DltElmentName As String) As String
    '从XML里删除某个元素
    Dim I As Long, J As Long
    
    XMLStr = " " & XMLStr & " "
    Do While InStr(1, XMLStr, "</" & DltElmentName & ">") > 0
        I = InStr(1, XMLStr, "<" & DltElmentName & ">")
        If I > 0 Then
        Else
            I = InStr(1, XMLStr, "<" & DltElmentName & " ")
        End If
        J = InStr(I, XMLStr, "</")
        J = InStr(J, XMLStr, ">")
        XMLStr = Left(XMLStr, I - 1) & Right(XMLStr, Len(XMLStr) - J)
    Loop
    DeleteElementFromXML = XMLStr
End Function

Function GetAttrValueFromXML(XMLStr As String, ElementName As String, AttrName As String) As String
    '获取某个元素的某个属性值，取第一个
    Dim I As Long, J As Long
    I = InStr(1, XMLStr, "<" & ElementName & " ")
    If I > 0 Then
        I = InStr(I, XMLStr, " ")
        I = InStr(I, XMLStr, " " & AttrName & "=")
        I = InStr(I, XMLStr, """")
        J = InStr(I + 1, XMLStr, """")
        If J = I + 1 Then
            GetAttrValueFromXML = ""
        Else
            GetAttrValueFromXML = Mid(XMLStr, I + 1, J - I - 1)
        End If
    End If
End Function

Function GetRowColId(LocationStr As String, TypeStr As String) As String
    '根据区域名，比如 A,1 获取行号、列号
    If InStr(1, LocationStr, ",") <> 1 And InStr(1, LocationStr, ",") <> Len(LocationStr) And LocationStr Like "*,*" Then
        If TypeStr = "行" Then
            GetRowColId = Left(LocationStr, InStr(1, LocationStr, ",") - 1)
        End If
        
        If TypeStr = "列" Then
            GetRowColId = Right(LocationStr, Len(LocationStr) - InStr(1, LocationStr, ","))
        End If
    End If
End Function

Function InsertLine(SheetName As String, RowId As Long, IsSelect As Boolean)
    '在指定行插入，并选中新行
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    Sheets(SheetName).Rows(RowId + 1 & ":" & RowId + 1).Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
    If IsSelect Then Sheets(SheetName).Rows(RowId + 1 & ":" & RowId + 1).Select
    
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function

Function CheckSelectionInTable(TableName As String, IsWarnning As Boolean) As Boolean
    '检查当前选择，是否是所在列表对象的唯一一行
    CheckSelectionInTable = False
    'Dim SheetName As String
    'SheetName = GetSheetNameOfListObject(TableName)
    If Selection.Rows.Count <> 1 Then
        If IsWarnning Then MsgBox "请在当前数据表中只选择一行！                 ", vbCritical, "提示"
        Exit Function
    End If
    If Not IsInTableRows(Selection.Row, TableName) Then
        If IsWarnning Then MsgBox "请定位于目前的数据行！             ", vbCritical, "提示"
        Exit Function
    End If
    CheckSelectionInTable = True
End Function

Function GetHHF() As String
    GetHHF = Chr(10) & Chr(13)
End Function

Function DeleteElementNullFromXML(XMLStr As String, F_ElementName As String, ElementName As String) As String
    '从XML里去掉没有Element元素的记录
    Dim I As Long, J As Long, K As Long, L As Long
    Dim M As Boolean
    Dim EV As String
    
    I = 1
    L = 1
    I = InStr(1, XMLStr, "<" & F_ElementName & ">")
    DeleteElementNullFromXML = Left(XMLStr, InStr(L, XMLStr, "<" & F_ElementName & ">") - 1)
    Do While I > 0
        K = InStr(I, XMLStr, ">")
        J = InStr(I, XMLStr, "</" & F_ElementName & ">")
        L = InStr(J, XMLStr, ">")
        If Mid(XMLStr, K, J - K) Like "*<" & ElementName & ">" & "*" & "</" & ElementName & ">*" Then
            DeleteElementNullFromXML = DeleteElementNullFromXML & Mid(XMLStr, I, L - I + 1)
        End If
        I = InStr(L, XMLStr, "<" & F_ElementName & ">")
    Loop
    
    DeleteElementNullFromXML = DeleteElementNullFromXML & Mid(XMLStr, L + 1, Len(XMLStr) - L)
End Function


Function GetXMLByTableRow(TableName As String, RowId As Long, ColumnList As String) As String
    '获取列表对象某一行的XML,取倒数第二层Element
    Dim SheetName As String, XMLStr As String, F_ElementName As String, ElementName As String
    Dim MinColId As Long, MaxColId As Long, ColumnName As String
    Dim I As Long, J As Long, M As Boolean
    SheetName = GetSheetNameOfListObject(TableName)
    MinColId = GetColumnId(TableName, "Min")
    MaxColId = GetColumnId(TableName, "Max")
    F_ElementName = Range(TableName & "[#Headers]").Cells(1, 1).ListObject.DataBodyRange.Cells(1, 1).XPath
    I = InStrRev(F_ElementName, "/")
    J = InStrRev(F_ElementName, "/", I - 1)
    F_ElementName = Mid(F_ElementName, J + 1, I - J - 1)
    XMLStr = "<" & F_ElementName & ">"
    For I = MinColId To MaxColId
        M = False
        ColumnName = Sheets(SheetName).Cells(GetRowId(TableName, "Min") - 1, I).Value
        If ColumnList Like "*【" & ColumnName & "】*" Or ColumnList = "" Then
            
            ElementName = Sheets(SheetName).Cells(RowId, I).XPath
            J = InStrRev(ElementName, "/")
            ElementName = Mid(ElementName, J + 1, Len(ElementName) - J)
            XMLStr = XMLStr & "<" & ElementName & ">" & Sheets(SheetName).Cells(RowId, I).Value & "</" & ElementName & ">"
            
        End If
    Next I
    
    XMLStr = XMLStr & "</" & F_ElementName & ">"
    GetXMLByTableRow = XMLStr
End Function


Function GetXMLByTableColumn(TableName As String, ColumnList As String, ConColumnName As String, _
    ConColumnValue As String, TypeStr As String) As String
    '获取列表对象某一行的XML,取倒数第二层Element
    Dim SheetName As String, XMLStr As String, F_ElementName As String, ElementName As String
    Dim ColumnName As String, RowId As Long
    Dim MinRowId As Long, MaxRowId As Long
    Dim I As Long, J As Long, M As Boolean
    SheetName = GetSheetNameOfListObject(TableName)
    MinRowId = GetRowId(TableName, "Min")
    MaxRowId = GetRowId(TableName, "Max")
    
    For I = MinRowId To MaxRowId
        M = False
        RowId = I
        If GetValueByHead(TableName, RowId, ConColumnName) = ConColumnValue And TypeStr = "=" Then
            M = True
        End If
        
        If GetValueByHead(TableName, RowId, ConColumnName) <> ConColumnValue And TypeStr = "<>" Then
            M = True
        End If
        
        If GetValueByHead(TableName, RowId, ConColumnName) > ConColumnValue And TypeStr = ">" Then
            M = True
        End If
        
        If GetValueByHead(TableName, RowId, ConColumnName) >= ConColumnValue And TypeStr = ">=" Then
            M = True
        End If
        
        If GetValueByHead(TableName, RowId, ConColumnName) < ConColumnValue And TypeStr = "<" Then
            M = True
        End If
        
        If GetValueByHead(TableName, RowId, ConColumnName) <= ConColumnValue And TypeStr = "<=" Then
            M = True
        End If
        
        If GetValueByHead(TableName, RowId, ConColumnName) Like ConColumnValue And UCase(Trim(TypeStr)) = "LIKE" Then
            M = True
        End If
        
        If Not GetValueByHead(TableName, RowId, ConColumnName) Like ConColumnValue And UCase(Trim(TypeStr)) = "Not LIKE" Then
            M = True
        End If
        
        If M Then
            XMLStr = XMLStr & GetXMLByTableRow(TableName, RowId, ColumnList)
        End If
    Next I
    GetXMLByTableColumn = XMLStr
    
    
End Function


Function ScreenUpdate(IsUpdate As Boolean)
    Application.ScreenUpdating = IsUpdate
End Function

Function ConvertColumnListToXML(ColumnList As String) As String
    '根据【Element名,列名】名称转换为XML格式
    Dim I As Long, J As Long, K As Long, ElementName As String
    If ColumnList Like "*【*】*" Then
        I = InStr(1, ColumnList, "【")
        
        Do While Mid(ColumnList, I, Len(ColumnList) - I + 1) Like "*【*】*"
            I = InStr(I, ColumnList, "【")
            J = InStr(I, ColumnList, "】")
            If J = I + 1 Then GoTo N
            If Mid(ColumnList, I + 1, J - I - 1) Like "*,*" Then
                K = InStr(I, ColumnList, ",")
                ElementName = Replace(Mid(ColumnList, I + 1, K - I - 1), " ", "")
            Else
                ElementName = Replace(Mid(ColumnList, I + 1, J - I - 1), " ", "")
            End If
            ConvertColumnListToXML = ConvertColumnListToXML & "<" & ElementName & "></" & ElementName & ">"
            
N:
            I = J
        Loop
    End If
    
End Function

Function SetOleObjectListBox(SheetName As String, ControlName As String, ListFillRangeFirst As String, LinkedCellStr As String, ItemList As String)
    '根据sheet名称和Activex控件、源、链接单元格、字符串（【】），设置ListBox下拉列表；
    Dim obj As OLEObject, I As Long, J As Long, ItemStr As String, C As Long
    Dim ListFillRangeStr As String, LSheetName As String, CurRangeStr As String
    Set obj = Sheets(SheetName).OLEObjects(ControlName)
    If ListFillRangeFirst Like "*!*" Then
        LSheetName = Left(ListFillRangeFirst, InStr(1, ListFillRangeFirst, "!") - 1)
    Else
        LSheetName = SheetName
    End If
    ListFillRangeStr = LSheetName & "!"
    I = 1
    C = 0
    I = InStr(1, ItemList, "【")
    J = InStr(1, ItemList, "】")
    Do While I > 0 And J > 0
        ItemStr = Mid(ItemList, I + 1, J - I - 1)
        CurRangeStr = Cells(Range(ListFillRangeFirst).Row + C, Range(ListFillRangeFirst).Column).Address()
        SetCellValueByRange LSheetName, CurRangeStr, ItemStr
        C = C + 1
        If C = 1 Then ListFillRangeStr = ListFillRangeStr & CurRangeStr
        
        If J = Len(ItemList) Then GoTo N
        I = InStr(I + 1, ItemList, "【")
        J = InStr(I, ItemList, "】")
    Loop
N:
    ListFillRangeStr = ListFillRangeStr & ":" & CurRangeStr
    obj.ListFillRange = ListFillRangeStr
    obj.LinkedCell = LinkedCellStr
    
End Function

Function GetOleListBoxValue(SheetName As String, ControlName As String) As String
    '根据sheet名称和Activex ListBox控件名称获取值；
    Dim LinkedCellStr As String, LSheetName As String
    
    LinkedCellStr = Sheets(SheetName).OLEObjects(ControlName).LinkedCell
    
    If LinkedCellStr Like "*!*" Then
        LSheetName = Left(LinkedCellStr, InStr(1, LinkedCellStr, "!") - 1)
        GetOleListBoxValue = Range(LinkedCellStr).Value
    Else
        LSheetName = SheetName
        GetOleListBoxValue = Sheets(SheetName).Range(LinkedCellStr).Value
    End If
    
End Function

Function GetListFromXML(XMLStr As String, ElementName As String, IsNotNull As Boolean) As String
    '从XML里取出Element对应的值，产生【】【】的字符串
    Dim I As Long, J As Long
    I = InStr(1, XMLStr, "<" & ElementName & ">")
    
    Do While I > 0
        I = InStr(I, XMLStr, "<" & ElementName & ">")
        J = InStr(I, XMLStr, "</" & ElementName & ">")
        I = InStr(I, XMLStr, ">")
        If IsNotNull And ((J = I + 1) Or (Trim(Mid(XMLStr, I + 1, J - I - 1)) = "")) Then
        Else
            If Not GetListFromXML Like "【" & Trim(Mid(XMLStr, I + 1, J - I - 1)) & "】" Then
                GetListFromXML = GetListFromXML & "【" & Mid(XMLStr, I + 1, J - I - 1) & "】"
            End If
        End If
        I = InStr(J, XMLStr, "<" & ElementName & ">")
    Loop
    
End Function

Function LoadPicInCell(SheetName As String, RangeStr As String, PicNamePrefix As String, V_Width As Long, V_Height As Long, PicUrl As String, HyperUrl As String)
    '根据URL地址装载图片，以磅为单位,按比例缩放
    Dim r1 As Range, r2 As Range, Pic_Left As Long, Pic_top As Long, Pic_Width As Long, Pic_height As Long
    Sheets(SheetName).Range(RangeStr).Rows.RowHeight = V_Height
    Sheets(SheetName).Range(RangeStr).Columns.ColumnWidth = V_Width * Sheets(SheetName).Range(RangeStr).ColumnWidth / Sheets(SheetName).Range(RangeStr).Width
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Dim p As Shape, Rate As Double
    Set r1 = Sheets(SheetName).Range(RangeStr)
    Pic_Left = r1.Left
    Pic_top = r1.Top
    If HyperUrl = "" Then HyperUrl = PicUrl
    If PicUrl Like "http*" Or PicUrl Like "\\*" Then
        On Error GoTo N
        'Set p = Sheets(SheetName).Shapes.AddPicture(PicUrl, msoFalse, msoTrue, Pic_Left, Pic_top, V_Width, V_Height)
        
        'Modify By WangXiubao 2013-06-26
        Set p = Sheets(SheetName).Shapes.AddShape(msoShapeRectangle, Pic_Left, Pic_top + 2, V_Width, V_Height)
        p.Fill.UserPicture PicUrl
        p.Line.Visible = msoFalse
        
        p.Name = PicNamePrefix & "_" & Replace(RangeStr, "$", "")
        Sheets(SheetName).Hyperlinks.Add Anchor:=p, Address:=HyperUrl
        p.Placement = xlMove
        p.LockAspectRatio = msoFalse
        
        '    p.ScaleHeight 1, msoTrue
        '    p.ScaleWidth 1, msoTrue
        If p.Height / r1.Height < p.Width / r1.Width Then
            Rate = r1.Height / p.Height
        Else
            Rate = r1.Width / p.Width
        End If
        p.ScaleHeight Rate, msoFalse, msoScaleFromTopLeft
        p.ScaleWidth Rate, msoFalse, msoScaleFromTopLeft
        
        p.LockAspectRatio = msoTrue
        
    End If
N:
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function
Function LoadPicAtCell(SheetName As String, RangeStr As String, PicNamePrefix As String, V_Width As Long, V_Height As Long, PicUrl As String, HyperUrl As String)
    '根据URL地址装载图片，以磅为单位,按比例缩放，单元格大小不随图片调整；
    Dim r1 As Range, r2 As Range, Pic_Left As Long, Pic_top As Long, Pic_Width As Long, Pic_height As Long
    Pic_height = V_Height
    Pic_Width = V_Width * Sheets(SheetName).Range(RangeStr).ColumnWidth / Sheets(SheetName).Range(RangeStr).Width
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    Dim p As Shape, Rate As Double
    Set r1 = Sheets(SheetName).Range(RangeStr)
    Pic_Left = r1.Left
    Pic_top = r1.Top
    If HyperUrl = "" Then HyperUrl = PicUrl
    If PicUrl Like "http*" Then
        'On Error GoTo N
        'Set p = Sheets(SheetName).Shapes.AddPicture(PicUrl, msoFalse, msoTrue, Pic_Left, Pic_top, V_Width, V_Height)
        
        'Modify By WangXiuBao 2013-6-26
        Set p = Sheets(SheetName).Shapes.AddShape(msoShapeRectangle, Pic_Left, Pic_top, V_Width, V_Height)
        p.Fill.UserPicture PicUrl
        p.Line.Visible = msoFalse
        
        p.Name = PicNamePrefix & "_" & Replace(RangeStr, "$", "")
        'MsgBox (p.Name)
        Sheets(SheetName).Hyperlinks.Add Anchor:=p, Address:=HyperUrl
        p.Placement = xlMove
        ' p.LockAspectRatio = msoFalse
        ' p.ScaleHeight 1, msoTrue
        ' p.ScaleWidth 1, msoTrue
        If p.Height / Pic_height < p.Width / Pic_Width Then
            Rate = Pic_height / p.Height
        Else
            Rate = r1.Width / Pic_Width
        End If
        p.ScaleHeight Rate, msoFalse, msoScaleFromTopLeft
        p.ScaleWidth Rate, msoFalse, msoScaleFromTopLeft
        
        p.LockAspectRatio = msoTrue
        
    End If
N:
    If IsSheetProtect Then ProtectSheet SheetName, True
End Function


Function ClearPic(SheetName As String, NameLikeStr As String)
    '清除sheet的所有名称符合条件的图片
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    For Each SP In Sheets(SheetName).Shapes
        
        
        If SP.Type = 1 And UCase(SP.Name) Like UCase(NameLikeStr) Then
            
            SP.Delete
            
        End If
        
        
    Next
    If IsSheetProtect Then ProtectSheet SheetName, True
    
    
End Function
Public Function UrlEncode(ByRef szString As String) As String
    Dim szChar   As String
    Dim szTemp   As String
    Dim szCode   As String
    Dim szHex    As String
    Dim szBin    As String
    Dim iCount1  As Integer
    Dim iCount2  As Integer
    Dim iStrLen1 As Integer
    Dim iStrLen2 As Integer
    Dim lResult  As Long
    Dim lAscVal  As Long
    szString = Trim$(szString)
    iStrLen1 = Len(szString)
    For iCount1 = 1 To iStrLen1
        szChar = Mid$(szString, iCount1, 1)
        lAscVal = AscW(szChar)
        If lAscVal >= &H0 And lAscVal <= &HFF Then
            If (lAscVal >= &H30 And lAscVal <= &H39) Or _
            (lAscVal >= &H41 And lAscVal <= &H5A) Or _
            (lAscVal >= &H61 And lAscVal <= &H7A) Then
            szCode = szCode & szChar
        Else
            
            szCode = szCode & "%" & Hex(AscW(szChar))
        End If
    Else
        szHex = Hex(AscW(szChar))
        iStrLen2 = Len(szHex)
        For iCount2 = 1 To iStrLen2
            szChar = Mid$(szHex, iCount2, 1)
            Select Case szChar
                Case Is = "0"
                szBin = szBin & "0000"
                Case Is = "1"
                szBin = szBin & "0001"
                Case Is = "2"
                szBin = szBin & "0010"
                Case Is = "3"
                szBin = szBin & "0011"
                Case Is = "4"
                szBin = szBin & "0100"
                Case Is = "5"
                szBin = szBin & "0101"
                Case Is = "6"
                szBin = szBin & "0110"
                Case Is = "7"
                szBin = szBin & "0111"
                Case Is = "8"
                szBin = szBin & "1000"
                Case Is = "9"
                szBin = szBin & "1001"
                Case Is = "A"
                szBin = szBin & "1010"
                Case Is = "B"
                szBin = szBin & "1011"
                Case Is = "C"
                szBin = szBin & "1100"
                Case Is = "D"
                szBin = szBin & "1101"
                Case Is = "E"
                szBin = szBin & "1110"
                Case Is = "F"
                szBin = szBin & "1111"
                Case Else
            End Select
        Next iCount2
        szTemp = "1110" & Left$(szBin, 4) & "10" & Mid$(szBin, 5, 6) & "10" & Right$(szBin, 6)
        For iCount2 = 1 To 24
            If Mid$(szTemp, iCount2, 1) = "1" Then
                lResult = lResult + 1 * 2 ^ (24 - iCount2)
                Else: lResult = lResult + 0 * 2 ^ (24 - iCount2)
            End If
        Next iCount2
        szTemp = Hex(lResult)
        szCode = szCode & "%" & Left$(szTemp, 2) & "%" & Mid$(szTemp, 3, 2) & "%" & Right$(szTemp, 2)
    End If
    szBin = vbNullString
    lResult = 0
Next iCount1
UrlEncode = szCode
End Function

Function GetAddressByHead(TableName As String, FieldName As String) As String
    GetAddressByHead = GetSheetNameOfListObject(TableName)
    GetAddressByHead = GetAddressByHead & "!"
    GetAddressByHead = GetAddressByHead & Range(TableName & "[[" & FieldName & "]]").Address()
End Function

Function GetAddressByHead2(TableName As String, FilterFieldName As String, FilterValue As String, ValFieldName As String) As String
    '建立条件下拉，一个字段为筛选字段，一个字段为下拉值字段；
    Dim SheetName As String
    Dim ValueStr As String
    SheetName = GetSheetNameOfListObject(TableName)
    For Each rw In Range(TableName & "[#headers]").Cells(1, 1).ListObject.DataBodyRange.Rows
        If GetValueByHead(TableName, rw.Row, FilterFieldName) = FilterValue _
            And Not (ValueStr Like "【" & GetValueByHead(TableName, rw.Row, ValFieldName) & "】") Then
            ValueStr = ValueStr & "【" & GetValueByHead(TableName, rw.Row, ValFieldName) & "】"
            GetAddressByHead2 = GetAddressByHead2 & "," & GetValueByHead(TableName, rw.Row, ValFieldName)
        End If
    Next
    If Left(GetAddressByHead2, 1) = "," Then GetAddressByHead2 = Mid(GetAddressByHead2, 2, Len(GetAddressByHead2) - 1)
End Function

Function GetColumnNameOfListObject(TableName As String, TypeStr As String) As String
    
    For Each cl In Range(TableName & "[#HEADERS]")
        If UCase(Trim(TypeStr)) = "MIN" Then
            GetColumnNameOfListObject = Replace(cl.Address, cl.Row, "")
            Exit Function
        End If
        
        If UCase(Trim(TypeStr)) = "MAX" Then
            GetColumnNameOfListObject = Replace(cl.Address, cl.Row, "")
        End If
        
    Next
    
End Function

Function GetColumnNameByHead(TableName As String, HeadName As String) As String
    '根据Table列名获取Sheet列名
    Dim I As Integer
    For Each cl In Range(TableName & "[#HEADERS]")
        If UCase(Trim(HeadName)) = UCase(Trim(cl.Value)) Then
            GetColumnNameByHead = GetSheetColumnNameByAddress(cl.Address)
            Exit Function
        End If
        
    Next
End Function

Function GetSheetIsVisible(SheetName As String) As Boolean
    '判断工作表是否被隐藏
    GetSheetIsVisible = Sheets(SheetName).Visible
End Function

Function GetSheetColumnNameByAddress(Adr As String) As String
    '根据地址获取Sheet列名
    Dim I As Integer
    I = InStr(2, Adr, "$")
    GetSheetColumnNameByAddress = Mid(Adr, 2, I - 2)
End Function

Function CopyRecords_Def(SrcTableName As String, DstTableName As String, RowId As Long, ColumnList As String)
    '将源Table的内容插入到目标Table的指定行下;复制指定的行；CloumnList可以是【A】或【A,B】A代表源表列名，B代表目标表列名;列名内部不能有空格
    CopyRecords_Def1 SrcTableName, DstTableName, RowId, ColumnList, False
End Function


Function CopyRecords_Def1(SrcTableName As String, DstTableName As String, RowId As Long, ColumnList As String, WithHead As Boolean)
    '将源Table的内容插入到目标Table的指定行下;复制指定的行；CloumnList可以是【A】或【A,B】A代表源表列名，B代表目标表列名;列名内部不能有空格
    
    Dim IsSheetProtect As Boolean
    
    Dim SrcSheetName As String, DstSheetName As String
    Dim RecordsCount As Long
    SrcSheetName = GetSheetNameOfListObject(SrcTableName)
    DstSheetName = GetSheetNameOfListObject(DstTableName)
    
    IsSheetProtect = GetSheetIsProtect(DstSheetName)
    If IsSheetProtect Then ProtectSheet DstSheetName, False
    
    If WithHead Then
        RecordsCount = GetRowId(SrcTableName, "MAX") - GetRowId(SrcTableName, "MIN") + 2
    Else
        RecordsCount = GetRowId(SrcTableName, "MAX") - GetRowId(SrcTableName, "MIN") + 1
    End If
    Sheets(DstSheetName).Activate
    Sheets(DstSheetName).Range(RowId & ":" & RowId + RecordsCount - 1).Rows.Select
    Selection.Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
    ColumnList = Replace(ColumnList, " ", "")
    Dim ColumnName As String
    
    For Each cl In Range(SrcTableName & "[#headers]")
        ColumnName = cl.Value
        If ColumnList = "" Or ColumnList Like "*【" & ColumnName & "】*" Or ColumnList Like "*【" & ColumnName & ",*】*" Then
            For Each c2 In Range(DstTableName & "[#headers]")
                If ((c2.Value = ColumnName) And (ColumnList = "" Or ColumnList Like "*【" & ColumnName & "】*")) Or (ColumnList Like "*【" & ColumnName & "," & c2.Value & "】*") Then
                    Sheets(SrcSheetName).Activate
                    If WithHead Then
                        Range(Cells(GetRowId(SrcTableName, "min") - 1, Range(SrcTableName & "[[" & ColumnName & "]]").Column).Address & "," & _
                        Range(SrcTableName & "[[" & ColumnName & "]]").Address).Copy
                    Else
                        Range(SrcTableName & "[[" & ColumnName & "]]").Copy
                    End If
                    
                    Sheets(DstSheetName).Activate
                    
                    Range(GetRangeStrByHead(DstTableName, RowId, c2.Value)).Select
                    
                    SetValidationStr Selection, ""
                    ActiveSheet.Paste
                    
                    If WithHead Then
                        
                        
                        
                    End If
                End If
            Next
        End If
    Next
    
    
    If IsSheetProtect Then ProtectSheet DstSheetName, True
End Function

Function SetRangeBorders(TargetRange As Range, BType As String)
    If BType = "无" Then
        TargetRange.Borders(xlDiagonalDown).LineStyle = xlNone
        TargetRange.Borders(xlDiagonalUp).LineStyle = xlNone
        TargetRange.Borders(xlEdgeLeft).LineStyle = xlNone
        TargetRange.Borders(xlEdgeTop).LineStyle = xlNone
        TargetRange.Borders(xlEdgeBottom).LineStyle = xlNone
        TargetRange.Borders(xlEdgeRight).LineStyle = xlNone
        TargetRange.Borders(xlInsideVertical).LineStyle = xlNone
        TargetRange.Borders(xlInsideHorizontal).LineStyle = xlNone
    End If
    
    If BType = "粗闸框线" Then
        TargetRange.Borders(xlDiagonalDown).LineStyle = xlNone
        TargetRange.Borders(xlDiagonalUp).LineStyle = xlNone
        With TargetRange.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlMedium
        End With
        With TargetRange.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlMedium
        End With
        With TargetRange.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlMedium
        End With
        With TargetRange.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ColorIndex = 0
            .TintAndShade = 0
            .Weight = xlMedium
        End With
        TargetRange.Borders(xlInsideVertical).LineStyle = xlNone
        TargetRange.Borders(xlInsideHorizontal).LineStyle = xlNone
    End If
End Function

Function ConvertToNumber(Str1 As String) As Double
    '转换文本到数字
    If Str1 = "" Then
        ConvertToNumber = 0
    Else
        ConvertToNumber = CDbl(Str1)
    End If
End Function

Function SetOleObjectLeft(SheetName As String, ObjectNameA As String, ObjectNameB As String, Gap As Long)
    '设置Oleboject的左起位置，相对于B控件
    Dim IsSheetProtect As Boolean
    IsSheetProtect = GetSheetIsProtect(SheetName)
    If IsSheetProtect Then ProtectSheet SheetName, False
    
    Sheets(SheetName).OLEObjects(ObjectNameB).Left = Gap + Sheets(SheetName).OLEObjects(ObjectNameA).Left + Sheets(SheetName).OLEObjects(ObjectNameA).Width
    
    If IsSheetProtect Then ProtectSheet SheetName, True
    
    
End Function

'---------- by liuhong 20130730 begin ----------------


Function TableIsExists(shName As String) As Boolean
    '判断指定工作表是否存在Table
    If Sheets(shName).ListObjects.Count = 0 Then
        TableIsExists = False
    Else
        TableIsExists = True
    End If
End Function
'---------- by liuhong 20130730 end----------------




