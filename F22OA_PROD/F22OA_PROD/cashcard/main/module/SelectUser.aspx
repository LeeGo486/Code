<%@ page language="C#" autoeventwireup="true" inherits="module_SelectUser, App_Web_selectuser.aspx.4601d547" %>

<%@ Register Src="../Usercontrol/web_TreeFram.ascx" TagName="web_TreeFram" TagPrefix="uc1" %>
<%@ OutputCache Duration="6000" VaryByControl="WebTreejms" Location="Client" VaryByParam="none" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebNavigator.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebNavigator" TagPrefix="ignav" %>
<%@ Register Assembly="Infragistics2.WebUI.Misc.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>选择用户</title>
    <link href="../css/default.css" type="text/css" rel="stylesheet" />
    <link href="../css/table.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
    <script language="JavaScript" type="text/javascript">
var parent_window = parent.dialogArguments;

function click_user(user_id)
{
  
  TO_VAL=parent_window.document.all.TO_ID.value;
  targetelement=window.document.all(user_id);
  user_name=targetelement.name;

  if(TO_VAL.indexOf(","+user_id+",")<0 && TO_VAL.indexOf(user_id+",")!=0)
  {
    parent_window.document.all.TO_ID.value+=user_id+",";
    parent_window.document.all.TO_NAME.value+=user_name+",";
    borderize_on(targetelement);
  }
  else
  {
    parent_window.document.all.TO_ID.value=parent_window.document.all.TO_ID.value.replace(user_id+",","");
    parent_window.document.all.TO_NAME.value=parent_window.document.all.TO_NAME.value.replace(user_name+",","");
    borderize_off(targetelement);
  }
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
  TO_VAL=parent_window.document.all.TO_ID.value;
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
  TO_VAL=parent_window.document.all.TO_ID.value;
  for (step_i=0; step_i<document.all.length; step_i++)
  {
    if(document.all(step_i).className=="menulines")
    {
       user_id=document.all(step_i).id;
       user_name=document.all(step_i).name;

       if(TO_VAL.indexOf(","+user_id+",")<0 && TO_VAL.indexOf(user_id+",")!=0)
       {
         parent_window.document.all.TO_ID.value+=user_id+",";
         parent_window.document.all.TO_NAME.value+=user_name+",";
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
       parent_window.document.all.TO_ID.value=parent_window.document.all.TO_ID.value.replace(user_id+",","");
       parent_window.document.all.TO_NAME.value=parent_window.document.all.TO_NAME.value.replace(user_name+",","");
       borderize_off(document.all(step_i));
    }
  }
}
		</script>
</head>
<body onload="javascript:begin_set();" style="margin:0px;">
    <form id="frmMain" runat="server">
     
            <table style="margin:1px 1px 0px 1px; vertical-align:middle; " cellpadding="1" cellspacing="1" >
            <tr><td  valign="top" style="width: 139px; height: 138px">
                <ignav:UltraWebTree ID="uwtree" runat="server" AutoPostBack="true" DefaultImage="ig_treeFolder.gif" DefaultSelectedImage="ig_treeFolderOpen.gif" FileUrl="" Height="285px" LeafNodeImageUrl="" OnNodeClicked="uwtree_NodeClicked" ParentNodeImageUrl="" RootNodeImageUrl="" TargetFrame="" TargetUrl="" WebTreeTarget="ClassicTree" Width="158px">
                    <NodeEditStyle Font-Names="Microsoft Sans Serif" Font-Size="9pt">
                    </NodeEditStyle>
                    <SelectedNodeStyle BackColor="Navy" BorderStyle="Solid" BorderWidth="1px" Cursor="Default"
                        ForeColor="White">
                        <Padding Bottom="1px" Left="2px" Right="2px" Top="1px" />
                    </SelectedNodeStyle>
                </ignav:UltraWebTree>
            </td>
            <td valign="top" style="width: 155px; height: 138px; ">
            	<table id="tbmain" cellSpacing="1" cellPadding="1" width="150" border="0" >
                            <tr>
								<td style="CURSOR: hand; HEIGHT: 16px; width: 148px;" onclick="add_all()" align="center" bgColor="#33cccc">选择所有</td>
                            </tr>
                            <tr>
								<td style="CURSOR: hand; HEIGHT: 18px; width: 148px;" onclick="del_all()" align="center" bgColor="#6699cc">取消所有</td>
                            </tr>
                            <tr>
								<TD vAlign="top" align="center" style="width: 148px" >
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<asp:datalist id="dluser" runat="server" Width="100%" BackColor="White" BorderWidth="1px" GridLines="Horizontal"
											CellPadding="3" BorderStyle="None" BorderColor="#E7E7FF">
											<SelectedItemStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#738A9C"></SelectedItemStyle>
											<AlternatingItemStyle BackColor="#F7F7F7"></AlternatingItemStyle>
											<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
											<ItemStyle ForeColor="#4A3C8C" BackColor="#E7E7FF"></ItemStyle>
											<ItemTemplate>
												<tr class="TableLine2">
													<td  id='<%# DataBinder.Eval(Container, "DataItem.userid") %>' name='<%# DataBinder.Eval(Container, "DataItem.username") %>'  onclick='javascript:click_user("<%# DataBinder.Eval(Container, "DataItem.userid") %>")'  class="menulines" align="center" style="cursor:hand">
														<%# DataBinder.Eval(Container, "DataItem.username") %>
													</td>
												</tr>
											</ItemTemplate>
											<HeaderStyle Font-Bold="True" ForeColor="#F7F7F7" BackColor="#4A3C8C"></HeaderStyle>
										</asp:datalist></table>
								</TD>
                            </tr>
						</TABLE></td></tr></table>
      
    
  
        
    </form>
</body>
</html>
