<%@ page language="C#" autoeventwireup="true" inherits="Project_client_e_client_add, App_Web_e_client_add.aspx.fc906236" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新增客户</title>
	<base target="_self" />		
		<link href="../../css/project.css" type="text/css" rel="stylesheet" />
		<script src="../../js/project.js" type="text/javascript"></script>


</head>
<body topMargin="1" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
				<div class="header" align="center"><asp:label id="lbtitle" runat="server"></asp:label></div>
				<div style="font-size:14px;color:Green; text-align:center;"><asp:label id="TipLabel" runat="server"></asp:label></div>
        
    <div id="jstable">
				<table title="带*为必填项目" cellSpacing="2" cellPadding="1"
					width="668" align="center" bgColor="#eefaff" border="0">
					<tr>
						<td class="tdright">编号(A):</td>
						<td class="tdwhite">
                        <asp:textbox id="tbcode" accessKey="a" runat="server" Width="88px"
                         ToolTip="不能和已有编号重复!" cssclass="on" MaxLength="8" strnum="y" cname="客户编号" nullable="n"></asp:textbox>
                        <FONT color="#ff0033">*</FONT><FONT face="宋体" color="#ff0033"><asp:CheckBox ID="ckPublic" runat="server" Text="私有,不公开"
                          ToolTip="打勾表示私有，只能自己看到。注意只有公共客户才能在项目中被引用" /></font></td>
					</tr>
					<tr>
						<td class="tdright">公司名(B):</td>
						<td class="tdwhite"><asp:textbox id="tbcompany" accessKey="b" runat="server" Width="216px" CssClass="on" MaxLength="100"
								cname="公司名" nullable="n"></asp:textbox><FONT face="宋体" color="#ff0033">*</FONT></td>
					</tr>
					<tr>
						<td class="tdright">地址(D):</td>
						<td class="tdwhite"><asp:textbox id="tbaddress" runat="server" Width="216px"
								cssclass="on" MaxLength="100" cname="地址" nullable="n" accessKey="D"></asp:textbox><FONT face="宋体" color="#ff0033">*</FONT></td>
					</tr>
					<tr>
						<td class="tdright">电话(E):</td>
						<td class="tdwhite"><asp:textbox id="tbphone" runat="server" Width="152px"
								cssclass="on" MaxLength="100" accessKey="E"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">传真(F):</td>
						<td class="tdwhite"><asp:textbox id="tbfax" runat="server" Width="152px"
								cssclass="on" MaxLength="100" accessKey="F"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdright">网址(G):</td>
						<td class="tdwhite"><asp:textbox id="tbwebsite" runat="server" Width="152px"
								cssclass="on" MaxLength="100" accessKey="G"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tdHighlight">主联系人:</td>
						<td class="tdwhite"><INPUT class="tbox1" id="tblinkman" style="WIDTH: 104px; HEIGHT: 18px" readOnly type="text"
								size="12" name="tbcompany" runat="server">&nbsp;<INPUT class="button" onclick="LoadWindow('../../Project/Module/sLinkman.aspx',360,400,'选择主联系人',true,'50%')" type="button"
								value="选择..">&nbsp;
                                
                                <INPUT class="button"
                                onclick="LoadClass('Project/client/e_linkman_add.aspx','新增联系人')"
                                type="button" value="添加..">
                                 <!--onclick="LoadWindow('../../Project/client/e_linkman_add.aspx',600,450,'添加主联系人',true)"--> 
                                 
                                 
                                 <INPUT id="tbvlinkman" style="WIDTH: 13px; HEIGHT: 10px" type="hidden" size="1" name="Hidden2"
								runat="server"></td>
					</tr>
					<tr>
						<td class="tdright">电子邮件:</td>
						<td class="tdwhite"><asp:textbox id="tbemail" runat="server" Width="152px"
								cssclass="on" MaxLength="100"></asp:textbox><asp:regularexpressionvalidator id="rvs" runat="server" ControlToValidate="tbemail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="邮件格式不对"></asp:regularexpressionvalidator></td>
					</tr>
					<tr>
						<td class="tdright">邮编:</td>
						<td class="tdwhite"><asp:textbox id="tbpostcode" runat="server" Width="152px"
								cssclass="on" MaxLength="100" cname="邮编" datatype="n"></asp:textbox></td>
					</tr>
					<TR>
						<td class="tdright">公司成立时间:</td>
						<td class="tdwhite">
                            <igsch:webdatechooser id="wdc" runat="server"></igsch:webdatechooser>
                            <expandeffects shadowcolor="LightGray">
</expandeffects>
                        </td>
					</TR>
					<tr>
						<td class="tdHighlight" style="WIDTH: 304px; HEIGHT: 18px">级别:</td>
						<td class="tdwhite" style="HEIGHT: 18px"><INPUT class="tbox1" id="tbpri" style="WIDTH: 104px; HEIGHT: 18px" readOnly type="text"
								size="12" name="tbcompany" runat="server">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/Module/spri.aspx',340,260,'选择级别',true)" type="button"
								value="选择..">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/client/mng_pri_add.aspx',340,220,'添加级别',true)" type="button" value="添加.."><INPUT id="tbvpri" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden2"
								runat="server"></td>
					</tr>
					<tr>
						<td class="tdHighlight" style="WIDTH: 304px; HEIGHT: 18px">所属行业:</td>
						<td class="tdwhite" style="HEIGHT: 18px"><INPUT class="tbox1" id="tbway" style="WIDTH: 104px; HEIGHT: 18px" readOnly type="text"
								size="12" name="tbcompany" runat="server">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/Module/sWay.aspx',340,260,'选择所属行业',true)" type="button"
								value="选择..">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/client/mng_way_add.aspx',340,220,'添加所属行业',true)" type="button" value="添加.."><INPUT id="tbvway" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden2"
								runat="server"></td>
					</tr>
					<tr>
						<td class="tdHighlight">客户来源:</td>
						<td class="tdwhite"><INPUT class="tbox1" id="tbsource" style="WIDTH: 104px; HEIGHT: 18px" readOnly type="text"
								size="12" name="tbcompany" runat="server">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/Module/sSource.aspx',340,260,'选择客户来源',true)" type="button"
								value="选择..">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/client/mng_source_add.aspx',340,220,'添加客户来源',true)" type="button" value="添加.."><INPUT id="tbvsource" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden2"
								runat="server"></td>
					</tr>
					<tr>
						<td class="tdHighlight">客户状态:</td>
						<td class="tdwhite"><INPUT class="tbox1" id="tbstate" style="WIDTH: 104px; HEIGHT: 18px" readOnly type="text"
								size="12" name="tbcompany" runat="server">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/Module/sState.aspx',340,260,'选择客户状态',true)" type="button"
								value="选择..">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/client/mng_state_add.aspx',340,220,'添加客户状态',true)" type="button" value="添加.."><INPUT id="tbvstate" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden3"
								runat="server"></td>
					</tr>
					<tr>
						<td class="tdHighlight">客户类别:</td>
						<td class="tdwhite"><INPUT class="tbox1" id="tbsort" style="WIDTH: 104px; HEIGHT: 18px" readOnly type="text"
								size="12" name="tbcompany" runat="server">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/Module/sSort.aspx',340,260,'选择客户类型',true)" type="button"
								value="选择..">&nbsp;<INPUT class="button" onclick="LoadWindow('../../project/client/mng_sort_add.aspx',340,220,'添加客户类型',true)" type="button" value="添加.."><INPUT id="tbvsort" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden4"
								runat="server"></td>
					</tr>
					<tr>
						<td class="tdright" style="WIDTH: 304px; HEIGHT: 1px">备注:</td>
						<td class="tdwhite" style="HEIGHT: 1px"><asp:textbox id="tbremark" runat="server" Width="216px"
								cssclass="on" MaxLength="100" TextMode="MultiLine" Height="52px"></asp:textbox></td>
					</tr>
					<tr>
						<td class="tip" colSpan="2" align="center">
							<asp:button id="btsave" accessKey="s" runat="server" CssClass="btn" Text="保存(S)" OnClick="btsave_Click"></asp:button>
              &nbsp;
              <INPUT class="btn" accessKey="z" onclick="javascript:closeTab(0);" type="button" value="关闭(Z)"></td>
					</tr>
				</table>
    </div>
        <script type="text/javascript">
              var title = document.getElementById("lbtitle").innerHTML;
              justNew(self.location.href,title)
				jsTable('jstable','lr','65%','120','center')
        </script>
        
    </form>
</body>
</html>
