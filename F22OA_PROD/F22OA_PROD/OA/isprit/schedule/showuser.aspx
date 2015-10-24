<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_showuser, App_Web_showuser.aspx.4c52363" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SetUserRole</title>
			<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
		    function menu_click(obj) {
				
			    parent.mainFrame.location="showcalendar.aspx?userid=" + obj.value;
						
			}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="header">选择部门人员</div>
			<div><asp:DropDownList id="ddldepart" runat="server" Width="122px" AutoPostBack="True" BackColor="#C0FFFF" OnSelectedIndexChanged="ddldepart_SelectedIndexChanged"></asp:DropDownList></div>
			<div id="pageleft" style="width: 125px; text-align: center;">
                <asp:DataList ID="dluser" runat="server" ShowFooter="False" ShowHeader="False" CellPadding="4" ForeColor="#333333" Width="124px">
                   <ItemTemplate>
                        <div><%# DataBinder.Eval(Container, "DataItem.username") %>
                        <a href='showcalendar.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>' target="mainFrame">日程</a>
                        <a href='../dailylog/Dialyog_Month.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>' target="mainFrame">日志</a>
                        </div>
                   </ItemTemplate>
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <AlternatingItemStyle BackColor="White" />
                    <ItemStyle BackColor="#E3EAEB" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                </asp:DataList></div>
		
			
            <div id="footer"></div>				
    </div>
    </form>
</body>
</html>
