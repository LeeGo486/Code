<%@ page language="C#" autoeventwireup="true" inherits="help_help_add, App_Web_help_add.aspx.87a0902e" %>
<%@ Register TagPrefix="CE" Namespace="CuteEditor" Assembly="CuteEditor" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新增帮助</title>
      <link  href="../css/project.css"type="text/css"  rel="stylesheet">
      <script language="javascript" type="text/javascript" src="../js/project.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">新增帮助</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <div>
     <div>
   <table  width="100%"  bgcolor="white">
   <colgroup>
   <col  width="100px"/>
    <col />
   <col width="100px"/>
    <col />
   </colgroup>
      <tr>
   <td></td>
    <td></td>
     <td></td>
      <td align="right"><input class="btn" onclick="LoadWindow('help_showmenu.aspx',505,680)" type="button"
           value="选择菜单" />
          <input class="btn" onclick="location.href='help_list.aspx'" type="button"
           value="返回" /></td>
   </tr>
       
   <tr>
   <td colspan="4">
   <table width="100%">
     <colgroup>
   <col  width="100px"/>
    <col />
   <col width="100px"/>
    <col />
   </colgroup>
    <tr>
   <td style="height: 28px">
       <asp:Label ID="Label9" runat="server" Text="菜单标题:" Width="100px"></asp:Label></td>
   <td style="height: 28px">
       <asp:TextBox ID="to_name" runat="server" CssClass="tbox" MaxLength="100" Width="98%"></asp:TextBox></td>
   <td>
       <asp:Label ID="Label2" runat="server" Text="菜单编号:" Width="100px"></asp:Label></td>
           <td>
       <asp:TextBox ID="to_id" runat="server" CssClass="tbox" MaxLength="20" Width="98%"></asp:TextBox></td>

   </tr>
   <tr>
    <td>
        <asp:Label ID="Label4" runat="server" Text="组别编号:" Width="100px"></asp:Label></td>
         <td>
             <asp:TextBox ID="to_menuname" runat="server" CssClass="tbox" MaxLength="100" Width="98%"></asp:TextBox></td>
   <td>
       <asp:Label ID="Label3" runat="server" Text="组别名称:" Width="100px"></asp:Label></td>
   <td >
       <asp:TextBox ID="to_menuid" runat="server" CssClass="tbox" MaxLength="100" Width="98%"></asp:TextBox></td>
   
   </tr>
     <tr>
   <td>
       <asp:Label ID="Label1" runat="server" Text="符加参数:" Width="100px"></asp:Label></td>
         <td colspan="3">
       <asp:TextBox ID="Txtpert" runat="server" CssClass="tbox" MaxLength="20" Width="98%"></asp:TextBox>
         </td>
   </tr>
   </table>
   </td>
   </tr>
    
   <tr>
   <td colspan="4">
    <CE:Editor id="whtml" EditorWysiwygModeCss="../css/webhtml.css" runat="server" Width="100%"></CE:Editor>
       </td>
   </tr>
   <tr>
   <td><asp:Button ID="BtnSubmit" runat="server" Text="提交" CssClass="btn" OnClick="BtnSubmit_Click" OnClientClick="return confirm('确认要提交吗？')" /></td>
      <td><asp:HiddenField ID="HFID" runat="server" /></td>
         <td></td> <td></td>
   </tr>
   </table>
    </div>
   
    </div>
    </form>
</body>
</html>
