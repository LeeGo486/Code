<% 

response.charset="UTF-8" 
reg="\<meta.+ charset= {0,}([^\"" \>\/]*).+\/{0,1}\>" 
'函数名:GetResStr 
'作用:获取指定URL的HTML代码 
'参数:URL-要获取的URL 
function GetResStr(URL) 
err.clear 
dim ResBody,ResStr,PageCode,ReturnStr 
Set Http=createobject("MiCROSOFT.XMLHTTP") 
Http.open "post",URL,False 
Http.Send() 
If Http.Readystate =4 Then 
If Http.status=200 Then 
ResStr=http.responseText 
ResBody=http.responseBody 
PageCode=GetCode(ResStr,reg) 
ReturnStr=BytesToBstr(http.responseBody,PageCode) 
GetResStr=ReturnStr 
End If 
End If 
End Function 

'函数名:BytesToBstr 
'作用:转换二进制数据为字符 
'参数:Body-二进制数据,Cset-文本编码方式 
Function BytesToBstr(Body,Cset) 
Dim Objstream 
Set Objstream = CreateObject("adodb.stream") 
objstream.Type = 1 
objstream.Mode =3 
objstream.Open 
objstream.Write body 
objstream.Position = 0 
objstream.Type = 2 
objstream.Charset =Cset 
BytesToBstr = objstream.ReadText 
objstream.Close 
set objstream = nothing 
End Function 

'函数名:GetCode 
'作用:转换二进制为字符 
'参数:str-待查询字符串,regstr-正则表达式 
Function GetCode(str,regstr) 
Dim Reg,serStr 
set Reg= new RegExp 
Reg.IgnoreCase = True 
Reg.MultiLine = True 
Reg.Pattern =regstr 
if Reg.test(str) then '若查询到匹配项 
Set Cols = Reg.Execute(str) 
serStr=Cols(0).SubMatches(0) '使用匹配到的第一个匹配项 
else '否则给个默认值gb2312,有点省懒法，如果页面没给出编码格式，想知道确实有点麻烦 
serStr="UTF-8" 
end if 
GetCode=serStr 
end function 

dim url:url=request.querystring("url") 
response.write GetResStr(URL) 
%> 
