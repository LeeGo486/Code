<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSContectadd, App_Web_bp_bscontectadd.aspx.11713791" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>公司联系方式管理</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">公司联系方式编辑</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看联系" CssClass="btn"   OnClientClick="window.location.href='BP_BSContect.aspx'; return false;"   />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="Savedata" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
   
        
    <div  class="BContent" align="center" >
    <!--contant--->
    <table width="100%" border="0" align="center"  style="margin-top:2px">
    <colgroup>
    <col width="15%"  align="left"/>
    <col />
    </colgroup>
       <tr>
        <td colspan="2" align="center">
        <asp:HiddenField ID="HFid" runat="server" />
            <asp:Label ID="lblSavemessage" runat="server" Visible="False" ForeColor="Red"></asp:Label>
        </td>
       
    </tr>
    <tr>
        <td >联系人：</td>
        <td ><asp:TextBox ID="TxtContactUser" runat="server"   Width="390px" MaxLength="50" CssClass="tbox"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtContactUser"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
     
    </tr> 
    <tr>
        <td >
            联系电话：</td>
        <td ><asp:TextBox ID="TxtTel" runat="server"   Width="390px" MaxLength="50" CssClass="tbox" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtTel"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
     
    </tr>                      
    <tr>
        <td >
            联系邮箱：</td>
        <td ><asp:TextBox ID="txtEmail" runat="server"   Width="390px" MaxLength="50" CssClass="tbox" ></asp:TextBox>
            &nbsp;
        </td>
     
    </tr>
    <tr>
        <td>
            手机号码：</td>
        <td >
            <asp:TextBox ID="TxtMobile" runat="server"    Width="390px" MaxLength="50" CssClass="tbox"></asp:TextBox>
            &nbsp;
        </td>

    </tr>
    <tr>
        <td>
            公司传真：</td>
        <td >
            <asp:TextBox ID="TxtFax" runat="server"    Width="390px" MaxLength="50" CssClass="tbox"></asp:TextBox>
            &nbsp;
        </td>
      
    </tr>
     <tr>
        <td>
            公司名称：</td>
        <td >
            <asp:TextBox ID="TxtCompanyName" runat="server"    Width="390px" MaxLength="50" CssClass="tbox"></asp:TextBox>
            &nbsp;
        </td>
   
    </tr>  
    <tr>
        <td>公司地址：</td>
        <td ><asp:TextBox ID="TxtAddress" runat="server" MaxLength="200"  Height="50px" TextMode="MultiLine"   Width="390px" CssClass="tbox"></asp:TextBox>
            &nbsp;
        </td>
   
    </tr>
      <tr>
        <td>
            备 &nbsp;&nbsp; 注：</td>
        <td >
            <asp:TextBox ID="TxtCommet" runat="server" Height="50px"
                TextMode="MultiLine"   Width="390px" MaxLength="200" CssClass="tbox"></asp:TextBox>
            &nbsp;
        </td>
   
    </tr>
      <tr>
        <td>
            默认联系方式：</td>
        <td >
            <asp:CheckBox ID="CheckBoxdefault" runat="server" CssClass="tbox" />
            &nbsp;
            </td>
     
    </tr>

    <tr>
        <td colspan="2">
           

        </td>
    </tr>
 
</table>
    <!--contant end-->
    </div>
    </form>
</body>
</html>
