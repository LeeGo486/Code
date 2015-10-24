<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_sproject, App_Web_sproject.aspx.d7a0d114" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <title>选择项目</title>
		<link rel="stylesheet" type="text/css" href="../../css/project.css">
		<base target="_self">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script Language="JavaScript"  type="text/javascript">
			function click_model(ID){
			
				targetelement= document.getElementById(ID);
				cname=targetelement.innerHTML;
				
				setParentValue('tbvpri',ID);
				setParentValue('tbpri',cname);
				
				CloseWindow('选择项目');	//关闭当前窗口
			}

function click_model(ID)
{
  targetelement=document.all(ID);
  cname=targetelement.name1;
  //=========父窗口要有tbvpjt,tbnpjt二个控件=====
  parent_window.document.all.tbvpjt.value=ID;
  parent_window.document.all.tbnpjt.value=cname;

  window.close();
}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td class="small" style="WIDTH: 212px; HEIGHT: 18px"><FONT face="宋体">关键字:</FONT>
						<asp:TextBox id="tbs" runat="server" CssClass="tbox" Width="152px" ToolTip="可以按项目名称及编号查询，留空则查询所有"></asp:TextBox></td>
					<td style="HEIGHT: 18px">
						<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton></td>
				</tr>
				<tr>
					<td colspan="2"><table border="1" cellspacing="0" width="100%" cellpadding="1" bordercolorlight="#000000"
							bordercolordark="#eeeeee" onclick="borderize_on1(event)" ID="Table1">
							<asp:DataList id="dls" runat="server" width="99%" CssClass="small" BorderStyle="Solid" BorderColor="#cccccc"
								CellPadding="1" CellSpacing="1">
								<HeaderTemplate>
									<tr>
										<td class="header" align="center">选择公司</td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr class="TableControl" onMouseover="chgStyle(this,'#fff','#06c')" onMouseout="chgStyle(this,'','')"
										style="CURSOR: hand">
										<td class="menulines" align="center" onClick='javascript:click_model("<%# DataBinder.Eval(Container, "DataItem.pjtnumber") %>")' name1='<%# DataBinder.Eval(Container, "DataItem.pjtname") %>' height="22" id='<%# DataBinder.Eval(Container, "DataItem.pjtnumber") %>'  >
											<%# DataBinder.Eval(Container, "DataItem.pjtname") %>
										</td>
									</tr>
								</ItemTemplate>
							</asp:DataList></table>
					</td>
				<tr>
					<td colspan="2" style="height: 19px">&nbsp;
						<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
					</td>
				</tr>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
