<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserMsgWrite, App_Web_bp_usermsgwrite.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>留言信息</title>
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
    <base target="_self" />
     <script type="text/javascript">
     function bt_close_onclick()
   {
     //window.dialogArguments.location=window.dialogArguments.location;
       window.close();
  
   }
   function bt_return()
     {
      
        window.dialogArguments.location=window.dialogArguments.location;
        window.returnValue=0;
         window.close();
     }
    </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
           <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">发送信息</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
  
    <table  width="100%">
    <tr>
    <td align="right">
    <div class="menu">

    <asp:Button ID="BtnSubmit" runat="Server"  Text="提交"   CssClass="btn"  Width="100px" OnClick="BtnSubmit_Click" />  
    <asp:Button ID="Button1" runat="Server"  Text="退出"   CssClass="btn"  Width="100px"  OnClientClick="bt_close_onclick()" />
    &nbsp;&nbsp;
     </div>  
        </td> 
    </tr>
    </table>
    	<!--head end-->
        
    <div  class="BContent">
     <!----contant------------------>
     <table width="100%">
     <tr>
     <td align="center">
         <asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></td>
     </tr>
     <tr>
     <td style="height: 68px">
         <asp:TextBox ID="TxtContent" runat="server" CssClass="tbox" Width="98%" MaxLength="5000" TextMode="MultiLine" Height="120px"></asp:TextBox>
         </td>
     </tr>
     <tr>
     <td align="center"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtContent"
        ErrorMessage="*信息内容不能为空" ValidationGroup="add"></asp:RequiredFieldValidator><asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label>
         <asp:HiddenField ID="HFSupMoneyID" runat="server" />
          <asp:HiddenField ID="HFSupplyerID" runat="server" />
       </td>
     </tr>
     <tr>
     <td align="center">

    </td>
     </tr>
     <tr>
     <td></td>
     </tr>
     <tr>
     <td></td>
     </tr>
     </table>
     <!----contant end---------------->
    </div>
    </form>
</body>
</html>

