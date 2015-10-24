<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_org_add, App_Web_mat_org_add.aspx.e229d74d" %>
<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加店铺施工单位</title>
      <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
</head>
<body  style="margin-left:5px; margin-right:5px;">
      <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
   <table  width="98%">
    <tr>   
        <td align="right" style="padding-right:30px;">
        <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />
        </td>
    </tr>
    </table>
  <table width="98%">
     <colgroup>
        <col  width="60" />
        <col  align="left"  width="200" />           
    </colgroup>
    <tr>
    <td class="ltd">助 记 码:</td>
    <td align="left"  >
        <input id="txtAssitenid" runat="server" class="tbox" style="width:90%;" />    </td>
    </tr>
    <tr>
    <td class="ltd" > 施工单位:</td>
    <td >
        <input id="txtName" runat="server" class="tbox" style="width:90%;" />  
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="*"></asp:RequiredFieldValidator>
    </td>
    </tr>    
    <tr>
    <td class="ltd" > 联 系 人:</td>
    <td><input id="txtLinkman" runat="server" class="tbox" style="width:90%;" />   </td>
    </tr>  
     <tr>
    <td class="ltd"  > 联系方式:</td>
    <td> <input id="txtTel" runat="server" class="tbox" style="width:90%;" />  </td>
    </tr>   
     <tr>
    <td class="ltd"  > 验证码:</td>
    <td> <input id="txtVeriCode" runat="server" class="tbox" style="width:90%;" />  </td>
    </tr>                   
   <tr>
    <td class="ltd"> 备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
    <td><textarea id="txtComment" runat="server" class="tbox" style="width:90%; height:50px;"></textarea></td>      
   </tr>   
  </table>
  </ContentTemplate>
    </asp:UpdatePanel>
</form>
</body>
</html>
