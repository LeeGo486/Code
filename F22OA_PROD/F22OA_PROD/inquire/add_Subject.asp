<!--#include file="inc_header.asp"-->
<%
act=request("act")

dcid=trim(request("dcid"))
subid=trim(request("subid"))
'-------------------------------------
if act="submit" then

otype=trim(request.form("otype"))
subject=trim(request.form("subject"))
iOption=trim(request.form("iOption"))
dptList=trim(request.form("dptList"))
if dcid<>"" then RemoveHTML(dcid)
if otype<>"" then RemoveHTML(otype)
if subject<>"" then RemoveHTML(subject)
if iOption<>"" then RemoveHTML(iOption)
if dptList<>"" then RemoveHTML(dptList)

if eval(otype)=3 then
iOption=""
end if


	if isnumeric(subid) then
		sql="select * from i_subject where subjectID='"&subid&"'"
		rs.open sql,cn,1,3
			rs("DCID")=DCID
			rs("iSubject")=Subject
			rs("iOption")=iOption
			rs("iType")=otype
			rs("cruser")=username
		  rs("dcbrand")=dptList
			'rs("readonly")=readonly
		rs.update
		rs.close
	else
		if instr(dptList,",")>0 then 
			brds = split(dptList,",")
			for i= 0 to ubound(brds)
				sql="select * from i_subject"
				rs.open sql,cn,1,3
				rs.addnew
					rs("DCID")=DCID
					rs("iSubject")=Subject
					rs("iOption")=iOption
					rs("iType")=otype
					rs("cruser")=username
					rs("dcbrand")=trim(brds(i))
					'rs("readonly")=readonly
				rs.update																'先更新到数据库中
					rs("iOrder")=rs("SubjectID")					'再更新排序字段
				rs.update
				rs.close
			Next
		else
			sql="select * from i_subject"
			rs.open sql,cn,1,3
			rs.addnew
				rs("DCID")=DCID
				rs("iSubject")=Subject
				rs("iOption")=iOption
				rs("iType")=otype
				rs("cruser")=username
				rs("dcbrand")=dptList
				'rs("readonly")=readonly
			rs.update																'先更新到数据库中
				rs("iOrder")=rs("SubjectID")					'再更新排序字段
			rs.update
			rs.close
		end if
	end if
	response.write "<script type=text/javascript>"
	response.write "returnValue='refresh';"
	response.write "window.close();"
	response.write "</script>"
	response.end
elseif isnumeric(subid) then
	sql="select * from i_subject where SubjectID="&subid&" and DCID='"&dcid&"'"
	rs.open sql,cn,1,1
		Subject = rs("iSubject")
		iOption = rs("iOption")
			otype = rs("iType")
		dptList = rs("dcbrand")
		'rs("readonly")=readonly
	rs.close
end if
%>
<script type="text/javascript">

returnValue='';

function sjopt(a){
var s= document.getElementById('subOption');
var lis = s.getElementsByTagName("LI");
var li = document.createElement("li");
li.innerHTML='<input type="text" name="iOption" size="30" onchange="this.value=this.value.replace(\',\',\'，\').replace(\'.\',\'。\')" />';
	if(a=="add"){
		if(lis.length<10){
			s.appendChild(li);
		}else{
			alert('选项不能大于10个')
			return false;
		}
	}else if(a=="remove"){
		if(lis.length<2){
			alert('必须保留一个或一个以上选项')
			return false;
		}else{
			s.removeChild(lis[(lis.length-1)]);
		}
	}
}

function subopt(){
var t = document.getElementById('otype3');
	if(t.checked==true){
		document.getElementById('subopt').style.display='none'
	}else{
		document.getElementById('subopt').style.display='block'
	}
}
function chkform(t){
	var opt = t.dptList.getElementsByTagName("OPTION");
	if(t.subject.value.length==0){
	alert('题目内容不能为空')
	return false;
	}
<%if subid="" then%>
	for(i=0;i<opt.length;i++){opt[i].selected=true;}
<%end if%>
}
</script>
<table width="96%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#ccddff" style="margin:15px 0;">
<form id="form1" name="form1" method="post" action="?act=submit" onsubmit="return chkform(this)" target="hf">
  <tr>
    <td width="100" bgcolor="#FFFFFF"><div align="right">题目类型：</div></td>
    <td colspan="2" bgcolor="#FFFFFF"><label for="otype">
      <input name="otype" type="radio" id="otype" value="1"
      <%if otype="" or otype=1 then response.write "checked=checked"%>
       onclick="subopt()" />
      单选</label>
      <label for="otype2">
      <input type="radio" name="otype" id="otype2" value="2"
      <%if otype=2 then response.write "checked=checked"%>
       onclick="subopt()" />
      多选</label>
      <label for="otype3">
      <input type="radio" name="otype" id="otype3" value="3"
      <%if otype=3 then response.write "checked=checked"%>
       onclick="subopt()" />
      简答
      <input type="hidden" value="<%=dcid%>" name="dcid" id="dcid" />
      <input type="hidden" value="<%=subid%>" name="subid" id="subid" />
      </label></td>
    </tr>
  <tr>
  <%if subid="" then %>
    <td width="100" bgcolor="#FFFFFF" valign="top"><div align="right">
      <br />调查品牌：<br /><br />
      <span style='color:blue'>*非品牌调查<br />可不用填写</span>
      </div></td>
   <%else%>
    <td width="100" bgcolor="#FFFFFF" ><div align="right">调查品牌：</div></td>
   <%end if%>
    <td colspan="2" bgcolor="#FFFFFF">
    <%If subid<>"" Then %>
      <select name="dptList"  id="dptList" style="width:130px" >
      <%getbrand dptList%>
      </select>
      <span style='color:blue'>*非品牌调查可不用填写</span>
    <%else%>
      <table border="0">
        <tr>
          <td>
          <label>
          <select name="dptList2" size="6" multiple="multiple"
            id="dptList2" style="width:100px" ondblclick="moveValue(document.getElementById('dptList2'),document.getElementById('dptList'))">
          <%getbrands dcid%>
          </select></label></td>
          <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="3">
            <tr>
              <td align=center><input type="button" name="chodpt2" id="chodpt2" value="添加 &gt;"  
              onclick="moveValue(document.getElementById('dptList2'),document.getElementById('dptList'))"
               class="btn2" style="width:80px;" <%=view%> /></td>
            </tr>
            <tr>
              <td align=center><input type="button" name="chodpt2" id="chodpt2" value="&lt; 移除" 
               onclick="moveValue(document.getElementById('dptList'),document.getElementById('dptList2'))"
                class="btn2" style="width:80px"  <%=view%>/></td>
            </tr>
            <tr>
              <td align=center><input type="button" name="chodpt2" id="chodpt2" value="全选 &gt;&gt;"
               onclick="allselect('adds')" class="btn2" style="width:80px"  <%=view%> /></td>
            </tr>
            <tr>
              <td align=center><input type="button" name="chodpt2" id="chodpt2" value="&lt;&lt; 全移"
               onclick="allselect('removes')"  class="btn2" style="width:80px"  <%=view%> /></td>
            </tr>
          </table></td>
          <td>
          <label>
          <select name="dptList" size="6" multiple="multiple"  id="dptList" 
          style="width:100px" ondblclick="moveValue(document.getElementById('dptList'),document.getElementById('dptList2'))">
          <%getbrds dcid%>
          </select></label></td>
        </tr>
      </table>
		<% End If %>
      </td>
    </tr>
  <tr>
    <td width="100" bgcolor="#FFFFFF"><div align="right">题　　目：</div></td>
    <td colspan="2" bgcolor="#FFFFFF"><label>
      <textarea name="subject" cols="70" rows="3" id="subject" onkeydown="if(event.keyCode==13) return false"><%=subject%></textarea>
    </label></td>
    </tr>
  <tr id="subopt" <%if otype=3 then response.write "style=""display:none;"""%>>
    <td width="100" valign="top" bgcolor="#FFFFFF"><div align="right"><br />
      选　　项：<br /><br />
    </div></td>
    <td bgcolor="#FFFFFF">
    <ul style="margin: 0 0 0 30px;list-style:upper-alpha" id="subOption">
    <%if instr(iOption,",")>0 then%>
    	<%
				opts=split(iOption,",")
				for i = 0 to ubound(opts)
			%>
      <li><input name="iOption" type="text" size="30" value="<%=trim(opts(i))%>" onchange="this.value=this.value.replace(',','，').replace('.','。')" / ></li>
      <%
				Next
			%>
    <% Else %>
      <li><input name="iOption" type="text" size="30" onchange="this.value=this.value.replace(',','，').replace('.','。')" / ></li>
      <li><input name="iOption" type="text" size="30" onchange="this.value=this.value.replace(',','，').replace('.','。')"  / ></li>
      <li><input name="iOption" type="text" size="30" onchange="this.value=this.value.replace(',','，').replace('.','。')" / ></li>
      <li><input name="iOption" type="text" size="30" onchange="this.value=this.value.replace(',','，').replace('.','。')"  /></li>
      
		<% End If %>
    </ul></td>
    <td valign="top" bgcolor="#FFFFFF">
      <span style='color:red'>*选项留空为填写项</span><br />
<br />

    <input type="button" name="addoption3" id="addoption3" value="增加一个选项" class="btn2" onclick="sjopt('add')" />
      <br />
      <input type="button" name="addoption" id="addoption" value="减少一个选项" class="btn2" onclick="sjopt('remove')" />
      <br />
      <br />      </td>
  </tr>
  
  <tr>
    <td colspan="3" bgcolor="#FFFFFF"><div align="center">
      <input type="submit" name="addoption2" id="addoption2" value="提　交" class="btn" />&nbsp;
      <input type="button" name="button" id="button" value="取　消 " class="btn" onclick="window.close()"  />
    </div></td>
    </tr>
</form>
</table>
<iframe src="about:blank" style="display:none" name="hf"></iframe>
<!--#include file="inc_footer.asp"-->