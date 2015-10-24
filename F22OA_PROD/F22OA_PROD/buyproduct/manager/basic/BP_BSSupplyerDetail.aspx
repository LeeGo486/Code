<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSupplyerDetail, App_Web_bp_bssupplyerdetail.aspx.11713791" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>供应商明细</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">

        
    <div  class="BContent" style=" height:100%">
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
    </div>
    </form>
</body>
</html>
