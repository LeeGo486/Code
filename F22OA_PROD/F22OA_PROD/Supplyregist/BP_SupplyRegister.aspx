<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_supply_SupplyRegister, App_Web_bp_supplyregister.aspx.a971f351" title="供应商注册" %>
<%@ OutputCache Duration="1000"  VaryByParam="*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商注册</title>
       <script type="text/javascript">
document.onkeydown=function()
{
   if(event.keyCode==13 && (event.srcElement.type=="text" || event.srcElement.type=="password"))
   {
     //&& event.srcElement.type!="button"
       //window.alert(event.srcElement.type);
       event.keyCode=9;  
   }
   
}
</script>
        <style type="text/css">
body{
margin:0px;
padding:0px;
}
*{
font-size:12px;

}
#globTable{
margin-top:200px;
background:url(images/login_05.gif) repeat-x;
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
<body > 
    <form id="form1" runat="server" >
      
    <div>
  
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        
    <table width="100%">
   <tr>
    <td align="center" class="Title"> 
       
    <br />
 供应商注册
    <br />
     
    <table  width="750" border="0" cellpadding="1" cellspacing="1"  class="DivTitleTable">
    <tr>
    <td></td>
    </tr>
    </table>
     </td>
    </tr>
     <tr>
      <td align="center"><div class="DivTitle">帐号信息（必填）</div></td>
    </tr>
    <tr>
    <td align="center"> 
    <table width="750" border="0" cellpadding="5" cellspacing="1"  class="DivTitleTable">
	  <colgroup>
	  <col style="width:180px;text-align:right; background:#e1f6f9" />
	  <col style="text-align:left;"/>
	  </colgroup> 
	  <tr>
        <td width="25%">用户名：</td>
        <td align="left"><asp:TextBox ID="TxtUserID" runat="server" Width="290px" Text='' MaxLength="50"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtUserID"
                ErrorMessage="*" ValidationGroup="aa"></asp:RequiredFieldValidator>
                  <asp:Button ID="BtnChk" runat="server" Text="检查是否可用"  CssClass="NormalBtn"   Width="88px" OnClick="BtnChk_Click" ValidationGroup="aa" />         
             <asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label><br />
            (用户名由4-20位数字或字母组成,不支持中文) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtUserID"
        ErrorMessage="*只能4-20是数字或字母类型" ValidationExpression="^[-a-zA-Z0-9]{4,20}$"></asp:RegularExpressionValidator></td>
    </tr> 
    <tr>
        <td width="25%">密码：</td>
        <td align="left"><asp:TextBox ID="TxtPwd" runat="server" Width="290px" Text='' TextMode="Password" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtPwd"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
    </tr>
    <tr style="color: #000000">
        <td width="25%">确认密码：</td>
        <td align="left"><asp:TextBox ID="TxtRepwd" runat="server" Width="290px" Text='' TextMode="Password" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtRepwd"
                ErrorMessage="*"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TxtPwd"
                ControlToValidate="TxtRepwd" ErrorMessage="两次输入的密码不一致"></asp:CompareValidator></td>
    </tr>    
        <tr>
        <td width="25%">公司名称：</td>
        <td align="left"><asp:TextBox ID="txtCommpanyName" runat="server" Width="290px" Text='' MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="bb" ControlToValidate="txtCommpanyName"
                ErrorMessage="*"></asp:RequiredFieldValidator>
                <asp:Button ID="btnchkcompany" runat="server" Text="检查是否可用"  CssClass="NormalBtn"   Width="88px" ValidationGroup="bb" OnClick="btnchkcompany_Click" Visible="False" /><asp:Label
                    ID="LblAlart2" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>      
    </table>
    </td>
    </tr>
      <tr style="color: #000000">
      <td align="center"><div class="DivTitle">基本信息</div></td>
    </tr>
    <tr>
        <td align="center">
        <table width="750" border="0" cellpadding="5" cellspacing="1" class="DivTitleTable">
	  <colgroup>
	  <col style="width:180px;text-align:right; background:#e1f6f9" />
	  <col style="text-align:left;"/>
	  </colgroup>       

   <tr>
        <td width="25%" style="height: 31px">
            公司简称：</td>
        <td align="left" style="height: 31px"><asp:TextBox ID="txtShortName" runat="server" Width="290px" Text='' MaxLength="50"></asp:TextBox>&nbsp;
        </td>
    </tr>
     <tr>
        <td>
            公司简介：</td>
        <td align="left"><asp:TextBox ID="txtCommpScale" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="290px" MaxLength="300"></asp:TextBox></td>
    </tr> 
    <tr>
        <td>业务范围：</td>
        <td align="left"><asp:TextBox ID="txtBusinessRange" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="290px" MaxLength="300"></asp:TextBox></td>
    </tr>
    <tr style="color: #000000">
        <td>
            所属类型：</td>
        <td align="left">
            <asp:DropDownList ID="ddlType" runat="server"></asp:DropDownList>
        </td>
    </tr>
        <tr style="color: #000000">
        <td>
            供应种类：</td>
        <td align="left">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
       
            <table cellpadding="8" cellspacing="8" border="0">
        
            <tr>
            <td style="width: 117px">
            选择的类目:<br />
            <asp:ListBox ID="ListBoxType" runat="server" Height="150px" Width="120px"  ></asp:ListBox></td>
             <td>
                 <asp:Button ID="BtnMove" runat="server"  CssClass="NormalBtn"   Width="88px" Text="添加>>" OnClick="BtnMove_Click" />
                 <br />
                 <asp:Button ID="BtnBack" runat="server"  CssClass="NormalBtn"   Width="88px" Text="删除<<" OnClick="BtnBack_Click" />
             
             </td>
              <td>
              已选项:<br />
              <asp:ListBox ID="ListBoxHave" runat="server" Height="150px" Width="120px"></asp:ListBox></td>
            </tr>
            </table>
            
             </ContentTemplate>
        </asp:UpdatePanel>
        </td>
    </tr>
     
      <tr>
        <td>
            公司执照号：</td>
        <td align="left"><asp:TextBox ID="txtLicenceid" runat="server"  Width="290px" MaxLength="50"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            身份证号：</td>
        <td align="left"><asp:TextBox ID="txtIDcard" runat="server" Width="290px" MaxLength="50" ></asp:TextBox></td>
    </tr>
       <tr>
        <td>开账号行：</td>
        <td align="left"><asp:TextBox ID="txtBank" runat="server"  Width="290px" MaxLength="20"></asp:TextBox></td>
    </tr>
    <tr>
        <td>银行账号：</td>
        <td align="left"><asp:TextBox ID="txtaccount" runat="server" Width="290px"></asp:TextBox></td>
    </tr>
        <tr>
        <td>现供应商：</td>
        <td align="left"><asp:TextBox ID="txtSupplyList" runat="server" Text='' Width="290px" MaxLength="50"></asp:TextBox></td>
    </tr>
	  </table>
	  </td>
    </tr>

 <tr style="color: #000000">
      <td align="center"><div class="DivTitle">
          联系方式</div></td>
    </tr>
   <tr> 
   <td align="center"> 
    <table width="750" border="0" cellpadding="5" cellspacing="1"  class="DivTitleTable">
	  <colgroup>
	  <col style="width:180px;text-align:right; background:#e1f6f9" />
	  <col style="text-align:left;"/>
	  </colgroup> 
	  <tr>
        <td>
            联&nbsp; 系 人：</td>
        <td align="left"><asp:TextBox ID="txtRelationMan" runat="server" Width="290px" MaxLength="10"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            手&nbsp; 机 号：</td>
        <td align="left"><asp:TextBox ID="txtMTel" runat="server"  Width="290px" MaxLength="20"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            电 &nbsp; &nbsp; 话：</td>
        <td align="left"><asp:TextBox ID="txtTel" runat="server"  Width="290px" MaxLength="20"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            传 &nbsp; &nbsp; 真：</td>
        <td align="left"><asp:TextBox ID="txtFax" runat="server"  Width="290px" MaxLength="20"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            电子邮箱：</td>
        <td align="left"><asp:TextBox ID="txtEmail" runat="server" Width="290px"></asp:TextBox></td>
    </tr>
   
  

      <tr>
        <td>公司地址：</td>
        <td align="left"><asp:TextBox ID="TxtAddress" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="290px" MaxLength="300"></asp:TextBox></td>
    </tr>
      <tr>
        <td>供货处地址：</td>
        <td align="left"><asp:TextBox ID="TxtSupplyAddress" runat="server" Text='' Height="50px" TextMode="MultiLine" Width="290px" MaxLength="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan=2 align="center">
            <asp:Button ID="btnAddorUpdate" runat="server" Text="提交" Width="88px" OnClick="btnAddorUpdate_Click" CssClass="NormalBtn" />&nbsp;
        </td>
    </tr>
    <tr>
        <td colspan=2 align="center">
            <asp:Label ID="lblSavemessage" runat="server" Font-Size=20px Visible=False ForeColor="Blue"></asp:Label>
        </td>
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

