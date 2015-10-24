taskkill /f /im SendMsgService.exe
taskkill /f /im SMTSendMessage.vshost.exe
Net Stop SMTSendMessage
%SystemRoot%\Microsoft.NET\Framework\v2.0.50727\installutil.exe /u %~dp0SendMsgService.exe
pause