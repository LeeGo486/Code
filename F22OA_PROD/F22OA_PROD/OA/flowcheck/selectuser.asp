<!-- #include file="setup.asp" -->
<script language="javascript">
function moveOption(oFromList, oToList, bAll)
{
  var nFromLen = oFromList.options.length;
  var nToLen = oToList.options.length;
  var i = 0;
  while (nFromLen > 0)
  {
	if (oFromList.options[i].selected || bAll)
	{
		oToList[nToLen++] = new Option(oFromList.options[i].text, oFromList.options[i].value);
		oFromList.options[i] = null;
	}
	else
		i++;
	
	nFromLen--;
  }

  sortOption(oToList);
}

function compare(a,b)
{
  if (a.text < b.text)
	return -1;
  else if (a.text > b.text)
	return 1;
  return 0;
}

function sortOption(oList)
{
   if (oList.options.length > 1)
   {
        var optionList  = new Array();

        for (var i=0; i < oList.options.length; i++)
	  optionList.push(oList.options[i]);

	optionList.sort(compare);

    	oList.length = 0;
        for (var i=0; i < optionList.length; i++)
	  oList.options[i] = optionList[i];
   }   
}

function selectall(theform)
{var len=theform.rightlist.options.length-1;
 for (var i=0;i<=len;i++)
 {theform.rightlist.options[i].selected=true;}
}
</script>
<%
baseid=RequestInt("baseid")
act=RequestInt("act")
'de baseid
set rs=server.createobject("adodb.recordset")
if act=1 then
   call Up
else
   call Main
end if
set rs=nothing

Sub Up
  if trim(request("rightlist"))="" then
     mbox("你没有选择人员！")  
  end if
  list=split(request("rightlist"),",")
  rs.open "select isnull(max(orders),0) as maxorders from o_basesub where baseid="&baseid,conn,1,1
  maxorders=round(rs("maxorders"))+1
  rs.close
  for i=0 to ubound(list)
      conn.execute "insert into o_basesub (baseid,orders,userid,cltime,ifedit) values ("&baseid&","&maxorders&",'"&trim(List(i))&"',0,0)"
	  maxorders=maxorders+1
  next
  
  call zclose
End Sub

Sub Main%>
<table align=center>
  <form name="form1" action="" method="post" onsubmit="selectall(this)" target="hf">
  <input type="hidden" name="act" value="1"><input type="hidden" name="baseid" value="<%=baseid%>">
  <tr>
      <td><div align="center"><font size="2">待选人员</font></div></td>
      <td>&nbsp;</td>
      <td><div align="center"><font size="2">已选人员</font></div></td>
    </tr>
    <tr> 
      <td><select name="leftlist" multiple size="15" ondblclick="javascript:moveOption(leftlist, rightlist,false)">
          <%sql="select a.userid,a.username,b.department from j_user a,j_department b where a.departid=b.departid "&_
		        "and a.userid not in (select userid from o_basesub where baseid="&baseid&") order by b.department"
		  rs.open sql,conn,1,1
		  while not rs.eof%>
		  <option value="<%=rs("userid")%>"><%response.write(rs("department")&"-"&rs("username"))%></option>
		  <%rs.movenext
		  wend
		  rs.close%>
        </select></td>
      <td> <input type="button" value=" << " onclick="javascript:moveOption(rightlist, leftlist,true)" class=box>
        <br>
        <br> <input type="button" value=" <  " onclick="javascript:moveOption(rightlist, leftlist,false)" class=box>
        <br>
        <br> <input type="button" value=" >  " onclick="javascript:moveOption(leftlist, rightlist,false)" class=box>
        <br>
        <br> <input type="button" value=" >> " onclick="javascript:moveOption(leftlist, rightlist,true)" class=box> 
      </td>
      <td> <select name="rightlist" multiple  size="15" ondblclick="javascript:moveOption(rightlist, leftlist,false)">
	  </select> </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><div align="center">
          <input type="submit" name="Submit" value=" 确 定 " class=box>
        </div></td>
      <td>&nbsp;</td>
      <td><div align="center">
          <input type="button" name="Submit" value=" 关 闭 " onclick="window.close();" class=box>
        </div></td>
    </tr>
  </form>
</table>
<%End Sub

call CloseConn
Call Footer%>