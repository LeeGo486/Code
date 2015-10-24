<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserEditContact, App_Web_bp_usereditcontact.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="css/project.css" type="text/css"  rel="stylesheet">
    		       
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">联系资料维护</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
   <!--head end-->
   
        
    <div  class="BContent"  >
    <table >
    
   <tr> 
   <td align="center"> 
    <table borderColor="#cccccc" height="7" cellSpacing="0" borderColorDark="#ffffff" cellPadding="0" width="800" align="center" border="1" style="vertical-align:middle; margin-top:50px">
	  <colgroup>
	  <col  align="right" width="300px" />
	  <col style="text-align:left;"/>
	  </colgroup> 
	 <tr>
    <td colspan="2" align="center"><asp:Label id="LblAlart" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>
    <tr>
	  <tr>
        <td>
            联 系 人：</td>
        <td align="left"><asp:TextBox ID="txtRelationMan" runat="server" Width="216px" MaxLength="10" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            手 机 号：</td>
        <td align="left"><asp:TextBox ID="txtMTel" runat="server"  Width="216px" MaxLength="20" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            电 &nbsp; &nbsp;话：</td>
        <td align="left"><asp:TextBox ID="txtTel" runat="server"  Width="216px" MaxLength="20" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            传 &nbsp; &nbsp;真：</td>
        <td align="left"><asp:TextBox ID="txtFax" runat="server"  Width="216px" MaxLength="20" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            电子邮箱：</td>
        <td align="left"><asp:TextBox ID="txtEmail" runat="server" Width="216px" CssClass="tbox"></asp:TextBox></td>
    </tr>
   
  

      <tr>
        <td>公司地址：</td>
        <td align="left"><asp:TextBox ID="TxtAddress" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="216px" MaxLength="300" CssClass="tbox"></asp:TextBox></td>
    </tr>
      <tr>
        <td>供货处地址：</td>
        <td align="left"><asp:TextBox ID="TxtSupplyAddress" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="216px" MaxLength="300" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan=2 align="center">
            <asp:Button ID="btnSubmit" runat="server" Text="提交" Width="100px"   CssClass="btn"  OnClick="btnSubmit_Click" />&nbsp;
        </td>
    </tr>
    <tr>
        <td colspan=2 align="center">
            &nbsp;</td>
    </tr>
	  </table>
	  </td>
   <tr>
   
   </tr>
    <tr>
   
   <td align="center">

</td>
   </tr>
 </table>
    </div>
    </form>
</body>
</html>
