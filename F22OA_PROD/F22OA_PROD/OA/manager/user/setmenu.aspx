<%@ page language="C#" autoeventwireup="true" inherits="manager_user_setmenu, App_Web_setmenu.aspx.d341d34a" %>
<%@ Reference Page="role.aspx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    EAD>
		<title>菜单</title>
		<META http-equiv="Content-Type" content="text/html; charset=gb2312"/>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="JavaScript" type="text/javascript">
function killErrors()
{
  return true;
}
window.onerror = killErrors;

function check_all(menu_all,MENU_ID)
{

 for (i=0;i<document.all(MENU_ID).length;i++)
 {
   if(menu_all.checked)
      document.all(MENU_ID).item(i).checked=true;
   else
      document.all(MENU_ID).item(i).checked=false;
 }

 if(i==0)
 {
   if(menu_all.checked)
      document.all(MENU_ID).checked=true;
   else
      document.all(MENU_ID).checked=false;
 }
}

function mysubmit(){

	var inputObjects = document.getElementsByTagName("input");
var arrayValues = new Array;
for(var i = 0;i < inputObjects.length;i ++){
if("chk" == inputObjects[i].name && false != inputObjects[i].checked){
arrayValues[arrayValues.length] = inputObjects[i].value;
}
}

  func_id_str="";
 if(document.all("chk").length>0)
 {
      for(j=1;j<document.all("chk").length;j++)
      { 

	    if(document.all("chk").item(j).checked)
	    {
		    func_id_str+=document.all("chk").item(j).value +",";	
		    document.all.hdmenu.value=func_id_str;	
	    } 
      }
  }
		
 
}
function loading(){

	var inputObjects = document.getElementsByTagName("input");
//var arrayValues = new Array;

menuid=document.all.hdmenu.value;
var mid=new Array();
	mid=menuid.split(',');
	
for(var i = 0;i < inputObjects.length;i ++){
if("chk" == inputObjects[i].name )
{
      // arrayValues[arrayValues.length] = inputObjects[i].value;
       		
	
	for (var j=0;j<mid.length;j++)
	{
	  if(mid[j]==inputObjects[i].value)
	inputObjects[i].checked=true;
	}
}
}
	
	
}
		</script>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" onload="loading();">
    <form id="form1" runat="server">
    <div>
    <!--菜单目录-->
			<asp:datalist id="dgmain" runat="server" DataKeyField="id" OnItemDataBound="dgmain_databound"
				RepeatDirection="Horizontal">
				<ItemStyle VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<TABLE>
						<TR style="CURSOR: hand">
							<TD align="center" width="150" background="../../icon/headerbg.gif" colSpan="2" height="24">
								<input type=checkbox value='<%# DataBinder.Eval(Container, "DataItem.id") %>'   onclick="check_all(this,'<%# DataBinder.Eval(Container, "DataItem.ID") %>');" >
								<label><%# DataBinder.Eval(Container, "DataItem.title") %></label>
								</TD>
						</TR>
						<TR>
							<TD colSpan="2"><!--子菜单-->
								<asp:DataList id="dgsub" runat="server" Width="150">
									<AlternatingItemStyle BackColor="#ffffff"></AlternatingItemStyle>
									<ItemStyle BackColor=#eeeeee></ItemStyle>
									<ItemTemplate>
										<table width="100%">
											<TR>
												<TD width="40" bordercolor="AliceBlue"><!--<img src='gif/<%# DataBinder.Eval(Container, "DataItem.icon") %>'>--></TD>
												<TD align="left">
													<input type=checkbox name="chk" id=<%# DataBinder.Eval(Container, "DataItem.parentid") %>  value=<%# DataBinder.Eval(Container, "DataItem.id") %>>
													<label><%# DataBinder.Eval(Container, "DataItem.title") %></label>													
													
												</TD>
											</TR>
										</table>
									</ItemTemplate>
								</asp:DataList><!--end--> 
			</TD></TR></TABLE></ITEMTEMPLATE>
			</asp:DataList><br>
			<asp:Button ID="btok" Runat="server" Text="确定" Width="96px" OnClick="btok_Click" ></asp:Button><a href="role.aspx"> 返回</a>
			<input type="hidden" id="hdmenu" name="hdmenu" runat="server"> 
			<!--end-->
    </div>
    </form>
</body>
</html>
