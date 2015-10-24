<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSupplyerEidt, App_Web_bp_bssupplyereidt.aspx.11713791" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商资料维护</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">供应商资料维护</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
     <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="供应商列表" CssClass="btn"   OnClientClick="window.location.href='BP_BSSupplyerlist.aspx'; return false;"   />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="btnSave_Click" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

        
    <div  class="BContent" align="center" style="height:100%">
    <table width=80% border="0"  >  
    <colgroup>
    <col  width="25%"/>
    <col align="left"/>
    </colgroup>
        <tr>
        <td colspan="2">
            <asp:Label ID="lblAlart" runat="server"  Visible="False" ForeColor="red"></asp:Label></td>
    </tr>
 <tr>
        <td>
            账 户 名：</td>
        <td ><asp:TextBox ID="TxtUserID" runat="server"  Width="290px" CssClass="tbox" ReadOnly="True"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtUserID"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
    </tr> 
    <tr>
        <td>
            密 &nbsp;&nbsp; 码：</td>
        <td ><asp:TextBox ID="TxtPwd" runat="server"  Width="290px" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtPwd"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
    </tr>   
 <tr>
        <td >
            供应编号：</td>
        <td ><asp:TextBox ID="txtsupplyNo" runat="server"  Width="290px" CssClass="tbox"   ></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtsupplyNo"
                ErrorMessage="*"></asp:RequiredFieldValidator>
        </td>
    </tr>   
       <tr>
        <td >公司名称：</td>
        <td ><asp:TextBox ID="txtCommpanyName" runat="server"  Width="290px" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCommpanyName"
                ErrorMessage="*"></asp:RequiredFieldValidator>
        </td>
    </tr>
      <tr>
        <td >公司简称：</td>
        <td ><asp:TextBox ID="txtShortName" runat="server"  Width="290px" CssClass="tbox" ></asp:TextBox>
       
        </td>
    </tr>
        <tr>
        <td>
            用户状态：</td>
        <td >
            &nbsp;<asp:RadioButton ID="RBtnOk" runat="server" GroupName="state" Text="正常" />
            <asp:RadioButton ID="RBtnStop" runat="server" GroupName="state" Text="停用" /></td>
    </tr> 
      <tr>
        <td>
            供应类型：</td>
        <td >
            <asp:DropDownList ID="ddlType" runat="server" Width="290px"></asp:DropDownList>
        </td>
    </tr>
              
 
    
  
     <tr>
        <td>
            公司简介：</td>
        <td ><asp:TextBox ID="txtCommpScale" runat="server"  Height="50px" TextMode="MultiLine"  Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>  
    <tr>
        <td style="height: 58px">业务范围：</td>
        <td style="height: 58px" ><asp:TextBox ID="txtBusinessRange" runat="server" Height="50px" TextMode="MultiLine"  Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
      <tr>
        <td>
            公司执照号：</td>
        <td><asp:TextBox ID="txtLicenceid" runat="server"   Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            注册证号：</td>
        <td align="left"><asp:TextBox ID="txtIDcard" runat="server"  Width="290px" CssClass="tbox" ></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            联 系  人：</td>
        <td><asp:TextBox ID="txtRelationMan" runat="server"   Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            手 机 号：</td>
        <td ><asp:TextBox ID="txtMTel" runat="server"   Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            电 &nbsp; &nbsp;话：</td>
        <td ><asp:TextBox ID="txtTel" runat="server"   Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            传 &nbsp; &nbsp;真：</td>
        <td ><asp:TextBox ID="txtFax" runat="server"  Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            电子邮箱：</td>
        <td><asp:TextBox ID="txtEmail" runat="server"   Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
   
  
    <tr>
        <td>现供应商：</td>
        <td ><asp:TextBox ID="txtSupplyList" runat="server"   Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>

          <tr>
        <td>开账号行：</td>
        <td align="left"><asp:TextBox ID="txtBank" runat="server"  Width="290px" MaxLength="20" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td>银行账号：</td>
        <td align="left"><asp:TextBox ID="txtaccount" runat="server" Width="290px" CssClass="tbox"></asp:TextBox></td>
    </tr>
              <tr>
        <td>公司地址：</td>
        <td align="left"><asp:TextBox ID="TxtAddress" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="290px" MaxLength="300" CssClass="tbox"></asp:TextBox></td>
    </tr>
      <tr>
        <td>供货处地址：</td>
        <td align="left"><asp:TextBox ID="TxtSupplyAddress" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="290px" MaxLength="300" CssClass="tbox"></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;</td>
    </tr>

</table>
    </div>
    </form>
</body>
</html>
