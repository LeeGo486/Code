<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.Master" AutoEventWireup="true"
    CodeBehind="SheetChecker.aspx.cs" Inherits="F23Web.Public.SheetChecker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" value="<%=SheetID %>" class="field" name="sheetid" />
    <input type="hidden" value="<%=menuid %>" class="field" name="menuid" />
    <div class="container">
        <div class="spacer">
            &nbsp;
        </div>
        <div>
            <h3>
                单据<%=OperationText%>说明</h3>
            <p style="color: Red">
                1、<%=OperationText%>单据需要通过以下检查步骤</p>
            <p style="color: Red">
                2、已提交的单据不允许修改</p>
        </div>
        <div class="spacer">
            &nbsp;
        </div>
        <div class="float middle">
            <label class="caption">
                <em>*</em>
                <%=OperationText%>日期：</label>
            <Public:DateTextbox ID="setdate" runat="server" />
        </div>
        <div class="clear">
            &nbsp;</div>
        <div class="float middle">
            <label class="caption">
                <em>*</em>
                <%=OperationText%>人：</label>
            <input name="crname" type="text" class="field textInput" style="width:85px;" disabled="disabled" value="<%=UserName %>" />
        </div>
    </div>
    <Base:GridControl ID="CheckList" runat="server" CssClass="display" AllowFilter="false"
        AllowSort="false" HightLight="false" RowSelectType="None" ServerSide="false"
        AllowPaginate="false" DisplayInfo="false"  BottomHeight="60">
        <columns>
            <Base:GridControlColumn Caption="序号" ColumnName="codeid" Width="50" Visibled="false" />
            <Base:GridControlColumn Caption="检查项" ColumnName="codereadme" Width="150" />
            <Base:GridControlColumn Caption="信息" Width="150" />
            <Base:GridControlColumn Caption="状态" Width="75" Render="stateRender" />
            <Base:GridControlColumn Caption="脚本" ColumnName="codename" Visibled="false" />
            <Base:GridControlColumn Caption="审核" ColumnName="sure" Visibled="false" />
            <Base:GridControlColumn Caption="键名" Visibled="false" />
        </columns>
    </Base:GridControl>
</asp:Content>
