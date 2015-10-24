<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="userEdit1, App_Web_useredit1.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
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
<div align="center">
<table width="100%">
<tr>
<td>
<%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
   <contenttemplate>--%>
<BR /><TABLE cellSpacing=0 cellPadding=0 width=732 align=left><TBODY><TR><TD style="WIDTH: 732px; HEIGHT: 14px; TEXT-ALIGN: left" colSpan=2><FIELDSET><LEGEND>查询条件</LEGEND>姓名：<asp:TextBox id="txtid" runat="server"  Width="146px"></asp:TextBox>&nbsp;&nbsp; <asp:Button id="btnNext" onclick="btnNext_Click" runat="server" Width="70px" Height="25px" Text="查询"></asp:Button> <asp:Button id="Button1" runat="server" Width="77px" Text="打印"></asp:Button> </FIELDSET> </TD><TD>&nbsp;</TD></TR></TBODY></TABLE>
<%--</contenttemplate>    
</asp:UpdatePanel>--%>
</td>
</tr>
<tr>
<td>

<asp:UpdatePanel id="UpdatePanel2"  runat="server">
   <contenttemplate>
<TABLE style="WIDTH: 99%" height=200 cellSpacing=0 cellPadding=0 align=left border=0><TBODY><TR valign=top><TD style="WIDTH: 1000px; HEIGHT: 129px">
<asp:GridView id="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound" 
DataKeyNames="proposerid" OnRowCreated="GridView1_RowCreated" OnRowUpdating="GridView1_RowUpdating" 
OnRowDeleting="GridView1_RowDeleting" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" PageSize=15 
GridLines="None" AllowPaging="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowSorting="True">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:BoundField ReadOnly="True" DataField="proposerid" HeaderText="编号"  SortExpression="proposerid"></asp:BoundField>
<asp:BoundField DataField="names" HeaderText="姓名"  SortExpression="names"></asp:BoundField>
<asp:BoundField DataField="sex" HeaderText="性别" SortExpression="sex" ></asp:BoundField>
<asp:BoundField DataField="identity" HeaderText="证件号"  SortExpression="identity"></asp:BoundField>
<asp:BoundField DataField="tel" HeaderText="固定电话"  SortExpression="tel"></asp:BoundField>
<asp:BoundField DataField="add" HeaderText="联系地址"  SortExpression="add">
    <HeaderStyle Width=80px />
</asp:BoundField>

<asp:BoundField DataField="mtel" HeaderText="移动电话"  SortExpression="mtel"></asp:BoundField>
<asp:BoundField DataField="passwordtel" HeaderText="密码电话" Visible=false></asp:BoundField>
<%--<asp:BoundField DataField="comment" HeaderText="备注"  SortExpression="comment">
    <HeaderStyle Width=80px />
</asp:BoundField>--%>
<asp:TemplateField HeaderText="备注">
    <ItemTemplate>
        <%# jcard.InterceptFn(Eval("comment1").ToString(),12)%>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="presenter" HeaderText="推荐人"  SortExpression="presenter"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="depotid" HeaderText="店铺号"  SortExpression="depotid"></asp:BoundField>
<asp:BoundField ReadOnly="True" DataField="d_name" HeaderText="建立店铺"  SortExpression="d_name">
     <HeaderStyle Width=80px />
</asp:BoundField>
<asp:CommandField HeaderText="操作"  ShowDeleteButton=true></asp:CommandField>
<asp:CommandField SelectText="修改" ShowSelectButton="True" HeaderText="查看"></asp:CommandField>
<%--<asp:TemplateField>
    <ItemTemplate>
        <%# InterceptFn(Eval("add").ToString(),6)%>
    </ItemTemplate>
</asp:TemplateField>--%>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
<PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
</asp:GridView> &nbsp; <asp:ObjectDataSource id="ObjectDataSource1" runat="server"  OnUpdating="ObjectDataSource1_Updating" OnDeleting="ObjectDataSource1_Deleting" UpdateMethod="update" SelectMethod="select" DeleteMethod="delete" TypeName="jproposer" ><DeleteParameters>
<asp:Parameter Type="Int32" Name="proposerid"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Type="Int32" Name="proposerid"></asp:Parameter>
<asp:Parameter Type="String" Name="names"></asp:Parameter>
<asp:Parameter Type="String" Name="sex"></asp:Parameter>
<asp:Parameter Type="String" Name="identity"></asp:Parameter>
<asp:Parameter Type="String" Name="tel"></asp:Parameter>
<asp:Parameter Type="String" Name="mtel"></asp:Parameter>
<asp:Parameter Type="String" Name="addr"></asp:Parameter>
<asp:Parameter Type="String" Name="pswmtel"></asp:Parameter>
<asp:Parameter Type="String" Name="comment"></asp:Parameter>
<asp:Parameter Type="String" Name="presenter"></asp:Parameter>
<asp:Parameter Type="String" Name="depotid"></asp:Parameter>
</UpdateParameters>
<SelectParameters>
<asp:Parameter Type="String" Name="username" DefaultValue="--"></asp:Parameter>
<asp:Parameter Type="String" Name="userid" DefaultValue="--"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource> 
<asp:ObjectDataSource id="ObjectDataSource2" runat="server" SelectMethod="selectcommon" TypeName="jproposer"><SelectParameters>
<asp:Parameter Type="String" Name="username" DefaultValue="--" ></asp:Parameter>
<asp:Parameter Type="String" Name="userid" DefaultValue="--"></asp:Parameter>
</SelectParameters>
</asp:ObjectDataSource>


</TD></TR></TBODY></TABLE>
</contenttemplate>
</asp:UpdatePanel>
</td>
</tr>
</table>


        <br />


            
    </div>
</asp:Content>

