<!--#include file="../f22/inc/function.asp"-->
<%
response.CacheControl = "no-cache"
response.Charset = "gb2312"
fbuyid=trim(request.Form("fbuyid"))
msg = ""
success = "false"

if fbuyid<>"" then
	set rs=server.CreateObject("adodb.recordset")
		sql="select convert(char(10),a.sure_date,126) as suredate,sum(b.nums*b.s_price) as sums,CASE WHEN ISNULL(a.zssums,0)=0 THEN 0 ELSE CAST((1.0*a.FCalcSums/ISNULL(a.zssums,0)) AS NUMERIC(12,2))  END  FCalcDisc from d_retail a,d_retailsub b "&_
	        "where a.retailid=b.retailid and a.retailid='"&fbuyid&"' group by convert(char(10),a.sure_date,126),a.zssums,a.FCalcSums"
		rs.open sql,cn,1,1
			if rs.eof and rs.bof then
				msg = "单号 "&fbuyid&" 不存在！"
				success = "false"
			else
				msg = rs("suredate")&"|"&rs("sums")&"|"&rs("FCalcDisc")
				success = "true"
			end if
		rs.close
		if success="true" then
			rs.open "select fbuyid from vip_user where fbuyid='"&fbuyid&"'",cn,1,1
				if not rs.eof and not rs.bof then
					msg = "单号 "&rs("fbuyid")&" 已被使用！"
					success = "false"
				end if
			rs.close
		end if
	set rs= nothing
end if
response.write "{'msg':'"&msg&"','success':'"&success&"'}"

%>