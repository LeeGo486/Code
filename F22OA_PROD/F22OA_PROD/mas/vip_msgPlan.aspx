<%@ page language="C#" autoeventwireup="true" inherits="vip_msgPlan, App_Web_vip_msgplan.aspx.e229d74e" %>
<%@ OutputCache Duration="3" Location="None" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>短信调查方案</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
	<script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
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
        <col width="100px"/> <col width="120px"/> <col width="50px"/><col width="120px"/><col width="120px"/><col align="right" />
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
           <td><asp:DropDownList ID="drp" runat="server">
           <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem> <asp:ListItem Text="未审核" Value="0"></asp:ListItem> <asp:ListItem Text="已审核" Value="1"></asp:ListItem>
           </asp:DropDownList></td>
           <td></td>
       </tr>     
      </table>
      </td>
    </tr>
    <tr> 
    <td><asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="BtnSearch_Click" />
   <a id="btnAdd" style="width:100px" href="vip_msgPlan_add.aspx"  rel="gb_page_center[500,400]"> 
      <input type="button" id="Button1" style="width:100px;" runat="server" value="添加" class="btn" />
   </a>
    <asp:Button ID="btnSure" Width="100px" runat="server" CssClass="btn" Text="审核" OnClick="btnSure_Click" />
    <asp:Button ID="btnunChk" Width="100px" runat="server" CssClass="btn" Text="反审核" OnClick="btnUnChk_Click" />
      <asp:Button ID="btnDel" Width="100px" runat="server" CssClass="btn" Text="删除" OnClick="btnDel_Click" />

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
              onpageindexchanged="gv_PageIndexChanged" onrowcommand="gv_RowCommand" 
                            onrowcreated="gv_RowCreated" onrowdeleted="gv_RowDeleted" 
              onrowdeleting="gv_RowDeleting" onpageindexchanging="gv_PageIndexChanging">
              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <Columns>
               
                <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server"  ID="ckbDel" Width="2%" OnCheckedChanged="chk_OnCheckedChanged" AutoPostBack="true"  ToolTip='<%# Eval("msgplanid") %>'  /> </ItemTemplate>
                    </asp:TemplateField>                 
                      <asp:TemplateField HeaderText="主题" SortExpression="title">
                      <ItemTemplate>
                      <a href='vip_msgPlan_upd.aspx?id=<%# Eval("msgplanid")%>'   rel="gb_page_center[500,400]"><%# Eval("title").ToString().Length > 10 ? Eval("title").ToString().Substring(0, 10) + "..." : Eval("title")%> </a>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField  HeaderText="内容"  HeaderStyle-Width="100" >
                   <ItemTemplate>
                   <%# Eval("content").ToString().Length > 15 ? "<marquee  width='100%' scrolldelay='300'>" + Eval("content") + "</marquee>" : Eval("content")%>
                    </ItemTemplate>
                </asp:TemplateField>  
                 <asp:TemplateField HeaderText="审核" >
                      <ItemTemplate><span><%# Eval("sure")%></span> </ItemTemplate>
                  </asp:TemplateField>              
                  <asp:BoundField DataField="crname" HeaderText="创建人" ReadOnly="True" SortExpression="crname" />           
                  <asp:BoundField DataField="crdate" HeaderText="创建时间" ReadOnly="True" SortExpression="crdate" DataFormatString="{0:d}" HtmlEncode="False" />
                  <asp:BoundField DataField="sure_name" HeaderText="审核人" ReadOnly="True" SortExpression="crname" />           
                  <asp:BoundField DataField="crdate" HeaderText="审核时间" ReadOnly="True" SortExpression="crdate" DataFormatString="{0:d}" HtmlEncode="False" />
               <asp:TemplateField>
                <ItemTemplate>                
                <asp:ImageButton id="btnDel" runat="server" ImageUrl="../icon/delete.gif" CommandName="delete" OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" />
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
           <Triggers><asp:AsyncPostBackTrigger ControlID="btnSure" /></Triggers>
           <Triggers><asp:AsyncPostBackTrigger ControlID="btnDel" /></Triggers>
           <Triggers><asp:AsyncPostBackTrigger ControlID="btnunChk" /></Triggers>
          </asp:UpdatePanel>   
      </td>
    </tr>
</table>
     
    </div>
    </form>
</body>
</html>


