<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_selcompany, App_Web_selcompany.aspx.d7a0d114" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>选择项目公司</title>
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script Language="JavaScript"   type="text/javascript">
			function click_model(ID){
			
				targetelement= document.getElementById(ID);//document.all(ID);
				var cname=targetelement.value;
				if(cname){
					var group = cname.split("{$}");	//分出来
						setParentValue('tbcompany',group[0]);	//负值给tbvlinkman
						setParentValue('tbaddress',group[1]);	//负值给tblinkman
						setParentValue('tbpostcode',group[2]);	//负值给tbvlinkman
						setParentValue('tbid',group[3]);	//负值给tblinkman
						
						CloseWindow('选择所属公司');	//关闭当前窗口
				}
				
			}

/*function click_model(ID)
{
  targetelement=document.all(ID);
  cname=targetelement.name;
  parent_window.document.all.tbcompany.value=cname;
  parent_window.document.all.tbaddress.value=targetelement.name1;
  parent_window.document.all.tbpostcode.value=targetelement.name2;
  parent_window.document.all.tbid.value=targetelement.name3;

  window.close();
}
*/		</script>
</head>
<body  topmargin="0" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td class="small" style="WIDTH: 212px; HEIGHT: 18px"><FONT face="宋体">关键字:</FONT>
						<asp:TextBox id="tbs" runat="server" onfocus="javascript:highlight(1)" onblur="javascript:highlight(0)"
							cssclass="on" Width="152px" ToolTip="可以按地址和公司名查询，留空则查询所有"></asp:TextBox></td>
					<td style="HEIGHT: 18px">
						<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton></td>
				</tr>
				<tr>
					<td colspan="2"><table border="1" cellspacing="0" width="100%" cellpadding="1" bordercolorlight="#000000"
							bordercolordark="#eeeeee" onclick="borderize_on1(event)" ID="Table1">
							<asp:DataList id="dlcompany" runat="server" width="99%" CssClass="small" BorderStyle="Solid" BorderColor="#cccccc"
								CellPadding="1" CellSpacing="1">
								<HeaderTemplate>
									<tr>
										<td class="BOOK_header" align="center">选择公司</td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr class="TableControl" onMouseover="chgStyle(this,'#fff','#06c')" onMouseout="chgStyle(this,'','')"
										style="CURSOR: hand">
										<td class="menulines" align="center" onClick='javascript:click_model(<%# DataBinder.Eval(Container, "DataItem.id") %>)'
                                         height="22">
											<%# DataBinder.Eval(Container, "DataItem.company") %>
                                            <input type="hidden"
                                             value="<%# DataBinder.Eval(Container, "DataItem.company") %>{$}<%# DataBinder.Eval(Container, "DataItem.address") %>{$}<%# DataBinder.Eval(Container, "DataItem.postcode") %>{$}<%# DataBinder.Eval(Container, "DataItem.forshort") %>"
                                              id="<%# DataBinder.Eval(Container, "DataItem.id") %>" />
										</td>
									</tr>
								</ItemTemplate>
							</asp:DataList></table>
					</td>
				<tr>
					<td colspan="2" style="height: 26px">&nbsp;
						<webdiyer:AspNetpager id="ap" runat="server" PageSize="6" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></td>
				</tr>
				</tr>
			</table></div>
    </form>
</body>
</html>
