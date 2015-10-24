<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_bill_posEnd, App_Web_mat_bill_posend.aspx.e229d74d" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet"/>
 <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />

 <script language="javascript" type="text/javascript" src="../js/select.js"></script>
	
</head>
<body>
    <form id="form1" runat="server">
<uc1:uc_pagehead id="Uc_pagehead1" runat="server" /> 
    <div style="text-align:center;vertical-align:middle;">
     <% if (id.Length > 0)
        { %>
        <br /> <br />  
         <asp:ScriptManager ID="ScriptManager1" runat="server">
      </asp:ScriptManager>
       <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>     
         <table width="98%">
         <tr><td>编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</td><td align="left"><input id="txtbillid" runat="server" class="tbox" style="width:120px;"  readonly="readonly" /></td></tr>
        <tr><td >施工完成时间：</td><td align="left"><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server"  value="" > </igsch:webdatechooser></td></tr>
        <tr><td>满意度评价：</td><td align="left"><select id="drpOpinion" runat="server" style="width:120px;"><option selected="selected">好</option><option >一般</option><option >不好</option></select></td></tr>
        </table>
        <br />
     
      <input id="btnEnd" type="submit" value="确定" class="btn"  runat="server" onserverclick="btnEnd_OnClick"/> 
       </ContentTemplate>
        </asp:UpdatePanel>
     <%}
        else
        { %>
         <br /><br />
         <div><h4 style="color:Red;">请选择报修单</h4></div>
     <% } %>
    </div>
    </form>
</body>
</html>
