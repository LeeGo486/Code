<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_type_add, App_Web_mat_type_add.aspx.e229d74d" %>
<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加店铺设备类别</title>
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
        <td align="right" >
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTypeName" ErrorMessage="请输入类别名称"></asp:RequiredFieldValidator>
       &nbsp;&nbsp; <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" TabIndex="3" OnClick="BtnSave_onclick" />
        </td>
    </tr>
    </table>
  <table width="98%">
     <colgroup>
        <col  width="60" />
        <col  align="left"  width="120" />           
    </colgroup>   
    <tr>
    <td class="ltd" > 类别名称:</td>
    <td >
        <input id="txtTypeName" runat="server" class="tbox" style="width:99%;"    tabindex="1" />  
    </td>
    </tr>               
   <tr>
    <td class="ltd"> 备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
    <td><textarea id="txtComment" runat="server" class="tbox"  style="width:99%; height:30px;" tabindex="2"></textarea></td>      
   </tr>   
  </table>
  </ContentTemplate>
    </asp:UpdatePanel>
</form>
</body>
</html>
