<%@ page language="C#" autoeventwireup="true" inherits="Project_show_client_one, App_Web_client_one.aspx.8e3465e2" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>client_add</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<SCRIPT type="text/javascript" src="../../js/project.js"></SCRIPT>
		<SCRIPT language="javascript" type="text/javascript">
var oblog_bIsIE5=document.all;
var canusehtml='1';
var PostType=1;

			function checknull(){
				if(document.all.tbshort.value==""){
					alert("请输入客户简称!");
					return false;
				}else{
					return true;
				}
			}
			
		</SCRIPT>
		<style type="text/css">.STYLE1 { COLOR: #ffffff }
		</style>
</head>
<body  leftMargin="0" topMargin="1">
    <form id="form1" runat="server">
    <div>
    <div class=content>
		        <h2><strong>客户详细信息</strong></h2>
		    </div>
      <div id="lrtable">
			<table cellSpacing="1" cellPadding="0" width="471" bgColor="#bbbbbb" border="0" align="center">
				
				<tr>
					<td noWrap height="22" class="tdHighlight">公司名称:</td>
					<td class="tdleft" onkeydown="if(event.keyCode==13)event.keyCode=9" colSpan="3" height="22"><asp:label id="tbcompany" runat="server" Width="99%"></asp:label></td>
				</tr>
				<tr>
					<td height="22" class="tdHighlight">地 址:</td>
					<td class="tdleft" colSpan="3" height="22"><asp:label id="tbaddr" runat="server" Width="99%"></asp:label></td>
				</tr>
				<tr>
					<td height="22" class="tdHighlight">客户编号:</td>
					<td class="tdleft" height="22"><asp:label id="tbshort" runat="server" Width="99%"></asp:label></td>
					<td class="jsTitle" noWrap height="22">邮编:</td>
					<td class="tdleft" height="22"><asp:label id="tbpostcode" runat="server" Width="99%"></asp:label></td>
				</tr>
				<tr>
					<td height="22" class="tdHighlight">传 真:</td>
					<td class="tdleft" height="22"><asp:label id="tbfax" runat="server" Width="99%"></asp:label></td>
					<td height="22" class="jsTitle">单位电话:</td>
					<td class="tdleft" height="22"><asp:label id="tbphone" runat="server" Width="99%"></asp:label></td>
				</tr>
				<tr>
					<td height="22" class="tdHighlight">电子邮件:</td>
					<td class="tdleft" height="22"><asp:label id="tbemail" runat="server" Width="162px"></asp:label></td>
					<td height="22" class="jsTitle">成立日期:</td>
					<td class="tdleft" height="22">
						<asp:Label id="lbdate" runat="server"></asp:Label></td>
				</tr>
				<tr>
					<td height="22" class="tdHighlight">主联系人:</td>
					<td class="tdleft" height="22"><asp:label id="tbcontact" runat="server" Width="99%"></asp:label></td>
					<td height="22" class="jsTitle">网 址:</td>
					<td class="tdleft" height="22"><asp:label id="tbwebsite" runat="server" Width="99%"></asp:label></td>
				</tr>
				<tr>
					<td height="22" class="tdHighlight">备注:</td>
					<td colspan="3" class="tdleft" height="22"><asp:label id="tbremark" runat="server" Width="99%"></asp:label></td>
				</tr>
				<tr>
					<td colspan="4" class="tip" align="center">
          <span id="closespan"></span>
				</tr>
			</table>
      </div>
      <div id="tmtable">
      <asp:DataGrid id="dg" runat="server" Width="528px" AutoGenerateColumns="False" BorderColor="#336666"
        BorderStyle="Double" BorderWidth="3px" BackColor="White" CellPadding="4" GridLines="Horizontal" OnItemDataBound="dgmain_ItemBound">
        <FooterStyle ForeColor="#333333" BackColor="White"></FooterStyle>
        <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#339966"></SelectedItemStyle>
        <ItemStyle ForeColor="#333333" BackColor="White"></ItemStyle>
        <HeaderStyle Font-Bold="True" Wrap="False" ForeColor="White" VerticalAlign="Middle" BackColor="#336666"></HeaderStyle>
        <Columns>
          <asp:TemplateColumn HeaderText="联系人姓名">
            <ItemTemplate>
              <a href='linkman_one.aspx?contactid=<%# DataBinder.Eval(Container, "DataItem.contactid") %>&action=show'>
                <%# DataBinder.Eval(Container, "DataItem.username") %>
              </a>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:BoundColumn DataField="duty" HeaderText="职务"></asp:BoundColumn>
          <asp:BoundColumn DataField="department" HeaderText="部门"></asp:BoundColumn>
          <asp:BoundColumn DataField="mobile" HeaderText="手机"></asp:BoundColumn>
          <asp:TemplateColumn HeaderText="电邮">
            <ItemTemplate>
              <a href='mailto:<%# DataBinder.Eval(Container, "DataItem.email") %>'>
                <%# DataBinder.Eval(Container, "DataItem.email") %>
              </a>
            </ItemTemplate>
          </asp:TemplateColumn>
        </Columns>
        <pagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#336666" Mode="NumericPages"></pagerStyle>
      </asp:DataGrid>
      </div>
    </div>
    <script type="text/javascript" defer="defer">
			jsTable('lrtable','lr','90%','100','center')
			jsTable('tmtable','tm','90%','','center')
			goBack("客户联系人","closespan");
    </script>
    </form>
</body>
</html>
