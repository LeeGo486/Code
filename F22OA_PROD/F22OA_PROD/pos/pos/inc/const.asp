<%session("skindir")="default"

function screnc(str1)
dim str2,seed,i,c,ac
    str2=StrReverse(str1) 
    length=len(str2) 
    for i=1 to length 
         c=mid(str2,i,1) 
         ac=asc(c)-20 
         seed=seed&ac&"O" 
    next 
screnc=seed 
end function 

function unscrenc(str1) 
dim str2,seed,i
    str2=split(str1,"O") 
    for i=0 to ubound(str2)-1 
         seed=seed&chr(cint(str2(i))+20)
    next
unscrenc=StrReverse(seed) 
end function
 
'ȡ�ñ�׼���ڸ�ʽ
function get_date(tdate)
dim tdate1,tdate2,tdate3
if len(tdate)<>10 then
   if len(tdate)=8 then
      tdate1=left(tdate,5)
	  tdate2=mid(tdate,6,2)
	  tdate3=mid(tdate,8,1)
	  tdate=tdate1&"0"&tdate2&"0"&tdate3
   else
      if mid(tdate,7,1)="-" then
         tdate1=left(tdate,5)
         tdate2=mid(tdate,6)
         tdate=tdate1&"0"&tdate2
      else
	     tdate1=left(tdate,8)
		 tdate2=mid(tdate,9)
		 tdate=tdate1&"0"&tdate2
	  end if
   end if
end if
get_date=tdate
end function

'SQLע�����
Function SafeRequest(ParaName,ParaType)
       '--- ������� ---
       'ParaName:��������-�ַ���
       'ParaType:��������-������(1��ʾ���ϲ��������֣�0��ʾ���ϲ���Ϊ�ַ�)
       If ParaType=1 then
              If not isNumeric(ParaName) then
                     Response.write "����" & ParaName & "����Ϊ�����ͣ�"
                     Response.end
              End if
       Else
              ParaName=replace(ParaName,"'","''")
       End if
       SafeRequest=ParaName
End function

Public Sub head(title)
with response
 .write("<html><head>")
 .write("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>")
 .write("<link href='../skin/"&session("skindir")&"/default.css' rel='stylesheet' type='text/css'>")
 .write("<title>"&title&"</title></head>")
end with
End sub

Public Sub footer()
with response
 .write("</body></html>")
end with
end sub%>