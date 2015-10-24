<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Base.Master" AutoEventWireup="true" 
CodeBehind="ReadBox.aspx.cs" Inherits="F23Web.Public.ReadBox" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<base target="_self" />
<style type="text/css">
 body,input,span
 {
 	font-size:12px;
}
 
#divpanel
{
	min-width:900px;
}
#divleft
{
	float:left;
    width:220px;
    border-right:3px solid #cccccc	
}
#divleft input
{
    width:150px;	
    margin-left:25px;
    margin-top:3px;
}
#divright
{
    float:left; 
}
.para
{
    width:30px;	
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <cc1:ToolbarControl ID="ToolbarControl1" runat="server">
    <Buttons>
        <cc1:ButtonItem ID="btnclose" runat="server" Text="关闭" CssClass="icon icon-cross" />
        <cc1:ButtonItem ID="btnSureInput" runat="server" Text="读入" CssClass="icon icon-tick" Callback="btnSureInput" />
    </Buttons>
 </cc1:ToolbarControl>
 <div id="divpanel">
<div id="divleft">
    <input type="hidden" id="sellboxid" name="sellboxid" class="field" />
    <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="false"
        AllowSort="true" HightLight="True" RowSelectType="Single" ServerSide="false" ShowFooter="true"
        Width="220px"    BottomHeight="18"  OnRowSelected="boxRowSelect"
        DisplayLength="15"　 AjaxSource="getBoxList" StateSave="true" AjaxParams="$('.field').serializeObject" AjaxComplete="grdcomplete"    >
        <columns>
            <cc1:GridControlColumn Caption="流水码" ColumnName="sellboxid" Width="130" SummaryType="Count" Visibled="false"  />
            <cc1:GridControlColumn Caption="箱条码" ColumnName="boxtm" Width="130" SummaryType="Count"  />
            <cc1:GridControlColumn Caption="数量" ColumnName="nums"  Width="80" SummaryType="Sum" />
        </columns>
    </cc1:GridControl>

</div>
<div id="divright">
    <cc1:GridControl ID="GridControl2" runat="server" CssClass="display" AllowFilter="false" AutoLoad="false"
        AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false" AjaxSource="getBoxDetail"
        BottomHeight="18" AllowPaginate="false" DisplayInfo="true" AjaxParams="$('.field').serializeObject"
        DisplayLength="15" >
    <columns>
        <cc1:GridControlColumn Caption="款号" Width="140"  ColumnName="clothingid"  />
        <cc1:GridControlColumn Caption="款式编号" Width="110"  ColumnName="styleid"  />
        <cc1:GridControlColumn Caption="款式名称" Width="150"  ColumnName="s_name" />
        <cc1:GridControlColumn Caption="颜色编号" Width="80"  ColumnName="c_name" />
        <cc1:GridControlColumn Caption="尺码" Width="70" ColumnName="sizeid"  />
        <cc1:GridControlColumn Caption="已装箱数" Width="60" ColumnName="boxnums"  />
        <cc1:GridControlColumn Caption="本次装箱数" Width="70"  ColumnName="nums"  />
    </columns>
    </cc1:GridControl>
  
</div>
</div>
<table>
    <tr>
        <td style="width:220px;"><input type ="button" value="删除全部箱" onclick="delBoxAll()" /> <input type ="button" value="删除当前箱" onclick="delBox()" /></td>
        <td><span>箱条码：</span><input type="text" id="boxtm" /><input type="button" id="btnred" value="扫描" /></td>
    </tr>
</table>
</asp:Content>
