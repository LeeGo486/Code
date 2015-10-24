<script language="JScript" runAt="server">

// MD5 SHA1 共用
function add(x, y)
{
  return ((x&0x7FFFFFFF) + (y&0x7FFFFFFF)) ^ (x&0x80000000) ^ (y&0x80000000);
}

// MD5
function MD5hex(i)
{
  var sHex = "0123456789abcdef"
  h = "";
  for(j = 0; j <= 3; j++)
  {
    h += sHex.charAt((i >> (j * 8 + 4)) & 0x0F) +
         sHex.charAt((i >> (j * 8)) & 0x0F);
  }
  return h;
}

function R1(A, B, C, D, X, S, T)
{
  q = add(add(A, (B & C) | (~B & D)), add(X, T));
  return add((q << S) | ((q >> (32 - S)) & (Math.pow(2, S) - 1)), B);
}

function R2(A, B, C, D, X, S, T)
{
  q = add(add(A, (B & D) | (C & ~D)), add(X, T));
  return add((q << S) | ((q >> (32 - S)) & (Math.pow(2, S) - 1)), B);
}

function R3(A, B, C, D, X, S, T)
{
  q = add(add(A, B ^ C ^ D), add(X, T));
  return add((q << S) | ((q >> (32 - S)) & (Math.pow(2, S) - 1)), B);
}

function R4(A, B, C, D, X, S, T)
{
  q = add(add(A, C ^ (B | ~D)), add(X, T));
  return add((q << S) | ((q >> (32 - S)) & (Math.pow(2, S) - 1)), B);
}

function MD5(sInp) {
  var sAscii = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
  wLen = (((sInp.length + 8) >> 6) + 1) << 4;
  var X = new Array(wLen);

  j = 4;
  for (i = 0; (i * 4) < sInp.length; i++)
  {
    X[i] = 0;
    for (j = 0; (j < 4) && ((j + i * 4) < sInp.length); j++)
    {
      X[i] += (sAscii.indexOf(sInp.charAt((i * 4) + j)) + 32) << (j * 8);
    }
  }

  if (j == 4)
  {
    X[i++] = 0x80;
  }
  else
  {
    X[i - 1] += 0x80 << (j * 8);
  }
  for(; i < wLen; i++) { X[i] = 0; }
  X[wLen - 2] = sInp.length * 8;

  a = 0x67452301;
  b = 0xefcdab89;
  c = 0x98badcfe;
  d = 0x10325476;

  for (i = 0; i < wLen; i += 16) {
    aO = a;
    bO = b;
    cO = c;
    dO = d;

    a = R1(a, b, c, d, X[i+ 0], 7 , 0xd76aa478);
    d = R1(d, a, b, c, X[i+ 1], 12, 0xe8c7b756);
    c = R1(c, d, a, b, X[i+ 2], 17, 0x242070db);
    b = R1(b, c, d, a, X[i+ 3], 22, 0xc1bdceee);
    a = R1(a, b, c, d, X[i+ 4], 7 , 0xf57c0faf);
    d = R1(d, a, b, c, X[i+ 5], 12, 0x4787c62a);
    c = R1(c, d, a, b, X[i+ 6], 17, 0xa8304613);
    b = R1(b, c, d, a, X[i+ 7], 22, 0xfd469501);
    a = R1(a, b, c, d, X[i+ 8], 7 , 0x698098d8);
    d = R1(d, a, b, c, X[i+ 9], 12, 0x8b44f7af);
    c = R1(c, d, a, b, X[i+10], 17, 0xffff5bb1);
    b = R1(b, c, d, a, X[i+11], 22, 0x895cd7be);
    a = R1(a, b, c, d, X[i+12], 7 , 0x6b901122);
    d = R1(d, a, b, c, X[i+13], 12, 0xfd987193);
    c = R1(c, d, a, b, X[i+14], 17, 0xa679438e);
    b = R1(b, c, d, a, X[i+15], 22, 0x49b40821);

    a = R2(a, b, c, d, X[i+ 1], 5 , 0xf61e2562);
    d = R2(d, a, b, c, X[i+ 6], 9 , 0xc040b340);
    c = R2(c, d, a, b, X[i+11], 14, 0x265e5a51);
    b = R2(b, c, d, a, X[i+ 0], 20, 0xe9b6c7aa);
    a = R2(a, b, c, d, X[i+ 5], 5 , 0xd62f105d);
    d = R2(d, a, b, c, X[i+10], 9 ,  0x2441453);
    c = R2(c, d, a, b, X[i+15], 14, 0xd8a1e681);
    b = R2(b, c, d, a, X[i+ 4], 20, 0xe7d3fbc8);
    a = R2(a, b, c, d, X[i+ 9], 5 , 0x21e1cde6);
    d = R2(d, a, b, c, X[i+14], 9 , 0xc33707d6);
    c = R2(c, d, a, b, X[i+ 3], 14, 0xf4d50d87);
    b = R2(b, c, d, a, X[i+ 8], 20, 0x455a14ed);
    a = R2(a, b, c, d, X[i+13], 5 , 0xa9e3e905);
    d = R2(d, a, b, c, X[i+ 2], 9 , 0xfcefa3f8);
    c = R2(c, d, a, b, X[i+ 7], 14, 0x676f02d9);
    b = R2(b, c, d, a, X[i+12], 20, 0x8d2a4c8a);

    a = R3(a, b, c, d, X[i+ 5], 4 , 0xfffa3942);
    d = R3(d, a, b, c, X[i+ 8], 11, 0x8771f681);
    c = R3(c, d, a, b, X[i+11], 16, 0x6d9d6122);
    b = R3(b, c, d, a, X[i+14], 23, 0xfde5380c);
    a = R3(a, b, c, d, X[i+ 1], 4 , 0xa4beea44);
    d = R3(d, a, b, c, X[i+ 4], 11, 0x4bdecfa9);
    c = R3(c, d, a, b, X[i+ 7], 16, 0xf6bb4b60);
    b = R3(b, c, d, a, X[i+10], 23, 0xbebfbc70);
    a = R3(a, b, c, d, X[i+13], 4 , 0x289b7ec6);
    d = R3(d, a, b, c, X[i+ 0], 11, 0xeaa127fa);
    c = R3(c, d, a, b, X[i+ 3], 16, 0xd4ef3085);
    b = R3(b, c, d, a, X[i+ 6], 23,  0x4881d05);
    a = R3(a, b, c, d, X[i+ 9], 4 , 0xd9d4d039);
    d = R3(d, a, b, c, X[i+12], 11, 0xe6db99e5);
    c = R3(c, d, a, b, X[i+15], 16, 0x1fa27cf8);
    b = R3(b, c, d, a, X[i+ 2], 23, 0xc4ac5665);

    a = R4(a, b, c, d, X[i+ 0], 6 , 0xf4292244);
    d = R4(d, a, b, c, X[i+ 7], 10, 0x432aff97);
    c = R4(c, d, a, b, X[i+14], 15, 0xab9423a7);
    b = R4(b, c, d, a, X[i+ 5], 21, 0xfc93a039);
    a = R4(a, b, c, d, X[i+12], 6 , 0x655b59c3);
    d = R4(d, a, b, c, X[i+ 3], 10, 0x8f0ccc92);
    c = R4(c, d, a, b, X[i+10], 15, 0xffeff47d);
    b = R4(b, c, d, a, X[i+ 1], 21, 0x85845dd1);
    a = R4(a, b, c, d, X[i+ 8], 6 , 0x6fa87e4f);
    d = R4(d, a, b, c, X[i+15], 10, 0xfe2ce6e0);
    c = R4(c, d, a, b, X[i+ 6], 15, 0xa3014314);
    b = R4(b, c, d, a, X[i+13], 21, 0x4e0811a1);
    a = R4(a, b, c, d, X[i+ 4], 6 , 0xf7537e82);
    d = R4(d, a, b, c, X[i+11], 10, 0xbd3af235);
    c = R4(c, d, a, b, X[i+ 2], 15, 0x2ad7d2bb);
    b = R4(b, c, d, a, X[i+ 9], 21, 0xeb86d391);

    a = add(a, aO);
    b = add(b, bO);
    c = add(c, cO);
    d = add(d, dO);
  }
  
  	MD5Value=MD5hex(a) + MD5hex(b) + MD5hex(c) + MD5hex(d);
  	return MD5Value.toUpperCase();
}


// SHA1

function SHA1hex(num)
{
  var sHEXChars="0123456789abcdef";
  var str="";
  for(var j=7;j>=0;j--)
    str+=sHEXChars.charAt((num>>(j*4))&0x0F);
  return str;
}

function AlignSHA1(sIn){
  var nblk=((sIn.length+8)>>6)+1, blks=new Array(nblk*16);
  for(var i=0;i<nblk*16;i++)blks[i]=0;
  for(i=0;i<sIn.length;i++)
    blks[i>>2]|=sIn.charCodeAt(i)<<(24-(i&3)*8);
  blks[i>>2]|=0x80<<(24-(i&3)*8);
  blks[nblk*16-1]=sIn.length*8;
  return blks;
}


function rol(num,cnt){
  return(num<<cnt)|(num>>>(32-cnt));
}

function ft(t,b,c,d){
  if(t<20)return(b&c)|((~b)&d);
  if(t<40)return b^c^d;
  if(t<60)return(b&c)|(b&d)|(c&d);
  return b^c^d;
}

function kt(t) {
  return(t<20)?1518500249:(t<40)?1859775393:
    (t<60)?-1894007588:-899497514;
}

function SHA1(sIn)
{
  var x=AlignSHA1(sIn);
  var w=new Array(80);
  var a=1732584193;
  var b=-271733879;
  var c=-1732584194;
  var d=271733878;
  var e=-1009589776;
  for(var i=0;i<x.length;i+=16){
    var olda=a;
    var oldb=b;
    var oldc=c;
    var oldd=d;
    var olde=e;
    for(var j=0;j<80;j++){
      if(j<16)w[j]=x[i+j];
      else w[j]=rol(w[j-3]^w[j-8]^w[j-14]^w[j-16],1);
      t=add(add(rol(a,5),ft(j,b,c,d)),add(add(e,w[j]),kt(j)));
      e=d;
      d=c;
      c=rol(b,30);
      b=a;
      a=t;
    }
    a=add(a,olda);
    b=add(b,oldb);
    c=add(c,oldc);
    d=add(d,oldd);
    e=add(e,olde);
  }
    SHA1Value=SHA1hex(a)+SHA1hex(b)+SHA1hex(c)+SHA1hex(d)+SHA1hex(e);
  	return SHA1Value.toUpperCase();
}

</script>
<%
Function Execute(Command)
	'Response.Write Command&"<p>"
	Set Execute = Conn.Execute(Command)
	SqlQueryNum = SqlQueryNum + 1
End Function


''''''''''''''''''''''''''''''''''''
Class AutoTerminate_Class
	Private Sub Class_Terminate
		If Err.Number<>995 and Err.Number<>0 then log(""&Err.Source&" ("&Err.Number&")&lt;br&gt;"&Err.Description&"")
		Conn.Close
		Set Rs = Nothing
		Set Conn = Nothing
		Set XMLDOM = Nothing
		Set SiteConfigXMLDOM = Nothing
	End Sub
End Class

''''''''''''''''''''''''''''''''''''
Function SelectSingleNode(str)
	str=XMLDOM.documentElement.SelectSingleNode(str).text
	SelectSingleNode=str
End Function

Function SiteConfig(str)
	TextStr=SiteConfigXMLDOM.documentElement.SelectSingleNode(str).text
	if IsNumeric(TextStr) then
		str=int(TextStr)	'转化为数字类型
		if Len(str)<>Len(TextStr) then	str=TextStr	'防止数字前面的 0 消失掉
	else
		str=TextStr
	End If
	SiteConfig=str
End Function



''''''''''''''''''''''''''''''''''''
Function HTMLEncode(fString)

	fString=Trim(fString)
	fString=Replace(fString,CHR(9),"")
	fString=Replace(fString,CHR(13),"")
	fString=Replace(fString,CHR(22),"")
	fString=Replace(fString,CHR(38),"&#38;")	'“&”
	fString=Replace(fString,CHR(32),"&#32;")	'“ ”
	fString=Replace(fString,CHR(34),"&#34;")	'“"”
	fString=Replace(fString,CHR(39),"&#39;")	'“'”
	fString=Replace(fString,CHR(42)&CHR(42),"&#42;&#42;")	'“**”/**/
	fString=Replace(fString,CHR(44),"&#44;")	'“,”
	fString=Replace(fString,CHR(60),"&#60;")	'“<”
	fString=Replace(fString,CHR(62),"&#62;")	'“>”
	fString=Replace(fString,CHR(92),"&#92;")	'“\”
	fString=Replace(fString,CHR(45)&CHR(45),"&#45;&#45;")	'“--”
	fString=Replace(fString,CHR(59),"&#59;")	'“;”
	fString=Replace(fString,CHR(10),"<br>")
	fString=ReplaceText(fString,"([&#])([a-z0-9]*)&#59;","$1$2;")

	if SiteConfig("BannedText")<>"" then fString=ReplaceText(fString,"("&SiteConfig("BannedText")&")",string(len("&$1&"),"*"))

	if IsSqlDataBase=0 then '过滤片假名(日文字符)[\u30A0-\u30FF] by yuzi
		fString=escape(fString)
		fString=ReplaceText(fString,"%u30([A-F][0-F])","&#x30$1;")
		fString=unescape(fString)
	end if

	HTMLEncode=fString
End Function
''''''''''''''''''''''''''''''''''''
Function BodyEncode(fString)
	fString=Replace(fString,vbCrlf, "")
	fString=Replace(fString,"\","&#92;")
	fString=Replace(fString,"'","&#39;")
	fString=Replace(fString,"<a href=","<a target=_blank href=") '点链接打开新窗口
	if SiteConfig("BannedHtmlLabel")<>"" then fString=ReplaceText(fString,"<(\/|)("&SiteConfig("BannedHtmlLabel")&")", "&lt;$1$2")
	if SiteConfig("BannedHtmlEvent")<>"" then fString=ReplaceText(fString,"<(.[^>]*)("&SiteConfig("BannedHtmlEvent")&")", "&lt;$1$2")
	if SiteConfig("BannedText")<>"" then fString=ReplaceText(fString,"("&SiteConfig("BannedText")&")",string(len("&$1&"),"*"))
	BodyEncode=fString
End Function
''''''''''''''''''''''''''''''''''''
Function YbbEncode(str)
	str=ReplaceText(str,"\[(\/|)(b|i|u|strike|center|marquee)\]","<$1$2>")
	str=ReplaceText(str,"\[COLOR=([^[]*)\]","<FONT COLOR=$1>")
	str=ReplaceText(str,"\[FONT=([^[]*)\]","<FONT face=$1>")
	str=ReplaceText(str,"\[SIZE=([0-9]*)\]","<FONT size=$1>")
	str=ReplaceText(str,"\[\/(SIZE|FONT|COLOR)\]","</FONT>")
	str=ReplaceText(str,"\[URL\]([^[]*)","<A TARGET=_blank HREF=$1>$1")
	str=ReplaceText(str,"\[URL=([^[]*)\]","<A TARGET=_blank HREF=$1>")
	str=ReplaceText(str,"\[\/URL\]","</A>")
	str=ReplaceText(str,"\[EMAIL\](\S+\@[^[]*)(\[\/EMAIL\])","<a href=mailto:$1>$1</a>")
	str=ReplaceText(str,"\[IMG\]([^("&CHR(34)&"|[|#)]*)(\[\/IMG\])","<img border=0 src=$1>")
	str=ReplaceText(str,"\[quote\]","<blockquote>")
	str=ReplaceText(str,"\[quote user="&CHR(34)&"([^[]*)"&CHR(34)&"\]","<blockquote><img border=0 src=images/icon-quote.gif> <b>$1:</b><br>")
	str=ReplaceText(str,"\[\/quote\]","</blockquote>")
	YbbEncode=str
End Function

''''''''''''''''''''''''''''''''''''
Function RequestInt(fString)

	RequestInt=Request(fString)

	if IsNumeric(RequestInt) then
		RequestInt=int(RequestInt)
	else
		RequestInt=0
	end if

End Function

''''''''''替换模块START''''''''''''
Function ReplaceText(fString,patrn,replStr)
	Set regEx = New RegExp   	' 建立正则表达式。
		regEx.Pattern = patrn   ' 设置模式。
		regEx.IgnoreCase = True ' 设置是否区分大小写。
		regEx.Global = True     ' 设置全局可用性。 
		ReplaceText = regEx.Replace(""&fString&"",""&replStr&"") ' 作替换。
	Set regEx=nothing
End Function
''''''''''替换模块END''''''''''''
Function ResponseCookies(Key,Value,Expires)

	Response.Cookies("bbsxp")(Key) = ""&Value&""
	'Response.Cookies(Key).Path = SiteConfig("CookiePath")&"/oa/bbsxp/"
	'if int(Expires)>0 then Response.Cookies("bbsxp")(Key).Expires = date+Expires
	'注销原因：存在Cookies冲突

End Function
'''''''''''''''''''''''''''''''''''''''''''
Function RequestCookies(CookieName)

	RequestCookies=Request.Cookies("bbsxp")(CookieName)

End Function
'''''''''''''''''''''''''''''''''''''''''''
Function CleanCookies()

	For Each objCookie In Request.Cookies("bbsxp")
		ResponseCookies objCookie,"",0
	Next

End Function

'''''''''''''''''''''''''''''''''''''''''''
'写入Application
Function ResponseApplication(Key,Value)
	Application(SiteConfig("CacheName")&"_"&Key) = Value
End Function

'读取Application
Function RequestApplication(Key)
	RequestApplication=Application(SiteConfig("CacheName")&"_"&Key)
End Function

'删除Application
Function RemoveApplication(Key)
	Application.Contents.Remove(SiteConfig("CacheName")&"_"&Key)
End Function

'追加Application
Function AddApplication(Key,Value)
	Application(SiteConfig("CacheName")&"_"&Key) = Application(SiteConfig("CacheName")&"_"&Key)&Value&"<br>"
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function GetEmploymentStatusList(Key,SQL)
   strLastUpdate = RequestApplication(Key&"_LastUpdate")
   
   If strLastUpdate = "" Or SiteConfig("CacheUpDateInterval") < DateDiff("n",strLastUpdate,Now()) Then
      Application.Lock
      ResponseApplication Key,FetchEmploymentStatusList(SQL)
      ResponseApplication Key&"_LastUpdate",CStr(Now)
      Application.Unlock
   End If
   GetEmploymentStatusList = RequestApplication(Key)
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function FetchEmploymentStatusList(SQL)
	Set Rs2=Execute(SQL)
	if Rs2.Eof then
		Rs2.Close
		Set Rs2 = Nothing
		Exit Function
	End if
  	FetchEmploymentStatusList = Rs2.GetRows()
	Rs2.Close
	Set Rs2 = Nothing
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	On Error GoTo 0
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function DelFile(DelFilePath)
	On Error Resume Next
	DelFile= False
	Set MyFileObject=Server.CreateOBject("Scripting.FileSystemObject")
	MyFileObject.DeleteFile""&Server.MapPath(""&DelFilePath&"")&""
	Set MyFileObject= Nothing
	If 0 = Err or 53 = Err Then
		DelFile= True
	else
		Alert("出错讯息："&Err.Description&"\n"&DelFilePath&" 无法删除！")
	end if
	On Error GoTo 0
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function CheckSize(ByteSize)
	if ByteSize=>1073741824 then
		ByteSize=formatnumber(ByteSize/1073741824)&" GB"
	elseif ByteSize=>1048576 then
		ByteSize=formatnumber(ByteSize/1048576)&" MB"
	elseif ByteSize=>1024 then
		ByteSize=formatnumber(ByteSize/1024)&" KB"
	else
		ByteSize=ByteSize&" 字节"
	end if
	CheckSize=ByteSize
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function ShowRole(value)
	select case value
		case "1"
			ShowRole="管理员"
		case "2"
			ShowRole="超级版主"
		case "3"
			ShowRole="注册用户"
		case else
			ShowRole=Execute("Select Name From [BBSXP_Roles] where RoleID="&value&"")(0)
	end select
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function ShowUserAccountStatus(value)
	select case value
		case "0"
			ShowUserAccountStatus="正等待审核"
		case "1"
			ShowUserAccountStatus="已通过审核"
		case "2"
			ShowUserAccountStatus="已禁用"
		case "3"
			ShowUserAccountStatus="未通过审核"
		case else
			ShowUserAccountStatus="未知状态"
	end select
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function ShowUserSex(value)
if SiteConfig("AllowGender")=1 then
	select case value
		case 0
			ShowUserSex=""
		case 1
			ShowUserSex="<img src=images/Sex_1.gif title='男'>"
		case 2
			ShowUserSex="<img src=images/Sex_2.gif title='女'>"
	end select
end if
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function Zodiac(birthday)
	if IsDate(birthday) then
		birthyear=year(birthday)
		ZodiacList=array("猴(Monkey)","鸡(Rooster)","狗(Dog)","猪(Boar)","鼠(Rat)","牛(Ox)","虎(Tiger)","兔(Rabbit)","龙(Dragon)","蛇(Snake)","马(Horse)","羊(Goat)")
		Zodiac=ZodiacList(birthyear mod 12)
	end if
End Function
'''''''''''''''''''''''''''''''''''''''''''
Function Horoscope(birthday)
	if IsDate(birthday) then
		HoroscopeMon=month(birthday)
		HoroscopeDay=day(birthday)
		if Len(HoroscopeMon)<2 then HoroscopeMon="0"&HoroscopeMon
		if Len(HoroscopeDay)<2 then HoroscopeDay="0"&HoroscopeDay
		MyHoroscope=HoroscopeMon&HoroscopeDay
		if MyHoroscope < 0120 then
			Horoscope="<img src=images/Horoscope/Capricorn.gif title='魔羯座 Capricorn'>"
		elseif MyHoroscope < 0219 then
			Horoscope="<img src=images/Horoscope/Aquarius.gif title='水瓶座 Aquarius'>"
		elseif MyHoroscope < 0321 then
			Horoscope="<img src=images/Horoscope/Pisces.gif title='双鱼座 Pisces'>"
		elseif MyHoroscope < 0420 then
			Horoscope="<img src=images/Horoscope/Aries.gif title='白羊座 Aries'>"
		elseif MyHoroscope < 0521 then
			Horoscope="<img src=images/Horoscope/Taurus.gif title='金牛座 Taurus'>"
		elseif MyHoroscope < 0622 then
			Horoscope="<img src=images/Horoscope/Gemini.gif title='双子座 Gemini'>"
		elseif MyHoroscope < 0723 then
			Horoscope="<img src=images/Horoscope/Cancer.gif title='巨蟹座 Cancer'>"
		elseif MyHoroscope < 0823 then
			Horoscope="<img src=images/Horoscope/Leo.gif title='狮子座 Leo'>"
		elseif MyHoroscope < 0923 then
			Horoscope="<img src=images/Horoscope/Virgo.gif title='处女座 Virgo'>"
		elseif MyHoroscope < 1024 then
			Horoscope="<img src=images/Horoscope/Libra.gif title='天秤座 Libra'>"
		elseif MyHoroscope < 1122 then
			Horoscope="<img src=images/Horoscope/Scorpio.gif title='天蝎座 Scorpio'>"
		elseif MyHoroscope < 1222 then
			Horoscope="<img src=images/Horoscope/Sagittarius.gif title='射手座 Sagittarius'>"
		elseif MyHoroscope > 1221 then
			Horoscope="<img src=images/Horoscope/Capricorn.gif title='魔羯座 Capricorn'>"
		end if
	end if
End Function

Function ShowReputation(value)
		if value < 1 then
			Reputation=""
		elseif value < 251 then
			ShowReputation="<img src=images/ReputationA.gif title='"&value&"声望' >"
		elseif value < 10001 then
			ShowReputation="<img src=images/ReputationB.gif title='"&value&"声望' >"
		elseif value > 10000 then
			ShowReputation="<img src=images/ReputationC.gif title='"&value&"声望' >"
		end if
End Function


'针对中文日期格式的服务器
Function FormatTime(value)
	FormatTime=""&FormatDateTime(value, 2)&" "&FormatDateTime(value, 4)&":"&second(value)&""
End Function

Function DefaultPasswordFormat(value)
	if SiteConfig("DefaultPasswordFormat")="MD5" then
		DefaultPasswordFormat=MD5(value)
	Else
		DefaultPasswordFormat=SHA1(value)
	End if
End Function



'''''''''''''''''''''''''''''''''''''''''''
Function GroupList(ParentID)
	GroupListGetRow=FetchEmploymentStatusList("Select GroupID,GroupName from [BBSXP_Groups] where SortOrder>0 order by SortOrder")
	if IsArray(GroupListGetRow) then 
	for i=0 to Ubound(GroupListGetRow,2)
		ForumsList=ForumsList&"<optgroup label='"&GroupListGetRow(1,i)&"'>"
		ii=ii+1
		ForumList GroupListGetRow(0,i),0,ParentID
		ii=ii-1
		ForumsList=ForumsList&"</optgroup>"
	next
	GroupList=ForumsList
	End if
End Function

Function ForumList(GroupID,ParentID,Selected)
	sql="Select ForumID,ForumName From [BBSXP_Forums] where GroupID="&GroupID&" and ParentID="&ParentID&" and SortOrder>0 and IsActive=1 order by SortOrder"
	Set Rs1=Execute(sql)
		Do While Not Rs1.EOF
			if RS1("ForumID")=Selected then
				ForumsList=ForumsList&"<option value='"&RS1("ForumID")&"' selected>"&string(ii,"　")&"-&raquo; "&RS1("ForumName")&"</option>"
			else
				ForumsList=ForumsList&"<option value='"&RS1("ForumID")&"'>"&string(ii,"　")&"-&raquo; "&RS1("ForumName")&"</option>"
			end if
			ii=ii+1
			ForumList GroupID,RS1("ForumID"),Selected
			ii=ii-1
		Rs1.MoveNext
		loop
	Rs1.Close
	Set Rs1 = Nothing
End Function

Function ForumTree(selec)
	if selec=0 then
		Set Rs1=Execute("Select * from [BBSXP_Groups] where GroupID="&GroupID&"")
		if not Rs1.eof then
			ForumTreeList="<span id=TempGroup"&GroupID&"><a onmouseover=Ajax_CallBack(false,'TempGroup"&GroupID&"','loading.asp?menu=ForumTree&GroupID="&GroupID&"') href=Default.asp?GroupID="&Rs1("GroupID")&">"&Rs1("GroupName")&"</a></span> → "&ForumTreeList&""
		end if
	else
		Set Rs1=Execute("Select * From [BBSXP_Forums] where ForumID="&selec&"")
		if not Rs1.eof then
			ForumTreeList="<span id=tempForum"&selec&"><a onmouseover=Ajax_CallBack(false,'tempForum"&selec&"','loading.asp?menu=ForumTree&ParentID="&selec&"') href=ShowForum.asp?ForumID="&Rs1("ForumID")&">"&Rs1("ForumName")&"</a></span> → "&ForumTreeList&""
			ForumTree Rs1("ParentID")
		end if
	end if
	Rs1.Close
	Set Rs1 = Nothing
	ForumTree=ForumTreeList
End Function



Function ClubTree()
	Set Rs1=Execute("Select * From [BBSXP_Groups] where SortOrder>0 order by SortOrder")
	do while not Rs1.eof
		ClubTreeList=ClubTreeList&"<div class=menuitems><a href=Default.asp?GroupID="&Rs1("GroupID")&">"&Rs1("GroupName")&"</a></div>"
		Rs1.Movenext
	loop
	Rs1.Close
	Set Rs1 = Nothing
	response.write "<a onmouseover="&Chr(34)&"showmenu(event,'"&ClubTreeList&"')"&Chr(34)&" href=Default.asp>"&SiteConfig("SiteName")&"</a>" 
End Function



'''''''''''''''''''''''''''''''''''''''''''
Sub ShowRank(experience)
	sql="Select top 1 * From [BBSXP_Ranks] where PostingCountMin<="&experience&" order by PostingCountMin Desc"
	Set UserRank=Execute(sql)
		if UserRank.eof then
			RankName="未知等级"
			RankIconUrl="images/level/0.gif"
		else
			RankName=UserRank("RankName")
			RankIconUrl=UserRank("RankIconUrl")
		end if
	Set UserRank = Nothing
End Sub

''''''''''''''''''''''''''''''''
Sub ConciseMsg(Message)
	Response.write(Message)	
	Response.End
End Sub
''''''''''''''''''''''''
Sub Log(Message)
	MessageXML=MessageXML&"<Message>"&Message&"</Message>"&vbCrlf
	MessageXML=MessageXML&"<REMOTE_ADDR>"&REMOTE_ADDR&"</REMOTE_ADDR>"&vbCrlf
	MessageXML=MessageXML&"<Request_Method>"&Escape(Request.ServerVariables("Request_method"))&"</Request_Method>"&vbCrlf
	MessageXML=MessageXML&"<Server_Name>"&Escape(Request.ServerVariables("server_name"))&"</Server_Name>"&vbCrlf
	MessageXML=MessageXML&"<Script_Name>"&Escape(Request.ServerVariables("script_name"))&"</Script_Name>"&vbCrlf
	MessageXML=MessageXML&"<Query_String>"&Escape(Request.ServerVariables("Query_String"))&"</Query_String>"&vbCrlf
	MessageXML=MessageXML&"<Request_Form>"&Escape(Request.Form)&"</Request_Form>"&vbCrlf
	MessageXML=MessageXML&"<All_Http>"&Escape(Request.ServerVariables("All_Http"))&"</All_Http>"&vbCrlf

	Execute("insert into [BBSXP_EventLog] (UserName,ErrNumber,MessageXML) values ('"&CookieUserName&"','"&Err.Number&"','"&MessageXML&"')")
End Sub
''''''''''''''''''''''''''''''''



Sub UpdateStatistics(DaysUsers,DaysTopics,DaysPosts)

	sql="Select * from [BBSXP_Statistics] where DateDiff("&SqlChar&"d"&SqlChar&",DateCreated,"&SqlNowString&")=0"
	Rs.open sql,conn,1,3
	if Rs.eof then
		Rs.Addnew
		
		TotalUsers=Execute("Select count(UserID) from [BBSXP_Users]")(0)
		TotalTopics=Execute("Select count(ThreadID) from [BBSXP_Threads] where IsDel=0")(0)
		TotalPosts=Execute("Select sum(TotalReplies) as TotalPosts from [BBSXP_Threads] where IsDel=0")(0)
		
		
		if IsNull(TotalPosts) then
		TotalPosts=0
		else
		NewestUserName=Execute("Select Top 1 UserName from [BBSXP_Users] order by UserID desc")(0)
		end if

		Rs("TotalUsers")=TotalUsers
		Rs("TotalTopics")=TotalTopics
		Rs("TotalPosts")=TotalPosts
		Rs("NewestUserName")=NewestUserName
		
		Execute("update [BBSXP_Forums] Set TodayPosts=0")
		Rs("DaysUsers")=Rs("DaysUsers")+int(DaysUsers)
		Rs("DaysTopics")=Rs("DaysTopics")+int(DaysTopics)
		Rs("DaysPosts")=Rs("DaysPosts")+int(DaysPosts)
		Rs("DateCreated")=date()
	else
		Rs("TotalUsers")=Rs("TotalUsers")+DaysUsers
		Rs("TotalTopics")=Rs("TotalTopics")+DaysTopics
		Rs("TotalPosts")=Rs("TotalPosts")+DaysPosts
		Rs("DaysUsers")=Rs("DaysUsers")+DaysUsers
		Rs("DaysTopics")=Rs("DaysTopics")+DaysTopics
		Rs("DaysPosts")=Rs("DaysPosts")+DaysPosts
	end if
	Rs.update
	Rs.close
End Sub



Sub UpForumMostRecent(ForumID)
		sql="Select top 1 * from [BBSXP_Threads] where ForumID="&ForumID&" and IsApproved=1 and IsDel=0 order by LastTime DESC"
		Set Rs2=Execute(sql)
		if Rs2.Eof then Exit sub
		MostRecentThreadID=Rs2("ThreadID")
		MostRecentPostSubject=ReplaceText(Rs2("Topic"),"<[^>]*>","")
		MostRecentPostAuthor=Rs2("LastName")
		MostRecentPostDate=Rs2("LastTime")
		Set Rs2 = Nothing
		Execute("update [BBSXP_Forums] Set MostRecentThreadID="&MostRecentThreadID&",MostRecentPostSubject='"&MostRecentPostSubject&"',MostRecentPostAuthor='"&MostRecentPostAuthor&"',MostRecentPostDate='"&FormatTime(MostRecentPostDate)&"' where ForumID="&ForumID&"")
End Sub





Sub SendMail(MailAddRecipient,MailSubject,MailBody)

if  MailAddRecipient=""or MailSubject="" or MailBody="" then Exit Sub

on error resume next
MailSubject="("&SiteConfig("SiteName")&")"&MailSubject
MailBody=MailBody&"<br><br><br><a target=_blank href="&SiteConfig("SiteUrl")&"/Default.asp>"&SiteConfig("SiteName")&"</a> 管理团队<br><br><a target=_blank href=http://www.bbsxp.com>BBSXP</a>  &copy; 1998-"&year(now)&" <a target=_blank href=http://www.yuzi.net>YUZI Corporation.</a>"
if SiteConfig("SelectMailMode")="JMail.Message" then
	Set JMail=Server.CreateObject("JMail.Message")
		JMail.Charset="gb2312"
		JMail.ContentType = "text/html"
		'JMail.ContentType = "text/plain"
		JMail.From = SiteConfig("SmtpServerMail")
		
			AddRecipientArray=split(MailAddRecipient,";")
			For i=0 to Ubound(AddRecipientArray)
				if AddRecipientArray(i)<>"" then JMail.AddRecipient AddRecipientArray(i)
			Next

		JMail.Subject = MailSubject
		JMail.Body = MailBody
		JMail.MailServerUserName = SiteConfig("SmtpServerUserName")
		JMail.MailServerPassword = SiteConfig("SmtpServerPassword")
		JMail.Send SiteConfig("SmtpServer")
	Set JMail=nothing
elseif SiteConfig("SelectMailMode")="CDO.Message" then
	Set CDO=Server.CreateObject("CDO.Message")
		CDO.From = SiteConfig("SmtpServerMail")
		CDO.To = MailAddRecipient
		CDO.Subject = MailSubject
		CDO.HtmlBody = MailBody
		'CDO.TextBody = MailBody
		CDO.HTMLBodyPart.Charset="gb2312"
		CDO.Send
	Set CDO=Nothing
end if

If Err Then Response.Write ""&MailAddRecipient&"邮件发送失败！错误原因：" & Err.Description & "<br>"
On Error GoTo 0

End Sub

Sub LoadingEmailXml(emailType)
	Set EmailsXMLDOM = Server.CreateObject("Microsoft.XMLDOM")
		EmailsXMLDOM.Load(Server.MapPath("Utility/emails.xml"))
		MailSubject = EmailsXMLDOM.documentElement.selectSingleNode("//emails/"&emailType&"/subject").Text
		Mailbody = EmailsXMLDOM.documentElement.selectSingleNode("//emails/"&emailType&"/body").Text
		Mailbody = Replace(Mailbody,CHR(10),"<br>")
	Set EmailsXMLDOM = Nothing
End Sub

%>
