<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSupplyerChkDetail, App_Web_bp_bssupplyerchkdetail.aspx.11713791" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商明细</title>
    <base target="_self" />
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
     <script type="text/javascript">
     function bt_close_onclick()
 {
     window.dialogArguments.location=window.dialogArguments.location;
       window.close();
  
 }
 function bt_return()
     {
        
       
        //var values=window.document.getElementById("HFID").value;
        //debugger;
        //window.returnValue=values;
        //window.dialogArguments.location.reload();
       // window.dialogArguments.location=window.dialogArguments.location;
       window.returnValue=0;
         window.close();
     }
    </script>
            <style type="text/css">

#globTable{
margin-top:200px;
background:url(../../../images/login_05.gif) repeat-x;
table-layout:fixed;
}
.Login_Ipt{
border:solid 1px #1c4779;
}
#TipsFontIcon{
font-family:Webdings;
color:#CC0000;
font-size:16px;
}
#TipsFont{
color:#CC0000
}
.btSubmit{
width:108px;height:36px;}
input{ border:solid 1px #CCC;}
.NoBorder{ border:none}
.NormalBtn {
	BORDER-RIGHT: #2c59aa 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2c59aa 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2c59aa 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2c59aa 1px solid
}
.DivTitle{
font-size:14px;
color:#006699;
font-weight:bold;
width:750px;
margin:auto;
text-align:left;
line-height:35px;
}
.Title{
font-size:17px;
color:#006699;
font-weight:bold;

margin:auto;
text-align:center;
line-height:35px;
}
.DivTitleTable{
background:#abcfd4;

}
.DivTitleTable td{
background:#FFF;

}
</style>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">供应商明细</span>&nbsp;&nbsp;&nbsp;
					
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
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="审  核" CssClass="btn" OnClick="btnchk_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退 出" CssClass="btn"  OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
   
        
    <div  class="BContent"  style="height:100%" align="center">
    <table width="750" border="0" cellpadding="1" cellspacing="1"  class="DivTitleTable">
    <tr>
    <td align="center">
    <!--chk-->
    <table width="80%" align="center" cellpadding="3" cellspacing="3">
     <colgroup>
    <col width="30%"/>
    <col align="left"/>
    </colgroup>
    <tr>
        <td >供应商编号：</td>
        <td ><asp:TextBox ID="txtSupplyno" runat="server" CssClass="tbox"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSupplyno"
                Display="Dynamic" ErrorMessage="请输入供应商编号！"></asp:RequiredFieldValidator></td>
    </tr>
   
     <tr>
        <td>审核状态：</td>
        <td >
            <asp:Label ID="Label1" runat="server" ForeColor="Red" Text=" " Visible="False"></asp:Label><asp:CheckBox ID="CheckBoxPass" runat="server" Text="审核通过"   /></td>
    </tr>

    <tr>
        <td colspan=2>
            <asp:Label ID="LblAlart" runat="server"  ForeColor="red"></asp:Label>
        </td>
    </tr>
</table>
    <!--chk--end-->
        <asp:HiddenField ID="HFSupplyID" runat="server" />
    </td>
    </tr>
    <tr>
      <td align="center" ><div class="DivTitle" >
          供应商信息</div></td>
    </tr>
      <tr>
    <td align="center">
      <table width="80%"  border="0"   align="center" cellpadding="3" cellspacing="0">  
    <colgroup>
    <col width="15%" align="left" class="ProTitle"/>
    <col align="left" class="ProTitle"/>
     <col width="15%" align="left" class="ProTitle"/>
    <col align="left" class="ProTitle"/>
    </colgroup>
 
                 
    <tr>
        <td >公司名称：</td>
        <td colspan="3">
            <asp:Label ID="LblCommpanyName" runat="server" Text=""></asp:Label>
        &nbsp;
        </td>
    </tr>
     <tr>
        <td >公司简称：</td>
         <td colspan="3">
            <asp:Label ID="LblShortName" runat="server" Text=""></asp:Label>
        &nbsp;
         </td>
    </tr>
    
    <tr>
        <td>
            公司简介：</td>
        <td colspan="3">
            <asp:Label ID="LblCommpScale" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>业务范围：</td>
        <td colspan="3">
            <asp:Label ID="LblBusinessRange" runat="server" Text=""></asp:Label></td>
    </tr>
     <tr>
        <td>供应种类：</td>
        <td colspan="3">
            <asp:Label ID="LblTypeName" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td>
        登陆账号：</td>
    <td>
        <asp:Label ID="LblLoginNo" runat="server" Text=""></asp:Label></td>
    <td>
        登陆密码：</td>
    <td>
        <asp:Label ID="LblPwd" runat="server" Text=""></asp:Label></td>
    </tr>
     <tr>
        <td >
            供应编号：</td>
        <td >
            <asp:Label ID="LblsupplyNo" runat="server" Text=""></asp:Label></td>
        <td> 所属类型：</td>
        <td>
            <asp:Label ID="LblType" runat="server" Text=""></asp:Label></td>
    </tr> 
     <tr>
        <td>
            用户状态：</td>
        <td >
            <asp:Label ID="LblState" runat="server" Text=""></asp:Label></td>
           <td> 
            公司执照号：</td>
        <td>
         <asp:Label ID="LblLicenceid" runat="server" Text=""></asp:Label></td>
    </tr>  
    <tr>
        <td>
            注册证号：</td>
        <td >
            <asp:Label ID="LblIDcard" runat="server" Text=""></asp:Label></td>
           <td> 
            联 系 人：</td>
        <td>
         <asp:Label ID="LblRelationMan" runat="server" Text=""></asp:Label></td>
    </tr>
      <tr>
        <td>
            手 机 号：</td>
        <td >
            <asp:Label ID="LblMTel" runat="server" Text=""></asp:Label></td>
           <td> 
            电 &nbsp;&nbsp; 话：</td>
        <td>
         <asp:Label ID="LblTel" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>
            传 &nbsp;&nbsp; 真：</td>
        <td >
            <asp:Label ID="LblFax" runat="server" Text=""></asp:Label></td>
           <td> 
            电子邮箱：</td>
        <td>
         <asp:Label ID="LblEmail" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>
            开户银行：</td>
        <td >
            <asp:Label ID="LblBank" runat="server" Text=""></asp:Label></td>
           <td> 
            银行账号：</td>
        <td>
         <asp:Label ID="LblAcount" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>
            现供应商：</td>
        <td colspan="3">
            <asp:Label ID="LblSupplyList" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>
            公司地址：</td>
        <td colspan="3">
            <asp:Label ID="LblAddress" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>
            供货地址：</td>
        <td colspan="3">
            <asp:Label ID="LblSupplyAddress" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>
            </td>
        <td >
            &nbsp;</td>
           <td> </td>
        <td></td>
    </tr>
    

    <tr>
        <td colspan="2" align="center">

        </td>
           <td> </td>
        <td></td>
    </tr>
</table>
    </td>
    </tr>
    </table>
  
    </div>
    </form>
</body>
</html>
