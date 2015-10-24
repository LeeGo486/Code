<%@ page language="C#" autoeventwireup="true" inherits="vip_msgPlanAnalysis, App_Web_vip_msgplananalysis.aspx.e229d74e" %>
<%@ OutputCache Duration="3" Location="None" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>短信调查分析</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
	<script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
      var v=document.createElement('a');
   
    </script>

    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script>
   <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
 
</head>
<body> 
    <form id="form1" runat="server" >
        <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <!--head end-->
        <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >
        &nbsp;&nbsp;
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

    <div  class="BContent" >
     
<table width="100%">
    <tr>
      <td>
      <table  align="left"  width="100%">
       <colgroup>
        <col  width="100px"/> <col width="120px"/> <col width="50px"/><col width="120px"/><col align="right" />
        </colgroup>
       <tr>
           <td align="left" style="height: 25px" > &nbsp;创建时间: &nbsp;  </td>
           <td>
               <igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"  value="" width="100"> </igsch:webdatechooser>
           </td>
           <td>&nbsp;&nbsp; 到  </td>
           <td>
               <igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" width="100"></igsch:webdatechooser>           
           </td>
           <td><asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="BtnSearch_Click" />   
          </td>
       </tr>     
      </table>
      </td>
    </tr>  
    <tr>
      <td> 
          <asp:ScriptManager ID="ScriptManager1" runat="server">
          </asp:ScriptManager>
          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
          <ContentTemplate>
          <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="msgplanid"
              AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
              ForeColor="#333333" GridLines="None" Width="100%" PageSize="15" 
              onpageindexchanged="gv_PageIndexChanged"
              onpageindexchanging="gv_PageIndexChanging">
              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <Columns>
                      <asp:TemplateField HeaderText="主题" SortExpression="title">
                      <ItemTemplate>
                      <a href='vip_msgPlan_bw.aspx?id=<%# Eval("msgplanid")%>'  style="text-decoration:underline; cursor:pointer;"  rel="gb_page_center[search_sites]"><%# Eval("title").ToString().Length > 10 ? Eval("title").ToString().Substring(0, 10) + "..." : Eval("title")%> </a>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField  HeaderText="内容" >
                   <ItemTemplate>
                   <%# Eval("content").ToString().Length > 15 ? "<marquee  width='100%' scrolldelay='300'>" + Eval("content") + "</marquee>" : Eval("content")%>
                    </ItemTemplate>
                </asp:TemplateField>                
                  <asp:BoundField DataField="crname" HeaderText="创建人" ReadOnly="True" SortExpression="crname" />           
                  <asp:BoundField DataField="crdate" HeaderText="创建时间" ReadOnly="True" SortExpression="crdate" DataFormatString="{0:d}" HtmlEncode="False" />
               <asp:TemplateField>
                <ItemTemplate>                
                <a href="vip_msgPlanAnalysisRpt.aspx?msgPlanid=<%# Eval("msgplanid")%>"  rel="gb_pageset[search_sites1]"  target="_self">
                      <img  src="../icon/report.ico"/ width="32" height="20" border="0">
                    </a>               
                      </ItemTemplate>
                </asp:TemplateField>  
              </Columns>
              <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
             <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
               <EmptyDataTemplate>
              <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
		    <tr class="header" >
			<th scope="col"><a href="#" >主题</a></th>
			<th scope="col"><a href="#">内容</a></th>
			<th scope="col"><a href="#" >创建人</a></th>
			<th scope="col"><a href="#" >创建时间</a></th>			
		  </tr>
	      </table>
              </EmptyDataTemplate>
              <EditRowStyle BackColor="#2461BF" />
              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
              <PagerStyle CssClass="header"  HorizontalAlign="Left" />
              <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
              <AlternatingRowStyle BackColor="White" />
          </asp:GridView>
           </ContentTemplate>
           <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSearch" /></Triggers>
          </asp:UpdatePanel>   
      </td>
    </tr>
</table>
     
    </div>
    </form>
</body>
</html>


