Attribute VB_Name = "A03_LogIn"
Private Sub DoLogin_Click()
ScreenUpdate False
LoginInitialize
Dim Usr1 As String, Pwd1 As String
Usr1 = Me!Usr
Pwd1 = Me!Pwd
If Usr1 = Null Or Usr1 & " " = " " Then
MsgBox "请输入用户名和密码！                     ", vbCritical, "提示"
Me!Usr.SetFocus
Exit Sub
End If


If Pwd1 = Null Or Pwd1 & " " = " " Then
MsgBox "请输入用户名和密码！                     ", vbCritical, "提示"
Me!Pwd.SetFocus
Exit Sub
End If

If CheckLogin_WS(Usr1, Pwd1) = False Then
MsgBox "请输入正确的用户名和密码！            ", vbCritical, "提示"
Me!Usr.SetFocus
Else
LoginAction Usr1
End If
ScreenUpdate True

End Sub

