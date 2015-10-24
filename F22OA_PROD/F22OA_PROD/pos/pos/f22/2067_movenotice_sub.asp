<%option explicit
session("formid")=2070%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%dim act,typ,djid,sql,newid,istrue
act=trim(request("act"))
typ=request("typ")
djid=trim(request("id"))
istrue=trim(request("istrue"))

select case act
 
  case "edit" if IsNumeric(typ) then
              cn.execute "update d_movenotice set cwpz="&typ&" where noticeid='"&djid&"'"
              end if
			  response.write("<script>window.close();</script>")
		      response.end
  case "jump" if IsNumeric(typ) then
              if cint(typ)=1 then
			     
			  else
			     session("formid")=2067
			     if getcz(djid,2) then
				    response.write("<script>alert('此通知单已经被参照发货！');window.close();</script>")
					response.end
				 end if
			    
				 newid=getid("d_move","moveid","FC",session("dm").System_UserId)
				 sql=" insert into d_move(moveid,move,indentid,set_depotid,get_depotid,set_sure,get_sure,"&_
				 " setchk_sure,getchk_sure,setdate,setcr_date,set_comment,getdate,setcr_name,crdate,backdate,"&_
				 " backrate,selltype) "&_					
				 " select '"&newid&"','"&newid&"','"&djid&"',set_depotid,get_depotid,0,0,0,0,"&_
				 " setdate,getdate(),comment,getdate,'"&session("dm").System_UserName&"',getdate(),backdate,"&_
				 " backrate,selltype "&_
				 " from d_movenotice where noticeid='"&djid&"'"
				 cn.execute sql
				 cn.execute "update d_movenotice set cwpz=30 where noticeid='"&djid&"'"
				 
				 if istrue=0 then
				   
				    sql="insert d_movesub "&_
					" (moveid,boxid,clothingid,styleid,colorid,sizeid,"&_
					" j_cost,j_price,x_price,discount,s_price,set_nums,crdate,comment) "&_
					" select '"&newid&"',boxid,clothingid,styleid,colorid,sizeid,"&_
					" j_cost,j_price,x_price,discount,s_price,nums,crdate,comment"&_
					" from  d_movenoticesub where noticeid='"&djid&"'"
					cn.execute sql
							
				 end if
  			     response.Redirect "2067_move_create.asp?action=edit&id="&newid '"&czid=notice&"	 
				 
			  end if
				end if
end select 

function getcz(idd,t)
dim rs
set rs=server.createobject("adodb.recordset")
rs.open "select isnull(count(*),0) as cnt from d_move where indentid='"&idd&"'",cn
if rs("cnt")>0 then
   getcz=true
else
   getcz=false
end if
rs.close
end function


%>
