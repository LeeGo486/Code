<%@ page language="C#" autoeventwireup="true" buffer="true" enableeventvalidation="false" enablesessionstate="ReadOnly" validaterequest="false" enableviewstate="true" inherits="mat_mat_rpt_bill, App_Web_mat_rpt_bill.aspx.e229d74d" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet">
 <style type="text/css">.drp{width:120px;}</style>
	<script type="text/javascript">
        function selectMD(){
        var m=window.showModalDialog('mat_org_dlg.aspx',"弹出d窗口","height:500px;width:800px;toolbar:no;menubar:no;location:no;resizable:no;status:no;scroll:no;help:no;");
	     if (m!=null&&typeof(m)!='undefined'&&m!="all")	         
             document.getElementById('txtOrg').value=m;
         }
         function alin(val){alert(val);}
    </script>
</head>
<body>
    <form id="form1" runat="server">
 
 <table width="100%" >   
<tr>
<td>创建时间：</td>
<td><igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"  value="" > </igsch:webdatechooser></td>
<td>到</td>
<td><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" ></igsch:webdatechooser> </td>
<td>种类：</td> 
<td nowrap>
   
    <asp:DropDownList ID="drpType" runat="server"  AutoPostBack="true"  CssClass="drp"
         onselectedindexchanged="drpType_SelectedIndexChanged"> </asp:DropDownList>
         &nbsp;&nbsp;&nbsp;&nbsp;品类：
         <asp:DropDownList ID="drpchild" runat="server"  CssClass="drp" ><asp:ListItem Value="-1" Text="全部"></asp:ListItem> </asp:DropDownList>
  
   </td> 
   <td></td>
 </tr> 
 <tr>
 
 <td>质保：</td>
 <td><asp:DropDownList ID="drpIsquality" runat="server" CssClass="drp"> 
     <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem> 
     <asp:ListItem Text="否" Value="0" ></asp:ListItem> 
     <asp:ListItem Text="是" Value="1"></asp:ListItem> 
     </asp:DropDownList>
 </td>
  <td>状态：</td>
 <td><asp:DropDownList ID="drpState" runat="server"  CssClass="drp"> <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem> 
 <asp:ListItem Text="未上报" Value="0" ></asp:ListItem> <asp:ListItem Text="已上报" Value="1"></asp:ListItem> 
 <asp:ListItem Text="已跟进" Value="2" ></asp:ListItem> <asp:ListItem Text="已退回" Value="3" ></asp:ListItem> 
 <asp:ListItem Text="超期" Value="4" ></asp:ListItem> <asp:ListItem Text="完成" Value="5" ></asp:ListItem> 
 </asp:DropDownList></td>
 <td>施工单位：</td>
 <td nowrap>  <input id="txtOrg" runat="server"  style="width:110px;" onchange='alin(this.value);' onkeydown='alin(this.value);'/> 
       <input type="button"  id="btnOrg" value="选择" class="btn" onclick="javascript:selectMD();"  />
 </td>
 
 <td> <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="btnsearch_Click" />
</td>
 </tr>
</table>

<table width="98%">
<tr>
  <td>   
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
             Font-Size="8pt" Height="500px" Width="100%" ZoomMode="FullPage" 
                SizeToReportContent="True" 
                ExportContentDisposition="AlwaysInline" HyperlinkTarget="_bank" 
                ShowCredentialPrompts="False" ShowParameterPrompts="False">
                <ServerReport ReportServerUrl="" />
             <LocalReport >
                 <DataSources>
                     <rsweb:ReportDataSource 
                         Name="matDS_mat_bill_rpt" DataSourceId="ObjectDataSource1" />
                 </DataSources>
             </LocalReport>
         </rsweb:ReportViewer>      
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="matDSTableAdapters.mat_bill_rptTableAdapter">
            <SelectParameters>
                <asp:Parameter Name="beginDate" Type="String" />
                <asp:Parameter Name="endDate" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
      
  </td>
</tr>
</table>
    </form>
</body>
</html>
