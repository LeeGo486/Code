<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_bill_schema, App_Web_mat_bill_schema.aspx.e229d74d" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>无标题页</title>
     <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center; height:30px; width:100px;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
</head>
<body  style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <div style="text-align:center;vertical-align:middle;">
     <% if (id.Length > 0)
        { %>
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate> 
       <table  width="98%">
        <tr><td align="right" >  
          <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtchangecause" ErrorMessage="请填写变更原因"></asp:RequiredFieldValidator>&nbsp;
         <input id="btnfb" type="submit" value="确 定" class="btn"  runat="server" onserverclick="btnfb_OnClick"/>
        </td></tr>
        </table>
        <table width="98%">
         <tr><td  class="ltd">编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
         <td align="left"><input id="txtbillid" runat="server" class="tbox" style="width:98%;" readonly="readonly"/> </td>
        </tr>
        <tr><td  class="ltd">计划完成时间：</td><td align="left"><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server"  value="" > </igsch:webdatechooser></td></tr>
        <tr><td  class="ltd">变更原因：</td><td align="left"><textarea id="txtchangecause" runat="server" class="tbox" style="width:98%; height:30px; margin:0px;"></textarea></td></tr>
        </table>
       </ContentTemplate>
      </asp:UpdatePanel>   
    <%} else { %>
         <br /><br />
         <div><h4 style="color:Red;">请选择报修单</h4></div>
     <% } %>
    </div>
    </form>
</body>
</html>
