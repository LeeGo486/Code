<%@ page language="C#" autoeventwireup="true" inherits="help_help_showmenu, App_Web_help_showmenu.aspx.87a0902e" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    		<title>选择菜单</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
		<LINK href="table.css" type="text/css" rel="STYLESHEET">
		<base target="_self">
		<script language="JavaScript">
var parent_window = parent.dialogArguments;

function click_user(user_id,menuid,menuname)
{
  
 
  targetelement=window.document.all(user_id);
  user_name=targetelement.name;

//  if(TO_VAL.indexOf(","+user_id+",")<0 && TO_VAL.indexOf(user_id+",")!=0)
//  {
    parent_window.document.all.to_id.value=user_id;
    parent_window.document.all.to_name.value=user_name;
    parent_window.document.all.to_menuid.value=menuid;
     parent_window.document.all.to_menuname.value=menuname;
    borderize_on(targetelement);
//  }
//  else
//  {
//    parent_window.document.all.to_id.value=parent_window.document.all.to_id.value.replace(user_id+",","");
//    parent_window.document.all.to_name.value=parent_window.document.all.to_name.value.replace(user_name+",","");
//    borderize_off(targetelement);
//  }
}

function borderize_on(targetelement)
{
 color="#003FBF";
 targetelement.style.borderColor="black";
 targetelement.style.backgroundColor=color;
 targetelement.style.color="white";
 targetelement.style.fontWeight="bold";
}

function borderize_off(targetelement)
{
  targetelement.style.backgroundColor="";
  targetelement.style.borderColor="";
  targetelement.style.color="";
  targetelement.style.fontWeight="";
}

function begin_set()
{
  TO_VAL=parent_window.document.all.to_id.value;
  //调置墨认焦点
  document.all.tbmain.focus(); 
  
  for (step_i=0; step_i<document.all.length; step_i++)
  {
    if(document.all(step_i).className=="menulines")
    {
       user_id=document.all(step_i).id;
       if(TO_VAL.indexOf(","+user_id+",")>0 || TO_VAL.indexOf(user_id+",")==0)
          borderize_on(document.all(step_i));
    }
  }
}

function add_all()
{
  TO_VAL=parent_window.document.all.to_id.value;
  for (step_i=0; step_i<document.all.length; step_i++)
  {
    if(document.all(step_i).className=="menulines")
    {
       user_id=document.all(step_i).id;
       user_name=document.all(step_i).name;

       if(TO_VAL.indexOf(","+user_id+",")<0 && TO_VAL.indexOf(user_id+",")!=0)
       {
         parent_window.document.all.to_id.value+=user_id+",";
         parent_window.document.all.to_name.value+=user_name+",";
         borderize_on(document.all(step_i));
       }
    }
  }
}

function del_all()
{
  for (step_i=0; step_i<document.all.length; step_i++)
  {
    if(document.all(step_i).className=="menulines")
    {
       user_id=document.all(step_i).id;
       user_name=document.all(step_i).name;
       parent_window.document.all.to_id.value=parent_window.document.all.to_id.value.replace(user_id+",","");
       parent_window.document.all.to_name.value=parent_window.document.all.to_name.value.replace(user_name+",","");
       borderize_off(document.all(step_i));
    }
  }
}
		</script>
</head>
<body topmargin="0" leftmargin="0" onload="begin_set()">
    <form id="form1" runat="server">
    <div>
    <table  border="0" align="center" cellpadding="1" cellspacing="1" style="WIDTH: 269px;"
				bgColor="honeydew" tabIndex="4">
				<tr>
					<td align="center" valign="top" style="WIDTH: 137px;">
						<asp:DropDownList id="ddl" runat="server" Width="131px" AutoPostBack="True" tabIndex="1" BackColor="#00C000" ForeColor="White" OnSelectedIndexChanged="ddl_SelectedIndexChanged">
							<asp:ListItem Value="0">选择菜单组</asp:ListItem>
						</asp:DropDownList><br>
						<asp:listbox id="lbdep" runat="server" Width="160px" AutoPostBack="True" BackColor="Menu" ForeColor="Navy"
							Height="400px" accessKey="a" OnSelectedIndexChanged="lbdep_SelectedIndexChanged"></asp:listbox></td>
					<td rowspan="2" align="center" valign="top">
						<TABLE id="tbmain" cellSpacing="0" cellPadding="0" width="300px" border="0" 
							tabIndex="3">
							<TR>
								<TD style="CURSOR: hand; HEIGHT: 12px" align="center" bgColor="#33cccc"><FONT face="宋体" size="2"></FONT></TD>
							</TR>
							<TR>
								<TD style="CURSOR: hand; HEIGHT: 18px"  align="center" bgColor="#6699cc"><FONT face="宋体" size="2"></FONT></TD>
							</TR>
							<TR>
								<TD vAlign="top" align="center"><table width="100" cellpadding="0" cellspacing="0" border="0">
										<asp:datalist id="dluser" runat="server" Width="100%" BackColor="White" BorderWidth="1px" GridLines="Horizontal"
											CellPadding="3" BorderStyle="None" BorderColor="#E7E7FF">
											<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
											<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
											<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
											<ItemStyle ForeColor="#4A3C8C" BackColor="#E7E7FF"></ItemStyle>
											<ItemTemplate>
												<tr width="100%" class="TableLine2">
													<td  id='<%# DataBinder.Eval(Container, "DataItem.menusubid") %>' name='<%# DataBinder.Eval(Container, "DataItem.menuname") %>'     onclick='javascript:click_user("<%# Eval("menusubid") %>","<%# Eval("menuid") %>","<%# Eval("groupname") %>")'  class="menulines" align="center" style="cursor:hand">
														<%# DataBinder.Eval(Container, "DataItem.menuname")%>
													</td>
												</tr>
											</ItemTemplate>
											<HeaderStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#4A3C8C"></HeaderStyle>
										</asp:datalist></table>
								</TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>

