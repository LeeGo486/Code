<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="cardEdit1, App_Web_cardedit1.aspx.f3086b61" title="Untitled Page" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<%--<style>
    .hidden { display:none;}
</style>--%>
<script  type="text/javascript">
    function GoUrlVipShop() 
    { 

    var url="SDBuildVipShop.aspx";	    
    var result=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:353px;");
	if (result!="" && result!=undefined)
     {     
         var arvalues=result.split(",");
         window.document.getElementById("ctl00_ctplhder_txtdepotid").value=arvalues[0];
         window.document.getElementById("ctl00_ctplhder_TextBox1").value=arvalues[1];       
     }

    }

</script>  

<%--    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>--%>
<DIV>
<TABLE><TBODY>

<TR>

    <TD width="738px" style="height: 100px">
       
        <fieldset>
            <legend>查询条件</legend>
            
           
                
                 <table width=100%>
                 <tr>
                 <td>
                  <asp:Label id="Label1" runat="server" Text="卡号起始："></asp:Label> 
            <asp:TextBox id="txtstar" runat="server" Width="84px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox> 
            <asp:Label id="Label2" runat="server" Text="卡号结束："></asp:Label> 
            <asp:TextBox id="txtcardend" runat="server" Width="84px" Font-Names="宋体" Font-Size="9pt"></asp:TextBox> 
            <asp:CompareValidator id="CompareValidator1" runat="server" ControlToCompare="txtstar" Operator="GreaterThanEqual" ControlToValidate="txtcardend" ErrorMessage="卡号范围不正确" Display=dynamic></asp:CompareValidator>
                     &nbsp;&nbsp;
                     <asp:Label id="Label3" runat="server" Text="是否发至顾客:"></asp:Label>
                     &nbsp;<asp:DropDownList id="ddlYespart" runat="server" Font-Names="宋体" Font-Size="9pt">
                                <asp:ListItem Value="-" Text="不限"></asp:ListItem>
                                <asp:ListItem Value="1" Text="发至店铺未发给顾客"></asp:ListItem>
                                <asp:ListItem Value="2" Text="已发给顾客"></asp:ListItem>
                </asp:DropDownList>
                 </td>
                 <td rowspan="2">
                            <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="65px" Text="查询" Height="23px" Font-Names="宋体"></asp:Button> 
                            <asp:Button id="btnprint" runat="server" Width="65px" Text="打印" Font-Names="宋体"></asp:Button>
                        </td>
                 </tr>
                    <TR>
                        <TD>
                            总部是否发卡:<asp:DropDownList id="ddlYesNo" runat="server" OnSelectedIndexChanged="ddlYesNo_SelectedIndexChanged" AutoPostBack="True" Font-Names="宋体" Font-Size="9pt" Width="80px">
                    <asp:ListItem Text="不限" Value="-"></asp:ListItem>
                    <asp:ListItem Text="已发卡" Value="1"></asp:ListItem>
                    <asp:ListItem Text="未发卡" Value="0"></asp:ListItem>
                </asp:DropDownList>&nbsp;&nbsp;
                            <asp:Label id="lbldepot" runat="server" Text="选择店铺:" Font-Names="宋体" Font-Size="9pt"></asp:Label>&nbsp;
                            <asp:TextBox id="txtdepotid" runat="server" Width="84px" BorderStyle="None" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>
                            &nbsp; &nbsp; &nbsp;<asp:Button id="btnSelectDepot" runat="server" Text="选择店铺" OnClientClick="GoUrlVipShop()" Width="71px"></asp:Button> 
                            <asp:TextBox id="TextBox1" runat="server" BorderStyle="None" BackColor="#ECF3F6" Font-Names="宋体" Font-Size="9pt"></asp:TextBox>&nbsp;
                        </TD>
                    </TR>
                    
                 </table>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" Visible="False" /></fieldset>        
    </TD>
</TR>


</TBODY>
</TABLE>
</DIV>
<%--</contenttemplate>    
    </asp:UpdatePanel>--%>

   <%-- <asp:UpdatePanel id="UpdatePanel2"  runat="server">
       <contenttemplate>--%>
<TABLE style="WIDTH: 95%; HEIGHT: 345px"><TBODY><TR valign=top><TD style="HEIGHT: 218px" vAlign=top>
<asp:GridView id="GridView1" runat="server" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" 
AllowPaging="True" PageSize="15" AllowSorting="True" OnRowDeleting="GridView1_RowDeleting" GridLines="None" 
ForeColor="#333333" CellPadding="4" AutoGenerateColumns="False" OnRowUpdating="GridView1_RowUpdating" 
DataKeyNames="cardid" OnRowCreated="GridView1_RowCreated" OnRowDataBound="GridView1_RowDataBound" DataSourceID="ObjectDataSource1">
<FooterStyle BackColor="#507CD1" Width="100%" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="*"><ItemTemplate>
    <%# (Container.DataItemIndex + 1).ToString() %>
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="cardid" SortExpression="cardid" HeaderText="卡号"></asp:BoundField>
<asp:BoundField DataField="cardname" HeaderText="卡名称" SortExpression="cardname"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="sums" HeaderText="金额"  SortExpression="sums"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="proposerid" HeaderText="客户编号"  SortExpression="proposerid" HeaderStyle-CssClass="hidden"  ItemStyle-CssClass="hidden" FooterStyle-CssClass="hidden"></asp:BoundField>
<asp:TemplateField HeaderText="客户姓名">
    <ItemTemplate>
        <%--<asp:HyperLink  runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.names") %>' NavigateUrl='<%# "ProposerCurrentEdit.aspx?ProposerID=" + DataBinder.Eval(Container, "DataItem.proposerid")  %>' ID="Hyperlink2">--%>
        <a href='proposercurrentedit.aspx?ProposerID= + <%# DataBinder.Eval(Container, "DataItem.proposerid") %> + &strcardid=+<%#Eval("cardid") %>' > <%# DataBinder.Eval(Container, "DataItem.names") %> </a>
    <%--</asp:HyperLink>--%>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="names" HeaderText="客户姓名" Visible="False"></asp:BoundField>
<asp:BoundField DataField="depotid" HeaderText="店铺号"  SortExpression="depotid" ></asp:BoundField>
<asp:BoundField DataField="d_name" HeaderText="发卡店铺"  SortExpression="d_name"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="crname" HeaderText="创建人" Visible="False"></asp:BoundField>
<asp:BoundField DataField="username" HeaderText="创建人"></asp:BoundField>
<asp:CheckBoxField ReadOnly="True" DataField="start" SortExpression="start" HeaderText="卡状态" Visible="False" ></asp:CheckBoxField>
<asp:BoundField DataField="statename" HeaderText="卡状态" SortExpression="statename"></asp:BoundField>
<%--<asp:BoundField DataField="comment1" HeaderText="备注" SortExpression="comment1"></asp:BoundField>--%>
<asp:TemplateField HeaderText="备注">
    <ItemTemplate>
        <%# jcard.InterceptFn(Eval("comment1").ToString(), 12)%>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="crdate" Visible="False" HeaderText="创建日期"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="lastdate" Visible="False" HeaderText="最后更新日期"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="start" Visible="False" HeaderText="生效"></asp:BoundField>
<asp:TemplateField HeaderText="操作" ShowHeader="False"><EditItemTemplate>
<asp:LinkButton runat="server" Text="更新" CommandName="Update" CausesValidation="True" id="LinkButtonUp"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="取消" CommandName="Cancel" CausesValidation="False" id="LinkButtonCancel"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton runat="server" Text="编辑" CommandName="Edit" CaussesValidation="False" id="LinkButtonEdit"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="删除" CommandName="Delete" CausesValidation="False" id="LinkButtonDel"></asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
<asp:CommandField SelectText="修改" ShowSelectButton="True" HeaderText="查看"></asp:CommandField>

</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> 
<asp:ObjectDataSource id="ObjectDataSource1" runat="server" OnDeleting="ObjectDataSource1_Deleting" TypeName="jcard" DeleteMethod="delete" SelectMethod="selectFillCard" UpdateMethod="update" OnUpdating="ObjectDataSource1_Updating"><DeleteParameters>
<asp:Parameter Type="String" Name="cardid"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Type="String" Name="cardid"></asp:Parameter>
<%--<asp:Parameter Type="String" Name="cardname"></asp:Parameter>
<asp:Parameter Type="Decimal" Name="sums"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="crdate"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="lastdate"></asp:Parameter>
<asp:Parameter Type="String" Name="crname"></asp:Parameter>--%>
<asp:Parameter Type="String" Name="comment"></asp:Parameter>
<%--<asp:Parameter Type="Boolean" Name="start"></asp:Parameter>
<asp:Parameter Type="Int32" Name="proposerid"></asp:Parameter>--%>
<asp:Parameter Type="String" Name="depotid"></asp:Parameter>
</UpdateParameters>
<SelectParameters>
<asp:Parameter Type="String" DefaultValue="0" Name="cardidBeg"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="0" Name="cardidEnd"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="0" Name="depotid"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="-" Name="yesnosendcard"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="-" Name="yesnosendcust"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 

<asp:ObjectDataSource id="ObjectDataSource2" runat="server" OnDeleting="ObjectDataSource2_Deleting" TypeName="jcard" DeleteMethod="delete" SelectMethod="selectFillCardCommon" ><DeleteParameters>
<asp:Parameter Type="String" Name="cardid"></asp:Parameter>
</DeleteParameters>
<SelectParameters>
<asp:Parameter Type="String" DefaultValue="0" Name="cardidBeg"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="0" Name="cardidEnd"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="0" Name="depotid"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="-" Name="yesnosendcard"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="-" Name="yesnosendcust"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 
</TD></TR></TBODY></TABLE>
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
   
</asp:Content>

