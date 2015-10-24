<%@ Page Title="扫描装箱" Language="C#" MasterPageFile="~/MasterPage/base.master" AutoEventWireup="true" CodeBehind="BoxImport.aspx.cs"
 Inherits="F23Web.Public.BoxImport" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
 body,input
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
        <cc1:ButtonItem ID="btnSureInput" runat="server" Text="生成单据明细" CssClass="icon icon-tick" Callback="btnSureInput" />
        <cc1:ButtonItem ID="btncopy" runat="server" Text="拷贝装箱" CssClass="icon icon-copy" Callback="btncopy" />
        <cc1:ButtonItem ID="btnTool" runat="server" Text="工具" CssClass="icon icon-dropdown st_field"   />
       
        <cc1:ButtonItem ID="btntxt" runat="server" Text="盘点机导入" CssClass="icon icon-add"   ParentID="btnTool" Callback="BoxTxtImport" />
        <cc1:ButtonItem ID="btntxtbox" runat="server" Text="盘点机分箱导入" CssClass="icon icon-add"   ParentID="btnTool" Callback="BoxTxtBox" />
        <cc1:ButtonItem ID="btnxlsOne" runat="server" Text="一维电子表格导入" CssClass="icon icon-add"   ParentID="btnTool" Callback="btnxlsOne" />
        <cc1:ButtonItem ID="btnxls" runat="server" Text="二维电子表格导入" CssClass="icon icon-add"   ParentID="btnTool" Callback="BoxXlsImport" />
    </Buttons>
 </cc1:ToolbarControl>

<input type="hidden" id="getdptid" name="getdptid" class="field getdptid" runat="server" />
<input type="hidden" id="sellbox" name="sellbox" class="field" />
<input type="hidden" id="id" name="id" class="field" />
 
<div id="divpanel">
<div id="divleft">
    <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="false"
        AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false" ShowFooter="true"
        Width="220px"    BottomHeight="130"  OnRowSelected="boxRowSelect"
        DisplayLength="15"　 AjaxSource="getBoxList" StateSave="true" AjaxParams="$('.field').serializeObject" AjaxComplete="grdcomplete"    >
        <columns>
            <cc1:GridControlColumn Caption="箱号" ColumnName="Sellbox" Width="50" SummaryType="Count"  />
            <cc1:GridControlColumn Caption="数量" ColumnName="nums"  Width="60" SummaryType="Sum" />
            <cc1:GridControlColumn Caption="装箱人" ColumnName="cr_name"  Width="86" SummaryType="None" />
        </columns>
    </cc1:GridControl>
    <input type="button" value="添加装箱号" onclick="addBox()" />
    <input type="button" value="删除当前箱" onclick="delBox()" />
    <input type="button" value="打印当前箱" onclick="PrintBox('box')" />
    <input type="button" value="打印合箱单" onclick="PrintBox('merge')"/>
    <input type="button" value="打印所有箱" onclick="PrintBox('all')" />
</div>
<div id="divright">
    <h3 >单　　号：<span id="outid"></span><span style="float:right;margin-right:70px;">本次装箱数:<span id="spsnum">12</span></span></h3> 
    <h3 >收&ensp;货&ensp;地：<span id="getdpt" runat="server"></span></h3>
    <h3 >当前箱号：<span id="boxid" class="field" ></span></h3>
    <h3 >箱号条码：<input type="text" id="boxtm" style="width:160px;" /></h3>

    <cc1:GridControl ID="GridControl2" runat="server" CssClass="display" AllowFilter="false" AutoLoad="false"
        AllowSort="false" HightLight="True" RowSelectType="Single" ServerSide="false" AjaxSource="getBoxDetail"
        BottomHeight="40" AllowPaginate="false" DisplayInfo="true" AjaxParams="$('.field').serializeObject" ShowFooter="true"
        DisplayLength="15" >
    <columns>
        <cc1:GridControlColumn Caption="款号" Width="130"  ColumnName="clothingid" SummaryFormatter="function(val){ return '合计：'}"  />
        <cc1:GridControlColumn Caption="波段" Width="80"  ColumnName="st_bd"  />
        <cc1:GridControlColumn Caption="款式编号" Width="100"  ColumnName="styleid"  />
        <cc1:GridControlColumn Caption="款式名称" Width="140"  ColumnName="s_name" />
        <cc1:GridControlColumn Caption="颜色编号" Width="70"  ColumnName="colorid" />
        <cc1:GridControlColumn Caption="尺码" Width="60" ColumnName="sizeid"  />
        <cc1:GridControlColumn Caption="已装箱数" Width="60" ColumnName="boxnums"  SummaryType="Sum"/>
        <cc1:GridControlColumn Caption="本次装箱数" Width="70"  ColumnName="nums" SummaryType="Sum" />
    </columns>
    </cc1:GridControl>
    <div id="divBottom">
    货号：<input type="text" id="clothingid" maxlength="32" /> <input type="button" value="按箱扫描" id="btnadd" /> 
    数量：<input type="text" value="1" class="para" maxlength="3" id="nums" />
    <label><input type="checkbox" id="chktm" />记录当前流水码</label>
    &nbsp;条码截取位数：<input type="text" value="0" class="para" maxlength="2" id="sub"  />
    <label>记录器：<span id="log">0</span></label>
    </div>
</div>
</div>
</asp:Content>
