<%option explicit
on error resume next%>
<!--#include file="../inc/const.asp" -->
<!--#include file="inc/function.asp"-->
<%dim djid,oldformid,newformid,copytype,str1,pldjid,s1,s2,s3,s4,i,errstr,djidtmp,rs
djid=request("djid")
oldformid=request("oldformid")
newformid=request("newformid")
str1=request("sel")
copytype=request("copytype")
if djid="" or oldformid="" or newformid="" then
   response.write("<script>alert('?TD?ì2?¨oy?ê?');window.close();</script>")
   response.end
end if
oldformid=cint(oldformid)
newformid=cint(newformid)

'if oldformid=2166 then
'  oldformid=2066
'end if
'response.Write(oldformid&"<br>")
'response.Write(newformid)
'response.End()
select case oldformid
case 2060 s1="insert into d_indentsub(indentid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_indentsub where indentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_indentsub where indentid='"&djid&"' group by clothingid"
case 2061 s1="insert into d_indentsub(indentid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_indentsub where indentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_indentsub where indentid='"&djid&"' group by clothingid"
case 1007 s1="insert into d_indentsub(indentid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_indentsub where indentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_indentsub where indentid='"&djid&"' group by clothingid"
case 1008 s1="insert into d_quotasub(quotaid,boxid,clothingid,styleid,colorid,sizeid,j_cost,pj_price,px_price,discount,s_price,nums,comment )"
          s2="delete d_quotasub where quotaid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(pj_price) as j_price,avg(px_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_quotasub where quotaid='"&djid&"' group by clothingid"
case 2062 s1="insert into d_sellsub(sellid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,set_nums,comment )"
          s2="delete d_sellsub where sellid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_sellsub where sellid='"&djid&"' group by clothingid"
case 0 s1="insert into d_sellsub(sellid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,set_nums,comment )"
          s2="delete d_sellsub where sellid='"&djid&"'"
case 2063 s1="insert into d_outindentprosub(outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_outindentprosub where outindentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_outindentprosub where outindentid='"&djid&"' group by clothingid"
case 2064 s1="insert into d_outindentprosub(outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_outindentprosub where outindentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_outindentprosub where outindentid='"&djid&"' group by clothingid"
case 0 s1="insert into d_outindentchksub(outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_outindentchksub where outindentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_outindentchksub where outindentid='"&djid&"' group by clothingid"
case 2065 s1="insert into d_outindentsetsub(outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_outindentsetsub where outindentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_outindentsetsub where outindentid='"&djid&"' group by clothingid"
case 1015 s1="insert into d_outindentsub(outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_outindentsub where outindentid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_outindentsub where outindentid='"&djid&"' group by clothingid"
case 2067 s1="insert into d_movesub(moveid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,set_nums,comment )"
          s2="delete d_movesub where moveid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_movesub where moveid='"&djid&"' group by clothingid"
case 2068 s1="insert into d_movesub(moveid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,set_nums,comment )"
          s2="delete d_movesub where moveid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_movesub where moveid='"&djid&"' group by clothingid"
case 2066 s1="insert into d_inventorysub(inventoryid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_inventorysub where inventoryid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_inventorysub where inventoryid='"&djid&"'  group by clothingid"
case 0 s1="insert into d_inventorysub(inventoryid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,d_nums,comment )"
          s2="delete d_inventorysub where inventoryid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(d_nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_inventorysub where inventoryid='"&djid&"'  group by clothingid"
case 2166 s1="insert into d_inventorysub(inventoryid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,d_nums,comment )"
          s2="delete d_inventorysub where inventoryid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(d_nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_inventorysub where inventoryid='"&djid&"'  group by clothingid"	
case 1021 s1="insert into d_retailsub(retailid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment )"
          s2="delete d_retailsub where retailid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_retailsub where retailid='"&djid&"' group by clothingid"
case 2071 s1="insert into d_msellsub(msellid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,set_nums,comment )"
          s2="delete d_msellsub where msellid='"&djid&"'"
		  s4="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmp2 "&_
			 "from d_msellsub where msellid='"&djid&"' group by clothingid"
case else response.write("<script>alert('参数不对');window.close();</script>")
          response.end
end select

select case newformid
case 1005 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_indentsub where indentid in (:id) group by clothingid"
case 1006 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_indentsub where indentid in (:id)  group by clothingid"
case 1007 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_indentsub where indentid in (:id) group by clothingid"
case 1008 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(pj_price) as j_price,avg(px_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_quotasub where quotaid in (:id) group by clothingid"
case 1009 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_sellsub where sellid in (:id) group by clothingid"
case 1010 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_sellsub where sellid in (:id) group by clothingid"
case 1011 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_outindentprosub where outindentid in (:id) group by clothingid"
case 1012 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_outindentprosub where outindentid in (:id) group by clothingid"
case 1013 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_outindentchksub where outindentid in (:id) group by clothingid"
case 1014 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_outindentsetsub where outindentid in (:id) group by clothingid"
case 1015 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_outindentsub where outindentid in (:id) group by clothingid"
case 1017 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_movesub where moveid in (:id) group by clothingid"
case 1018 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_movesub where moveid in (:id) group by clothingid"
case 1019 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_inventorysub where inventoryid in (:id) group by clothingid"
case 1020 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_inventorysub where inventoryid in (:id)  group by clothingid"
case 1021 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_retailsub where retailid in (:id) group by clothingid"
case 1022 s3="select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
             "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
             "avg(s_price) as s_price,sum(set_nums) as nums,max(comment) as comment into #tmpcopydj "&_
			 "from d_msellsub where msellid in (:id) group by clothingid"
case else response.write("<script>alert('参数不对');window.close();</script>")
          response.end
end select

'response.write s1&"<br>"
'response.write s2&"<br>"
'response.write s3&"<br>"
'response.write s4&"<br>"
'response.end


'????-|ì￡¤2?¨¨?¨￠¨′¨o?à?à¨a
cn.execute "drop table #tmpcopydj"
cn.execute "drop table #tmp1"
cn.execute "drop table #tmp2"
cn.execute "drop table #tmp3"
cn.execute s4

'?¨′¨?DD¨¨???à??|ì￡¤o?
pldjid=split(str1,",")
for i=0 to ubound(pldjid)
	djidtmp=djidtmp&"'"&trim(pldjid(i))&"',"
next
djidtmp=left(djidtmp,len(djidtmp)-1)

'de replace(s3,":id",djidtmp)

cn.execute replace(s3,":id",djidtmp)
cn.execute "select * into #tmp1 from #tmpcopydj"
cn.execute "drop table #tmpcopydj"

'tmp1 D¨¨¨°a???à??|ì?|ì￡¤?Y
'tmp2 ?-|ì￡¤
'o?2?é
if int(copytype)=1 then '¨¨??¤??
   cn.execute "update #tmp1 set nums=-1*nums"
end if
'if int(copytype)=0 then '¨¤??¨?
   cn.execute "insert into #tmp1 (clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment) "&_
              "select clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,comment from #tmp2"
   cn.execute "select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) sizeid,"&_
              "avg(j_cost) as j_cost,avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount,"&_
              "avg(s_price) as s_price,sum(nums) as nums,max(comment) as comment into #tmp3 from #tmp1 group by clothingid"
   cn.execute "drop table #tmp1"
   cn.execute "select * into #tmp1 from #tmp3"
'end if
cn.execute "drop table #tmp2"


'¨|?3y?-|ì￡¤??????ê?2?¨¨????à???????
cn.execute s2&" ; "&s1&" select '"&djid&"','CP9999',* from #tmp1"
cn.execute "drop table #tmp1"

response.write("<script>alert('拷贝完成！')</script>")
 response.write "<script language='javascript'>window.location.href='djcopysub.asp?djid="&djid&"&oldformid="&oldformid&"&newformid="&newformid&"';</script>"  
set cn=nothing%>