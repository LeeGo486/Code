<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="ClipboardManager.aspx.cs" Inherits="F23Web.Public.ClipboardManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:ToolbarControl ID="ToolbarControl1" runat="server">
        <Buttons>
            <Base:ButtonItem ID="btnhelp" runat="server" CssClass="icon icon-info" FloatRight="True"
                Text="帮助" ToolTip="" Width="100px" />
            <Base:ButtonItem Text="关闭" runat="server" ID="btnclose" Callback="function(){ window.close();}" CssClass="icon icon-cross" />
            <Base:ButtonItem ID="ButtonItem1" runat="server" CssClass="icon icon-find" IsSplitButton="True"
                Text="查询" ToolTip="" Width="100px"  Callback="query"/>
            <Base:ButtonItem ID="btnedit" runat="server" CssClass="icon icon-pencil" IsSplitButton="True"
                Text="修改" ToolTip="" Width="100px"  Callback="edit"/>
            <Base:ButtonItem ID="btndel" runat="server" CssClass="icon icon-delete" Text="删除" Callback="del"
                ToolTip="" Width="100px" HotKey="ctrl+del" />
        </Buttons>
    </Base:ToolbarControl>
     选择类型：<Base:SelectBox ID="SelType" CssClass="SelType" runat="server">
    </Base:SelectBox>
    <Base:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="false" 
        AllowSort="true" HightLight="true" RowSelectType="Single" ServerSide="false"
        AjaxSource="ClipboardManager.aspx/GetList" OnRowDoubleClick="RowDoubleClick"
        AjaxParams="getparams" ServerData="" DisplayInfo="false" OnRowSelected="rowselected"
        InnerWidth="100%" InitComplete="initComplete">
    </Base:GridControl>
</asp:Content>
