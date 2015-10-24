<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_slinkman, App_Web_slinkman.aspx.d7a0d114" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<%@ OutputCache Duration="1" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>选择联系人</title>

		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script  language="javascript"  type="text/javascript">
			function click_model(ID){
			
				targetelement= document.getElementById(ID);//document.all(ID);
				cname=targetelement.innerHTML;
				
				setParentValue('tbvlinkman',ID);	//负值给tbvlinkman
				setParentValue('tblinkman',cname);	//负值给tblinkman
				
				CloseWindow('选择主联系人');	//关闭当前窗口
			}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="CONTENT">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			
						<tr>
							<td class="small" style="WIDTH: 212px; HEIGHT: 18px"><FONT face="宋体">关键字:</FONT>
								<asp:TextBox id="tbs" runat="server" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)"
									cssclass="on" Width="152px" ToolTip="可以按编号和名称查询，留空则查询所有"></asp:TextBox></td>
							<td style="HEIGHT: 18px">
								<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton></td>
						</tr>
						<tr>
							<td colspan="2"><table border="1" cellspacing="0" width="100%" cellpadding="1" bordercolorlight="#000000"
									bordercolordark="#eeeeee" onclick="borderize_on(event)" ID="Table1">
									<asp:DataList id="dls" runat="server" BorderColor="#ffffcc" width="100%" CssClass="small">
										<HeaderTemplate>
											<tr class="TableHeader">
												<td align="center" height="25" class="header">选择联系人</td>
											</tr>
										</HeaderTemplate>
										<ItemTemplate>
											<tr class="TableControl" onMouseover="chgStyle(this,'#fff','#06c')" onMouseout="chgStyle(this,'','')"
												style="CURSOR: hand">
												<td class="menulines" align="center" onClick='javascript:click_model("<%# DataBinder.Eval(Container, "DataItem.contactid") %>")' id='<%# DataBinder.Eval(Container, "DataItem.contactid") %>' height="22px"><%# DataBinder.Eval(Container, "DataItem.username") %></td>
											</tr>
										</ItemTemplate>
									</asp:DataList></table>
							</td>
						</tr>
						<TR>
							<TD colSpan="2">&nbsp;
								<webdiyer:AspNetpager id="ap" runat="server" PageSize="7" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></TD>
						</TR>
					
				</table>
    </div>
    </form>
</body>
</html>
