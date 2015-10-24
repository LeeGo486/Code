<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_filerecycle, App_Web_filerecycle.aspx.9ee944ed" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>文档管理列表</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <link href="../inquire/scripts/project.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server" >
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <table width="100%" border="0" cellpadding="0" cellspacing="5">
      <tr>
        <td>
<div style="text-align:center;"><asp:Label ID="Label2" runat="server" Width="100%" ForeColor="Red"></asp:Label></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="5">

  <tr>
    <td>
       <asp:DataList ID="DataList1" runat="server" Width="98%" CellPadding="4" ForeColor="#333333" HorizontalAlign="Center" CssClass="datalist" 
        OnDeleteCommand="delete" OnUpdateCommand="update">
       <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
<%--头模板--%>
        <HeaderTemplate>
        <div style="width:6%;">ID</div>
        <div style="width:8%;">文档类型</div>
        <div style="width:32%;">文档名称</div>
        <div style="width:8%;">店铺编号</div>
        <div style="width:10%;">店铺名称</div>
        <div style="width:8%;">创建人</div>
        <div style="width:10%;">创建日期</div>
        <div style="width:8%;">状态 </div>
        <div style="width:10%;">操作</div>
        </HeaderTemplate>
        
<%--项模板--%>
        <ItemTemplate>
        <div style="width:6%;">
        <%#Eval("fileid") %>　
        </div>
        <div style="width:8%;">
        <%# Eval("tname") %>
        </div>
        <div style="width:32%;text-align:left;">
        <a href="../file/openfile.aspx?url=<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.fileurl")) %>" target="_blank"><%# Eval("fname") %></a>
        </div>
        <div style="width:8%;">
        <%# Eval("depotid") %>
        </div>
        <div style="width:10%;">
        <%# Eval("d_name")%>
        </div>
        <div style="width:8%;">
        <%# Eval("crname") %>
        </div>
        <div style="width:10%;">
        <%# Eval("crdate") %>
        </div>
        <div style="width:8%;">
        <span style="color:Gray">已移除</span>
        </div>
            
        <div style="width:10%;">
             <asp:LinkButton ID="config3" runat="server" CommandName="update"
               OnClientClick="return confirm('恢复后的文档需要重新审核，确定执行此操作吗?')">恢复</asp:LinkButton>
             <asp:LinkButton ID="config2" runat="server" CommandName="delete" 
                 OnClientClick="return confirm('删除该文档将不能恢复，确定执行此操作吗?')">删除</asp:LinkButton>
        </div>
        <%# setRemark(Eval("crrmk").ToString()) %>
        </ItemTemplate>

        <FooterTemplate>
        
        </FooterTemplate>
           <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
           <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
           <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
           <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DataList>
        </td>
  </tr>
    <tr>
    <td style="height:20px;">
        <asp:Panel ID="Panel1" runat="server" Visible="false">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton3" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton4" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton5" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton6" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton7" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton8" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton9" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton10" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton11" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton12" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton13" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton14" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton15" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton16" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton17" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton18" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton19" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton20" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton21" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:HiddenField ID="HiddenField1" runat="server" Value="1" />
        </asp:Panel>
    
        </td>
  </tr>
</table>

</div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>