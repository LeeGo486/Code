<%@ page language="C#" autoeventwireup="true" inherits="Project_show_linkman_one, App_Web_linkman_one.aspx.8e3465e2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>linkman_one</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div class=content><h2><strong>联系人详细资料</strong></h2></div>
			<TABLE id="Table1" cellSpacing="2" cellPadding="1" width="368" align="center" bgColor="#eefaff"
				border="0">
			
				<TR>
					<TD class="tdright" style="WIDTH: 101px">姓名:</TD>
					<TD class="tdwhite">
						<asp:label id="tbname" accessKey="b" runat="server" cssclass="on" cname="姓名" nullable="n"></asp:label><FONT face="宋体" color="#ff0033"></FONT></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">职务:</TD>
					<TD class="tdwhite">
						<asp:label id="tbduty" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">部门:</TD>
					<TD class="tdwhite">
						<asp:label id="tbdepartment" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">电话:</TD>
					<TD class="tdwhite">
						<asp:label id="Tbphone" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">手机:</TD>
					<TD class="tdwhite">
						<asp:label id="tbmobile" runat="server" cssclass="on" cname="手机" datatype="n"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">电子邮件:</TD>
					<TD class="tdwhite">
						<asp:label id="tbemail" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">MSN或QQ:</TD>
					<TD class="tdwhite">
						<asp:label id="tbmsn" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">爱好:</TD>
					<TD class="tdwhite">
						<asp:label id="tbhobby" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="WIDTH: 101px">负责内容:</TD>
					<TD class="tdwhite">
						<asp:label id="tbremark" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdHighlight">所属公司:</TD>
					<TD class="tdwhite" style="HEIGHT: 18px">
						<asp:label id="tbcompany" runat="server" cssclass="on"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tip" align="center" colSpan="2"><a href="javascript:history.go(-1)">返回</a></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
