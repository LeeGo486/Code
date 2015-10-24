<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindResultnewlistByTitle, App_Web_fp_findresultnewlistbytitle.aspx.a918743" %>
<%@ OutputCache Duration="3" Location="None" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>款式调查结果</title>
  <link  href="../css/project.css" type="text/css"  rel="stylesheet">
	
</head>
<body> 
    <form id="form1" runat="server">
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
        <col  width="100px"/>
        <col width="120px"/>
        <col width="50px"/>
        <col width="120px"/>
        <col  align="right"/>
        </colgroup>
      <tr>
           <td align="left" style="height: 25px" >
               &nbsp;调查时间: &nbsp;
               </td>
               <td>
               <igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"
                   value="" width="100"> </igsch:webdatechooser>
                   </td>
                   <td>
               &nbsp;&nbsp; 到 
               </td>
               <td>
               <igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" width="100">
            </igsch:webdatechooser>
           
           </td>
           <td align="right">
      <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="BtnSearch_Click" />
       <asp:Button ID="BttnOver" Width="100px" runat="server" Text="结案勾选调查" CssClass="btn" OnClick="BttnOver_Click" /></td>
        </tr>
     
      </table>
      </td>
    </tr>
    <tr>
      <td>
          <asp:GridView ID="GridViewStyle" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="TitleCode"
              AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1"   DataSourceID="ObjectDataSourceStyle"
              ForeColor="#333333" GridLines="None" Width="100%" OnRowDataBound="GridViewStyle_RowDataBound" PageSize="20">
              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <Columns>
                <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel" Width="2%" /></ItemTemplate>
                    </asp:TemplateField>
                 
                      <asp:TemplateField HeaderText="主题" SortExpression="TitleName">
                      <ItemTemplate>
                          <a href='FP_FindResultDetailTitle.aspx?id=<%# Eval("TitleCode") %>' target="_blank" title="调查目的:<%# Eval("Commet") %>"><%# Eval("TitleName") %></a>
                      </ItemTemplate>
                  </asp:TemplateField>
                     
                  <asp:BoundField DataField="CrUser" HeaderText="调查人" ReadOnly="True" SortExpression="CrUser" />
           
                  <asp:BoundField DataField="TitleDateBegin" HeaderText="调查时间" ReadOnly="True" SortExpression="TitleDateBegin" DataFormatString="{0:d}" HtmlEncode="False" />
                  <asp:BoundField DataField="TitleDateEnd" HeaderText="结束时间" ReadOnly="True" SortExpression="TitleDateEnd" DataFormatString="{0:d}" HtmlEncode="False" />
                  <asp:TemplateField SortExpression="WN_ovsure" HeaderText="结案">
                                    <ItemTemplate>
                                   <asp:CheckBox ID="CheckBoxChkSure" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem,"ISover").ToString()=="1"?true:false %>' Enabled="false" />                         
                                    </ItemTemplate>
                  </asp:TemplateField>
                 
                 <asp:TemplateField AccessibleHeaderText="结束调查" HeaderText="结束调查" >
                   <ItemTemplate>
                      <asp:LinkButton id="LinkBtnChange" CommandArgument='<%# Eval("TitleCode") %>'  OnClientClick="return confirm('确认要结案吗？')" runat="server" Text="结束调查" CausesValidation="false" CommandName="" OnClick="LinkBtnChange_Click" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
               <EmptyDataTemplate>
              <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
		<tr class="header" >
			<th scope="col"><a href="#" >主题</a></th>
			<th scope="col"><a href="#">调查人</a></th>
			<th scope="col"><a href="#" >调查时间</a></th>
			<th scope="col"><a href="#" >结束时间</a></th>
			<th scope="col"><a href="#" >结案</a></th>
			<th scope="col"><a href="#" >结束调查</a></th>
		</tr>
	</table>
              </EmptyDataTemplate>
              <EditRowStyle BackColor="#2461BF" />
              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
              <PagerStyle CssClass="header"  HorizontalAlign="Center" />
              <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
              <AlternatingRowStyle BackColor="White" />
          </asp:GridView>
       
          <asp:ObjectDataSource ID="ObjectDataSourceStyle" runat="server" SelectMethod="DC_GetBillResultByDate"
              TypeName="dll_FindProductShow">
              <SelectParameters>
             
                  <asp:Parameter DefaultValue="1900-01-01" Name="DateBegin" Type="dateTime"/>
                  <asp:Parameter DefaultValue="1900-01-01" Name="DateEnd" Type="dateTime" />
              </SelectParameters>
          </asp:ObjectDataSource>
  
      </td>
    </tr>
</table>
       
                       
    </div>
    </form>
</body>
</html>


