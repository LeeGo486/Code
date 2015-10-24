<%@ page language="C#" autoeventwireup="true" inherits="Project_client_e_linkman_add, App_Web_e_linkman_add.aspx.fc906236" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    	<title>新增联系人</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script src="../../js/project.js" type="text/javascript"></script>
		<base target="_self">
</head>
<body topMargin="1" leftmargin="0" rightmargin="0">
    <form id="form1" runat="server">
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
        <div id="jstable">

				<div class="header" align="center"><asp:label id="lbtitle" runat="server"></asp:label></div>
                <div style="font-size:14px;color:Green; text-align:center;"><asp:Label ID="TipLabel" runat="server" Text=""></asp:Label></div>
				<table title="带*为必填项目" cellSpacing="2" cellPadding="1" width="368" align="center" bgColor="#eefaff"
					border="0">
					<!--
				<tr>
					<td class="tdright" width="304">编号:</td>
					<td class="tdwhite" width="287"><asp:textbox id="tbcode" accessKey="a" runat="server" Width="88px" ToolTip="不能和已有编号重复!" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)" cssclass="on"
							MaxLength="8" strnum="y" cname="联系人编号" nullable="n"></asp:textbox><FONT face="宋体" color="#ff0033">*</FONT></td>
				</tr>-->
					<tr>
						<td class="tdright" width="100">姓名:</td>
						<td class="tdwhite"><asp:textbox id="tbname" accessKey="b" runat="server" Width="152px" cssclass="on" MaxLength="100" cname="姓名" nullable="n"></asp:textbox>
                                <font color="#ff0033"> *  <asp:CheckBox ID="ckprivate" runat="server" Text="私有,不公开" ToolTip="打勾表示私有，只有本人可以看到。" /></font></td>
					</tr>
                     <!--
				<tr>
					<td class="tdright">住址:</td>
					<td class="tdwhite"><asp:textbox id="tbaddress" runat="server" Width="256px" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)" cssclass="on" MaxLength="100" cname="地址"></asp:textbox><FONT face="宋体" color="#ff0033"></FONT></td>
				</tr>-->
					<tr>
						<td class="tdright">职务:</td>
						<td class="tdwhite"><asp:textbox id="tbduty" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">部门:</td>
						<td class="tdwhite"><asp:textbox id="tbdepartment" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">电话:</td>
						<td class="tdwhite"><asp:textbox id="Tbphone" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">手机:</td>
						<td class="tdwhite"><asp:textbox datatype="n" cname="手机" id="tbmobile" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">电子邮件:</td>
						<td class="tdwhite"><asp:textbox id="tbemail" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox>
								<asp:regularexpressionvalidator id="rvs" runat="server" ControlToValidate="tbemail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
								ErrorMessage="邮件格式不对"></asp:regularexpressionvalidator></td>
					</tr>
					<tr>
						<td class="tdright">MSN或QQ:</td>
						<td class="tdwhite"><asp:textbox id="tbmsn" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">爱好:</td>
						<td class="tdwhite"><asp:textbox id="tbhobby" runat="server" Width="152px" cssclass="on" MaxLength="100"></asp:textbox></td>
					</tr>
					<TR>
						<td class="tdright">负责内容:</td>
						<td class="tdwhite"><asp:textbox id="tbremark" runat="server" MaxLength="100" cssclass="on" Width="152px"></asp:textbox></td>
					</TR>
					<tr>
						<td class="tdHighlight" ><FONT face="宋体">所属公司:</FONT></td>
						<td class="tdwhite" style="HEIGHT: 18px">
                        <INPUT class="tbox1" id="tbcompany" style="WIDTH: 132px; HEIGHT: 18px" readOnly="readonly" type="text"
                        size="16" name="tbcompany" runat="server">
                        <INPUT class="button" onclick="LoadWindow('../../project/module/selcompany.aspx',400,250,'选择所属公司',true)"
                         type="button" value="选择..">
                        <!-- onclick="LoadWindow('../../project/client/e_client_add.aspx',600,450,'添加所属公司',true)"-->
                        <INPUT class="button" type="button"
                        onclick="LoadClass('Project/client/e_client_add.aspx','新增客户')" value="添加..">
                        <INPUT id="tbid" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden2" runat="server"></td>
					</tr>
					<tr>
						<td class="tip" colSpan="2" align="center">
							<asp:button id="btsave" accessKey="s" runat="server" CssClass="btn" Text="保存(S)" OnClick="btsave_Click"></asp:button>
              &nbsp;
              <INPUT class="btn" accessKey="z" onclick="javascript:closeTab(0);" type="button" value="关闭(Z)">
                
                <INPUT id="tbpostcode" type="hidden" name="Hidden2"
								runat="server"><INPUT id="tbaddress" type="hidden" ></td>
					</tr>
				</table>
			</div>
			<script type="text/javascript" defer="defer">
              var title = document.getElementById("lbtitle").innerHTML;
              justNew(self.location.href,title)
              jsTable('jstable','lr','65%','120','center')
            </script>
    </form>
</body>
</html>
