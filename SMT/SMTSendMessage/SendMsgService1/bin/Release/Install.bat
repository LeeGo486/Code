%SystemRoot%\Microsoft.NET\Framework\v2.0.50727\installutil.exe %~dp0SendMsgService.exe
Net Start SMTSendMessage
sc config SMTSendMessage start= auto
pause