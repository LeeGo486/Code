<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_selcontact, App_Web_selcontact.aspx.d7a0d114" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>selcontact</title>
		
		<link href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script Language="JavaScript" type="text/javascript">
			function click_model(ID){
				setParentValue('tbcontactid',ID);
				CloseWindow('选择主联系人');	//关闭当前窗口
			}
		</script>
		<script  language="javascript"  type="text/javascript">
			function clickme(ID)
			{  window.location.assign("selcontact.aspx?pjtid=" + window.document.all.tbid.value + "&contactid=" +ID)
				
			}
		</script>
</head>
<body  topmargin="0" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td class="small" style="WIDTH: 288px; HEIGHT: 18px"><FONT face="宋体">名字或手机号:</FONT>
						<asp:TextBox id="tbs" runat="server" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)" cssclass="on" Width="190px"></asp:TextBox></td>
					<td style="HEIGHT: 18px">
						<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/menu/find.gif" OnClick="imbSearch_Click"></asp:ImageButton></td>
				</tr>
				<tr>
					<td colspan="2"><table border="1" cellspacing="0" width="100%" cellpadding="1" bordercolorlight="#000000"
							bordercolordark="#eeeeee" onclick="borderize_on1(event)" ID="Table1">
							<asp:DataList id="dlcompany" runat="server" BorderColor="#ffffcc" width="100%" CssClass="small">
								<HeaderTemplate>
									<tr class="TableHeader">
										<td bgcolor="#d6e7ef" align="center" height="25" class="header"><b>选择联系人</b></td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr class="TableControl" onMouseover="chgStyle(this,'#fff','#06c')" onMouseout="chgStyle(this,'','')"
										style="CURSOR: hand">
										<td class="menulines" align="center" onClick='javascript:clickme("<%# DataBinder.Eval(Container, "DataItem.id") %>")' name='<%# DataBinder.Eval(Container, "DataItem.name") %>' height="22" id='<%# DataBinder.Eval(Container, "DataItem.id") %>' name1='<%# DataBinder.Eval(Container, "DataItem.duty") %>' name2='<%# DataBinder.Eval(Container, "DataItem.mobile") %>'>
											<%# DataBinder.Eval(Container, "DataItem.name") %>
										</td>
									</tr>
								</ItemTemplate>
							</asp:DataList></table>
						<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
					</td>
				</tr>
			</table>
			<INPUT id="tbid" runat="server" type="hidden"/></div>

    </form>
</body>
</html>
