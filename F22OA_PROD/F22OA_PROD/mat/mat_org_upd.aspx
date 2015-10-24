<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_org_upd, App_Web_mat_org_upd.aspx.e229d74d" %>
<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
   <table  width="98%">
    <tr>   
        <td align="right">      
          <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtName" ErrorMessage="请输入施工单位"></asp:RequiredFieldValidator>
           &nbsp;&nbsp; 
        <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />
        <input id="btnBack" type="button" class="btn" onclick="javascript:window.location='mat_org.aspx';" value="返回" />
        <script language="javascript" type="text/javascript">
		    var vh=window.parent.location.href;
	          if(vh.indexOf('loader_frame')>-1)  document.getElementById('btnBack').style.display='none';
	        else  document.getElementById('btnBack').style.display='';
		</script>
        </td>
    </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <table width="98%">
     <colgroup>
        <col  width="60" />
        <col  align="left"  width="100" />   
        <col  width="60" />
        <col  align="left"  width="100" />            
    </colgroup>
    <tr>
    <td class="ltd">编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</td>
    <td><input id="txtorgid" runat="server" class="tbox" style="width:99%;" readonly="readonly"/>  
    </td>
    <td class="ltd">创建时间:</td>
    <td> <input id="txtcrdate" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    </tr>
    <tr>
    <td class="ltd" >助 记 码: </td>
    <td ><input id="txtAssitenid" runat="server" class="tbox" style="width:99%;" />  </td>
    <td class="ltd">创 建 人:</td>
    <td> <input id="txtcrname" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    </tr>    
    <tr>
    <td class="ltd" >施工单位:</td>
    <td> <input id="txtName" runat="server" class="tbox" style="width:99%;" /> </td>
    <td class="ltd">审核时间:</td>
    <td> <input id="txtchk_date" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    </tr>  
     <tr>
    <td class="ltd"  > 联 系 人:</td>
    <td> <input id="txtLinkman" runat="server" class="tbox" style="width:99%;" /> </td>
    <td class="ltd">审 核 人:</td>
    <td> <input id="txtchk_name" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    </tr> 
    <tr>
    <td class="ltd" >联系方式:</td>
    <td> <input id="txtTel" runat="server" class="tbox" style="width:99%;" />   </td>
    <td class="ltd">审 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;核:</td>
    <td><input id="txtchk_sure" runat="server" class="tbox" readonly="readonly" style="width:99%;" /></td>
    </tr>
    <tr>
        <td class="ltd"> 验证码:</td>
        <td colspan="3"><input id="txtVeriCode" runat="server" class="tbox"  style="width:99%;" />
        </td>
    </tr>                
   <tr>
    <td class="ltd"> 备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
    <td colspan="3"><textarea id="txtComment" runat="server" class="tbox" style="width:99%; "></textarea></td>      
   </tr>   
  </table>
  </ContentTemplate>
  <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSave" /></Triggers>
    </asp:UpdatePanel>
</form>
</body>
</html>
