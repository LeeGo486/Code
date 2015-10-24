<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_sstate, App_Web_sstate.aspx.d7a0d114" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<%@ OutputCache Duration="1" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<link rel="stylesheet" type="text/css" href="../../css/project.css">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script Language="JavaScript"  type="text/javascript">
			function click_model(ID){
			
				targetelement= document.getElementById(ID);//document.all(ID);
				cname=targetelement.innerHTML;
				
				setParentValue('tbvstate',ID);
				setParentValue('tbstate',cname);
				
				var closeID = document.getElementById("closeID").value;
				if(closeID==""){
				closeID="选择客户状态";
				}else{
				closeID="添加客户状态";
				}
				CloseWindow(closeID);	//关闭当前窗口
			}
		</script>
</head>
<body  topmargin="0" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="closeID" runat="server" />
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<TBODY>
					<tr>
						<td class="small" style="WIDTH: 212px; HEIGHT: 18px"><FONT face="宋体">关键字:</FONT>
							<asp:TextBox id="tbs" runat="server" CssClass="tbox" Width="152px" ToolTip="可以按编号和名称查询，留空则查询所有"></asp:TextBox></td>
						<td style="HEIGHT: 18px">
							<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton></td>
					</tr>
					<tr>
						<td colspan="2"><table border="1" cellspacing="0" width="100%" cellpadding="1" bordercolorlight="#000000"
								bordercolordark="#eeeeee" onclick="borderize_on(event)" ID="Table1">
								<asp:DataList id="dls" runat="server" BorderColor="#ffffcc" width="100%" CssClass="small">
									<HeaderTemplate>
										<tr class="TableHeader">
											<td align="center" height="25" class="header">选择客户行业</td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr class="TableControl" onMouseover="chgStyle(this,'#fff','#06c')" onMouseout="chgStyle(this,'','')"
											style="CURSOR: hand">
											<td class="menulines" align="center" onClick='javascript:click_model("<%# DataBinder.Eval(Container, "DataItem.stateid") %>")' id='<%# DataBinder.Eval(Container, "DataItem.stateid") %>' name='<%# DataBinder.Eval(Container, "DataItem.state") %>' height="22" >
											<%# DataBinder.Eval(Container, "DataItem.state") %>
											</td>
										</tr>
									</ItemTemplate>
								</asp:DataList><TBODY></TBODY></table>
						</td>
					</tr>
					<TR>
						<TD colSpan="2">&nbsp;
							<webdiyer:AspNetpager id="ap" runat="server" PageSize="7" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></TD>
					</TR>
				</TBODY>
			</table>
    </div>
    </form>
</body>
</html>
