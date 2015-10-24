<%session("formid")=6103061%>
<!--#include file="inc/function.asp"-->
<%
act=trim(request("act"))

if act="" then act="add"
if act="add" then
	if not padd then call mbox("没有新增权限！")
else
	if not padd then call mbox("没有修改权限！")
end if

dim roadonly,dptreadonly,dptinput
roadonly=""
dim rs1
set rs1=server.CreateObject("adodb.recordset")
'当前店铺类型是否必填和不可修改
rs1.open "SELECT ISNULL(sure,0) as sure,ISNULL(updated,0) as updated FROM sys_Dptype WHERE dptypeid="&session("m_type"),cn
if not rs1.eof then
    dptreadonly=rs1("updated")
    dptinput=rs1("sure")
end if
rs1.close
if act="edit" then
    if dptreadonly then
        rs1.open "SELECT readid,readname,updated FROM j_employee_read WHERE ISNULL(updated,0)=1",cn
        if not rs1.eof then
             do while not rs1.eof
                roadonly=roadonly&"."&rs1("readid")&","
             rs1.movenext
             loop
             roadonly=left(roadonly,(len(roadonly)-1))
        end if
        rs1.close
    end if
end if
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="../../../jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
    <%
        chkinput=chkinput&" var chkinput=["
        if dptinput then
            rs1.open "SELECT readid,readname,sure FROM j_employee_read WHERE ISNULL(sure,0)=1",cn
            if not rs1.eof then
               do while not rs1.eof
                    chkinput=chkinput&"{'readid':'"&rs1("readid")&"','readname':'"&rs1("readname")&"'},"
               rs1.movenext
               loop
            chkinput=left(chkinput,(len(chkinput)-1)) 
            end if
            rs1.close
            set rs1=nothing
        end if
        chkinput=chkinput&"];"
        response.write chkinput
     %>

    function check(theform) {
    var rt=true;
    if(chkinput.length>0)
    {
        $.each(chkinput,function(i,o){
            var obj =$("."+o.readid);
            if(obj!=undefined&&obj.val()=="")
            {
                alert(o.readname+"不能为空！");
                obj.focus();
                rt=false;
            }
            if(!rt)
            {
                 rt=false;
                 return rt;
            }
        });
    }
    var yeargoal = $("#YearGoal").val();
    if (yeargoal != "") {
        if (isNaN(yeargoal)) {
            alert("输入年销售目标金额错误，请重新输入");
            $("#YearGoal").val("");
            $("#YearGoal").focus();
            rt= false;
            return false;
        }
    }
    if(rt)
    {
        $("<%=roadonly %>").removeAttr("disabled");
    }
    return rt;
}

$(function(){
    if("<%=roadonly %>"!="")
    {
        $("<%=roadonly %>").attr("disabled","disabled");
    }

    $("#YearGoal").bind("keypress",function(e){
        if(e.keyCode<48||e.keyCode>57)
        {
            return false;
        }
    });
});
</script>
<style>
.f14{font-size:12px}
</style>
<body>
<%dim ds,sql
depotid=trim(session("dm").System_Depotid)
employeeid=trim(request("id"))
if act="edit" then
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from j_employee where employeeid="&qts(employeeid)
	rs.open sql,cn,1,1	
		if rs.eof and rs.bof then
			response.Write("操作员编号："&employeeid&"不存在!")
		else
			groupid=rs("groupid")
            Position=rs("Position")
            YearGoal=rs("YearGoal")
			employeeid=rs("employeeid")
			names=rs("names")
			usedstatus=rs("usedstatus")
			comment=rs("comment")
			birthday=rs("birthday")
			workdate=rs("workdate")
			IDcard=rs("IDcard")
			sex=rs("sex")
			telphone=rs("telephone")
			address=rs("address")
			comment=rs("comment")
			'depotid=rs("depotid")
			valid=rs("valid")
            job_number=rs("job_number")
		end if
	rs.close
	set rs=nothing
end if

if act ="add" then
 set rs=server.CreateObject("adodb.recordset")
 sql=" exec F22_pub_getStaffId '' "
 rs.open sql,cn,1,1	
 	if rs.eof and rs.bof then
			response.Write("获取营业员编号失败!")
		else
			employeeid=rs(0)
		end if
	rs.close
	set rs=nothing

end if
 
%>
<table width="100%" border="0" align="center" class="bar">
  <tr>
    <td align="center">添加营业员</td>
  </tr>
</table>
<form name="form1" method="post" action="pos_employee_save.asp" onSubmit="return check(this)">
<input name="act" type="hidden" id="act" value="<%=act%>">
  <table width="100%" border="1" align="center" cellpadding="0" cellspacing="1" bordercolor="#ECD4CF" class="f14">
    <tr>
      <td bgcolor="#FFEFEF">店号:</td>
      <td><%=session("dm").System_DepotName%>(<%=depotid%>)&nbsp;</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">班次</td>
      <td><select name="groupid" id="groupid" class="1004">
<%
	set ds=Server.CreateObject("ADODB.Recordset")
	ds.ActiveConnection = cn
	  sql="select groupid,max(groupname) as groupname from jk_group group by groupid"
  ds.source = sql
  ds.open
  while not ds.eof%>
        <option value="<%=ds("groupid")%>" <%if ds("groupid")=groupid then%>selected<%end if%>><%=ds("groupname")%></option>
		<%ds.movenext
		wend
		ds.close 
	set ds=nothing
%>
      </select></td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">编号:</td>
      <td> <input name="employeeid" type="text" id="employeeid" value="<%=employeeid%>"
	  readonly style="background-color: #cccccc"> 无需填写编号，POS会自动产生编号!</td>
	  <!--以上编号修正原内容<%if act="edit" then%>readonly title="编辑状态营业员编号不允许修改"<%end if%> /> -->
    </tr>
    <tr>
      <td width="7%" bgcolor="#FFEFEF">姓名:</td>
      <td width="93%"><input name="names" type="text" id="names" value="<%=names%>" class="1001">
      </td>
    </tr>
    <tr>
      <td width="7%" bgcolor="#FFEFEF">工号:</td>
      <td width="93%"><input name="job_number" type="text" id="job_number" value="<%=job_number%>" class="1013">
      </td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">性别:</td>
      <td><%if sex="" then sex="女"%>
	  	  <input name="sex" type="radio" value="男" <%if sex="男" or sex="" then %>checked<%end if%> class="1002" />
          男
          <input type="radio" name="sex" value="女" <%if sex="女" then %>checked<%end if%>  class="1002" />
          女
</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">生日:</td>
      <td>
		<%if isnull(birthday)=true then birthday = dateadd("yyyy", -25, date()) %>
		<%if birthday=""  then birthday = dateadd("yyyy", -25, date()) %>
      <input name="birthday" type="text" id="birthday" onFocus="setday(this);" 
      onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"
       onKeyDown="if(event.keyCode==13)event.keyCode=9"
        value="<%=get_date(birthday)%>" size="10" maxlength="10" readonly class="1007"/>
</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">入职日期:</td>
      <td>
		<%if isnull(workdate)=true  then workdate=date()%>
		<%if workdate=""  then workdate=date()%>
      <input name="workdate" type="text" id="Text1" onFocus="setday(this);" 
      onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"
       onKeyDown="if(event.keyCode==13)event.keyCode=9"
        value="<%=get_date(workdate)%>" size="10" maxlength="10" readonly  class="1008"/>
</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">职务</td>
      <td><select name="Position" id="Position" class="1006">
<%
	set ds=Server.CreateObject("ADODB.Recordset")
	ds.ActiveConnection = cn
	  sql="SELECT lookcode,lookname FROM j18_lookupsub WHERE lookupid=1006 order by lookcode "
  ds.source = sql
  ds.open
  while not ds.eof%>
        <option value="<%=ds("lookname")%>" <%if ds("lookname")=Position then%>selected<%end if%>><%=ds("lookname")%></option>
		<%ds.movenext
		wend
		ds.close 
	set ds=nothing
%>
      </select></td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">身份证:</td>
      <td><input name="IDcard" type="text" id="IDcard" maxlength="20" value="<%=IDcard%>" class="1009"/></td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">电话:</td>
      <td><input name="telphone" type="text" id="telphone" size="20" maxlength="20" value="<%=telphone%>" class="1010"/></td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">地址:</td>
      <td><input name="address" type="text" id="address" size="50" maxlength="80" value="<%=address%>" class="1011"/></td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">年销售目标:</td>
      <td><input type="text" style="width:80px" id="YearGoal" name="YearGoal" value="<%=YearGoal %>" class="1014"/></td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">说明:</td>
      <td><textarea name="comment" cols="50" rows="4" id="comment" class="1012"><%=comment%></textarea>
        <br>
        不要超过50个字符!</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">是否参与提成:</td>
      <td><input name="usedstatus" type="checkbox" id="usedstatus" value="1" 
								<%if usedstatus or usedstatus="" then%>checked<%end if%> />
      参与提成请打勾</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">在职:</td>
      <td><input name="valid" type="checkbox" id="valid" value="0" 
								<%if valid=0 or usedstatus="" then%>checked<%end if%> />
      如果此营业员已离职或已不在本店铺请将此勾去掉</td>
    </tr>
    <tr>
      <td bgcolor="#FFEFEF">&nbsp;</td>
      <td><input type="submit" name="Submit" value="提交">
          <input type="reset" name="Submit" value="重置"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
