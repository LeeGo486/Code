<!--#include file="inc_header.asp"-->
<%
cruser=username
reurl=""
dcid=request.querystring("dcid")
remark=request.querystring("remark")
if dcid="" then
	today = now()
	mtoday = month(today)
	dtoday = day(today)
		if len(mtoday)=1 then mtoday="0"&mtoday
		if len(dtoday)=1 then dtoday="0"&dtoday
	today = right(year(today),2)&""&mtoday&""&dtoday&"-"&hour(today)&""&minute(today)&""&second(today)
	dcid="CX-"&today
end if
act2=request.querystring("act")
if act2="" then act2="submit"
act=trim(request.Form("act"))

if act2="pass" then
	'审核通过
	sql=" update i_topics set istate=2 where dcid='"&dcid&"' and istate=1"&_
			" insert into i_logs (DCID,logtype,logtext,cruser) values ('"&DCID&"','审核通过','"&remark&"','"&username&"')"
	cn.execute(sql)
	
	if reurl="" then reurl="LIST_TPINQUIRE.ASP?istate=1"
	response.Redirect(reurl)
elseif act2="nopass" then 
	'审核不通过
	sql=" update i_topics set istate=0 where dcid='"&dcid&"' and istate=1"&_
			" update i_subject set readonly=0 where dcid='"&dcid&"'"&_
			" insert into i_logs (DCID,logtype,logtext,cruser) values ('"&DCID&"','审核不过','"&remark&"','"&username&"')"
	cn.execute(sql)

	if reurl="" then reurl="LIST_TPINQUIRE.ASP?istate=1"
	response.Redirect(reurl)
elseif  act2="over" then
	'人为结束
	sql=" update i_topics set istate=12,eddate='"&date()&"' where dcid='"&dcid&"' and istate=2"&_
			" insert into i_logs (DCID,logtype,logtext,cruser) values ('"&DCID&"','人为结束','"&remark&"','"&username&"')"
	cn.execute(sql)
	
	if reurl="" then reurl="LIST_TPINQUIRE.ASP?istate=2"
	response.Redirect(reurl)
elseif  act2="del" then
	'删除
	sql="delete from i_topics where dcid='"&dcid&"'"&_
			"delete from i_subject where dcid='"&dcid&"'"&_
			"delete from i_todpt where dcid='"&dcid&"'"&_
			"delete from i_logs where dcid='"&dcid&"'"&_
			"delete from i_feedback where dcid='"&dcid&"'"
	cn.execute(sql)
	if reurl="" then reurl="LIST_TPINQUIRE.ASP"
	response.Redirect(reurl)
end if

'--------------------


if act<>"" then
dptList=trim(request.Form("dptList"))
DCID=trim(request.Form("DCID"))
ititle=trim(request.Form("ititle"))
iresume=trim(request.Form("iresume"))
if iresume<>"" then iresume=RemoveHTML(iresume)
itype=trim(request.Form("itype"))
istate=trim(request.Form("istate"))
cruser=trim(request.Form("cruser"))
crdate=trim(request.Form("crdate"))
stdate=trim(request.Form("stdate"))
eddate=trim(request.Form("eddate"))
subject=trim(request.Form("subject"))

if DCID="" then errorstr="异常错误，编号为空!"
if ititle="" then errorstr="标题不能为空为空!"
if itype="" then errorstr="类型不能为空!"
if subject="" or eval(subject)=0 then errorstr="调查题目不能为空!"
if istate="" then istate=0

if act="submit" then
	'验证编号是否存在
	sql="select dcid from i_topics where dcid='"&dcid&"'"
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
			errorstr="编号已存在!"
	end if
	rs.close
end if

	if errorstr<>"" then
		response.write "<script>alert('"&errorstr&"');history.go(-1)</script>"
		response.end()
	end if

'添加或更新主表记录
if act="submit" then
	'添加
	sql="select * from i_topics"
	rs.open sql,cn,1,3
	rs.addnew
		rs("DCID")=DCID
else
	'编辑
	sql="select * from i_topics where dcid='"&dcid&"'"
	rs.open sql,cn,1,3
end if
		rs("ititle")=ititle
		rs("iresume")=iresume
		rs("itype")=itype
		rs("cruser")=cruser
		rs("crdate")=crdate
		rs("stdate")=stdate
		rs("eddate")=eddate
		rs("istate")=istate
	rs.update
	rs.close

'添加或更新店铺关联表记录
	'先清除旧的的
	sql="delete from i_todpt where dcid='"&dcid&"'"
	cn.execute(sql)
	
	dptLists = split(dptList,",")
	for i = 0 to ubound(dptLists)
		sql="insert into i_todpt (DCID,depotid,cruser) values ('"&dcid&"','"&trim(dptLists(i))&"','"&cruser&"')"
		cn.execute(sql)
	Next
	
'更改对应题目为只读
if istate=0 then
	readonly=1
else
	readonly=2
end if
	sql="update i_subject set readonly="&readonly&" where dcid='"&dcid&"'"
	cn.execute(sql)
	
if act="submit" then
	sql="insert into i_logs (DCID,logtype,cruser) values ('"&DCID&"','发布调查','"&username&"')"
	cn.execute(sql)
	
else
	sql="insert into i_logs (DCID,logtype,cruser) values ('"&DCID&"','修改调查','"&username&"')"
	cn.execute(sql)
	
end if
	response.write "<script>alert('操作成功');location.href='list_tpinquire.asp'</script>"
	response.end()
end if

'开始
if act2<>"submit" then
	sql="select * from i_topics where dcid='"&dcid&"'"
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
		cruser=rs("cruser")
		ititle=rs("ititle")
		iresume=rs("iresume")
		itype=rs("itype")
		crdate=rs("crdate")
		eddate=rs("eddate")
		istate=rs("istate")
		stdate=rs("stdate")
		shuser=rs("shuser")
		shdate=rs("shdate")
		sxuser=rs("sxuser")
		sxdate=rs("sxdate")
		eddate=rs("eddate")
		
	end if
	rs.close
else
	crdate=now()
	stdate=date()
	eddate=date()+30
	istate=0
end if

if act2="view" then view="disabled=disabled"

%>
<script type="text/javascript">
function ckform(){
var form = document.forms['tpform'];
var rtn="";
	var opt = form.dptList.getElementsByTagName("OPTION");
	for(i=0;i<opt.length;i++){opt[i].selected=true;}
		if(form.itype.value.length<=0){
			rtn="类型不能为空";
		}else if(form.ititle.value.length<=0){ 
			rtn="调查标题不能为空"; 
		}else if(form.iresume.value.length<=0){ 
			rtn="调查说明不能为空"; 
		}else if(form.dptList.value.length<=0){
			rtn="参与店铺不能为空"; 
		}else if(form.subject.value<=0){
			rtn="调查题目不能为空"; 
		}
	
	if(rtn){
		alert(rtn);
		return false;
	}else{
		return true;
	}	
}
function subjectjs(v){
	if(v==0){
	var bb=showMD('add_subject.asp?dcid=<%=dcid%>&<%=now()%>',650,400);
		if(bb){
		document.frames['subjectView'].location.reload();
		}
	}else{
		var aa=showMD('list_subject.asp?udcid=<%=dcid%>&<%=now()%>',650,300);
		if(aa){
		document.frames['subjectView'].location.href='list_Subject.asp?dcid=<%=dcid%>&act=add&subid='+aa;
		}
	}
}
function jschk(a){
	var remark1=document.getElementById("remark1");
	var remark2=document.getElementById("remark2");
	var remark3=document.getElementById("remark3");
	if(a==1){
		if(remark1.style.display=='none'){
			if(remark2){remark2.style.display='none';}
			if(remark3){remark3.style.display='none';}
			remark1.style.display='';
			remark1.focus();
			remark1.select();
		}else if(remark1.value!='填写备注'&&remark1.value!=''){
			location.href='?act=pass&dcid=<%=dcid%>&remark='+remark1.value;
		}else{
			if(confirm('不填写备注内容吗？')){
				remark1.value="无";
				jschk(1);
			}else{
				remark1.focus();
				remark1.select();
			}
		}
	}else if(a==2){
		if(remark2.style.display=='none'){
			if(remark1){remark1.style.display='none';}
			if(remark3){remark3.style.display='none';}
			remark2.style.display='';
			remark2.focus();
			remark2.select();
		}else if(remark2.value!='填写备注'&&remark2.value!=''){
			location.href='?act=nopass&dcid=<%=dcid%>&remark='+remark2.value;
		}else{
			if(confirm('不填写备注内容吗？')){
				remark2.value="无";
				jschk(2);
			}else{
				remark2.focus();
				remark2.select();
			}
		}
	}else if(a==3){
		if(remark3.style.display=='none'){
			if(remark1){remark1.style.display='none';}
			if(remark2){remark2.style.display='none';}
			remark3.style.display='';
			remark3.focus();
			remark3.select();
		}else if(remark3.value!='填写备注'&&remark3.value!=''){
			location.href='?act=over&dcid=<%=dcid%>&remark='+remark3.value;
		}else{
			if(confirm('不填写备注内容吗？')){
				remark3.value="无";
				jschk(3);
			}else{
				remark3.focus();
				remark3.select();
			}
		}
	}else if(a==4){
		if(confirm('确定删除吗？'))
		location.href='?act=del&dcid=<%=dcid%>';
	}else if(a==5){
		history.go(-1);
	}
}
</script>
<%if istate then%>
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="5" >
  <tr>
    <td align="right" >
    <%if pchk and istate=1 then%>
   	<input type="text" value="填写备注" name="remark1" id="remark1" size="30" maxlength="255" style="display:none" />
    <input type="button" name="chodpt2" id="chodpt2" value="审核通过" class="btn" onclick="jschk(1)"  />
   	<input type="text" value="填写备注" name="remark2" id="remark2" size="30" maxlength="255" style="display:none"/>
    <input type="button" name="chodpt2" id="chodpt2" value="审核不通过" class="btn" onclick="jschk(2)" />
    <%end if%>
    <%if punchk and istate=2 then%>
   	<input type="text" value="填写备注" name="remark3" id="remark3" size="30" maxlength="255" style="display:none"/>
    <input type="button" name="chodpt2" id="chodpt2" value="提前结束" class="btn" onclick="jschk(3)" />
    <%end if%>
    <%if pdel then%>
    <input type="button" name="chodpt2" id="chodpt2" value="删　除" class="btn" onclick="jschk(4)" />
    <%end if%>
    <input type="button" name="chodpt2" id="chodpt2" value="返　回" class="btn"  onclick="jschk(5)" /></td>
  </tr>
</table>
<%end if%>
<%
sql="select crdate,logtype,logtext,cruser from i_logs where dcid='"&dcid&"' order by crdate asc"
rs.open sql,cn,1,1
if not rs.eof and not rs.bof then
%>
<div id="tmTable">
<table width="100%" border="1">
  <tr>
    <td><strong>时间</strong></td>
    <td><strong>类型</strong></td>
    <td><strong>备注</strong></td>
    <td><strong>操作人</strong></td>
    </tr>
	<%
	do while not rs.eof
	response.write "<tr>"
	response.write 	 "<td align=center>"&rs(0)&"</td>"
	response.write 	 "<td align=center>"&rs(1)&"</td>"
	response.write 	 "<td>"&rs(2)&"</td>"
	response.write 	 "<td align=center>"&rs(3)&"</td>"
	response.write "</tr>"
	rs.movenext
	loop
	%>
</table>
</div>
<script type="text/javascript">
	jsTable('tmTable','tm','90%','120|120||70','center');
</script>
<%
end if
rs.close
%>
<form id="tpform" name="tpform" method="post" action="?" onsubmit="return ckform()">
<input type="hidden" value="<%=act2%>" name="act" />
<input name="subject" type="hidden" id="subject" value="0" />
<div id="lrTable">
<table width="100%" border="1">
  <tr>
    <td>调查编号：</td>
    <td><input name="dcid" type="text" id="dcid" size="30" <%=view%> value="<%=dcid%>" readonly="readonly" style="background:#efefef;" /></td>
    </tr>
  <tr>
    <td>调查类型：</td>
    <td><select name="itype" id="itype" <%=view%> >
				<%getitype itype%>
      </select></td>
    </tr>
  <tr>
    <td>调查标题：</td>
    <td><label>
      <input name="ititle" type="text" id="ititle" value="<%=ititle%>" size="70"  <%=view%>/>
    </label></td>
    </tr>
  <tr>
    <td>调查说明：</td>
    <td><textarea name="iresume" cols="90" rows="3" id="iresume" <%=view%>  onkeydown="if(event.keyCode==13) return false"><%=iresume%></textarea></td>
  </tr>
  <tr>
    <td><p>参与店铺：<br />按住Ctrl可多选</p></td>
    <td>
      
      <table border="0">
        <tr>
          <td>
          <input name="dptkey" type="text" id="dptkey" size="20" <%=view%> onkeydown="if(event.keyCode==13){allselect('add',this.value.toUpperCase());this.value='';return false}"/><br />
          <label>
          <select name="dptList2" size="8" multiple="multiple"
           id="dptList2" style="width:180px" ondblclick="moveValue(document.getElementById('dptList2'),document.getElementById('dptList'))">
          <%getdepot dcid%>
          </select></label></td>
          <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="5">
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
          </table>          </td>
          <td>
          <input name="dptkey" type="text" id="dptkey" size="20"  <%=view%> onkeydown="if(event.keyCode==13){allselect('remove',this.value.toUpperCase());this.value='';return false}"/><br />
          <label>
          <select name="dptList" size="8" multiple="multiple"
            id="dptList" style="width:180px" ondblclick="moveValue(document.getElementById('dptList'),document.getElementById('dptList2'))">
          <%getdptList dcid%>
          </select></label></td>
        </tr>
      </table>
      </td>
    </tr>
  <tr>
    <td>调查题目：</td>
    <td>
    <input type="button" name="addsubject" id="addsubject" value="新建调查题目..." class="btn" onclick="subjectjs(0)"  <%=view%> />
    <input type="button" name="chosubject" id="chosubject" value="选择调查题目..." class="btn" onclick="subjectjs(1)"  <%=view%> />    </td>
  </tr>
  <tr>
    <td>调查题目预览：</td>
    <td>
    <iframe src="list_Subject.asp?dcid=<%=dcid%>" width="98%" frameborder="0" name="subjectView" id="subjectView" scrolling="no"></iframe></td>
  </tr>
  <tr>
    <td>发布选项：</td>
    <td><label for="istate">
      <input name="istate" type="checkbox" id="istate" value="1" checked="checked"  <%=view%>/>
      是否现在发布？</label></td>
  </tr>
  <tr>
    <td>开始日期：</td>
    <td><input name="stdate" type="text" id="stdate" size="30" value="<%=stdate%>" onFocus="setday(this);" readonly="readonly" <%=view%>/></td>
  </tr>
  <tr>
    <td>结束日期：</td>
    <td><input name="eddate" type="text" id="eddate" size="30" value="<%=eddate%>" onFocus="setday(this);" readonly="readonly" <%=view%>/></td>
  </tr>
<%if istate>=0 then%>
  <tr>
    <td>创 建 人：</td>
    <td><input name="cruser" type="text" id="cruser" size="20" value="<%=cruser%>" readonly="readonly" style="background:#ddd;" /></td>
  </tr>
  <tr>
    <td>创建日期：</td>
    <td><input name="crdate" type="text" id="crdate" size="30" value="<%=crdate%>" readonly="readonly" style="background:#ddd;" /></td>
  </tr>
<%end if%>
<!--
if shuser<>"" then
  <tr>
    <td>审 核 人：</td>
    <td><input name="shuser" type="text" id="shuser" size="20" value="<%=shuser%>" readonly="readonly" style="background:#ddd;" /></td>
  </tr>
  <tr>
    <td>审核日期：</td>
    <td><input name="shdate" type="text" id="shdate" size="30" value="<%=shdate%>" readonly="readonly" style="background:#ddd;" /></td>
  </tr>
< %end if
if sxuser<>"" then%>
  <tr>
    <td style="color:red">提前结束：</td>
    <td><input name="sxuser" type="text" id="sxuser" size="20" value="<%=sxuser%>" readonly="readonly" style="background:#ddd;" /></td>
  </tr>
  <tr>
    <td style="color:red">结束日期：</td>
    <td><input name="sxdate" type="text" id="sxdate" size="20" value="<%=sxdate%>" readonly="readonly" style="background:#ddd;" /></td>
  </tr>
< % End If %>
-->
  <tr>
    <td>&nbsp;</td>
    <td style="height:50px;">
    <%if pedit and istate=0 then%>
    <input type="submit" name="substr" id="substr" value="提　交" class="btn"  <%=view%>/>
    <%end if%>
    <input type="button" name="chodpt2" id="chodpt2" value="返　回" class="btn"  onclick="jschk(5)" /></td>
  </tr>
</table>
</div>
</form>
	<script type="text/javascript">
    jsTable('lrTable','lr','90%','120','center');
  </script>
<!--#include file="inc_footer.asp"-->