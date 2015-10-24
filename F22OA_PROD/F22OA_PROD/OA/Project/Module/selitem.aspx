<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_selitem, App_Web_selitem.aspx.d7a0d114" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>selItem</title>
		
		<link rel="stylesheet" type="text/css" href="../../table.css">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script Language="JavaScript" type="text/javascript">
			function click_model(ID){
			
				targetelement= document.getElementById(ID);//document.all(ID);
				cname=targetelement.innerHTML;
				
				setParentValue('tbpjtid',ID);	//负值给tbvlinkman
				setParentValue('lbmc',cname);	//负值给tblinkman
				
				CloseWindow('选择主联系人');	//关闭当前窗口
			}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td class="small" style="WIDTH: 288px; HEIGHT: 18px"><FONT face="宋体">关键字:</FONT>
						<asp:TextBox id="tbs" runat="server" CssClass="textbox" Width="190px"></asp:TextBox></td>
					<td style="HEIGHT: 18px">
						<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/menu/find.gif" OnClick="imbSearch_Click"></asp:ImageButton></td>
				</tr>
				<tr>
					<td colspan="2"><table border="1" cellspacing="0" width="100%" cellpadding="1" bordercolorlight="#000000"
							bordercolordark="#eeeeee" onclick="borderize_on1(event)" ID="Table1">
							<asp:DataList id="dlcompany" runat="server" BorderColor="#ffffcc" width="100%" CssClass="small">
								<HeaderTemplate>
									<tr class="TableHeader">
										<td bgcolor="#d6e7ef" align="center" height="25" class="header"><b>选择跟踪的项目</b></td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr class="TableControl" onMouseover="chgStyle(this,'#fff','#06c')" onMouseout="chgStyle(this,'','')"
										style="CURSOR: hand">
										<td class="menulines" align="center" onClick='javascript:click_model("<%# DataBinder.Eval(Container, "DataItem.id") %>")' id='<%# DataBinder.Eval(Container, "DataItem.id") %>'  name='<%# DataBinder.Eval(Container, "DataItem.pjtname") %>'>
											<%# DataBinder.Eval(Container, "DataItem.pjtname") %>
										</td>
									</tr>
								</ItemTemplate>
							</asp:DataList></table>
						<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
