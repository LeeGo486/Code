<%@ Page Title="拷贝" Language="C#" MasterPageFile="~/MasterPage/Base.Master" AutoEventWireup="true" 
CodeBehind="CopyBox.aspx.cs" Inherits="F23Web.Public.CopyBox" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    body,select,#tb td
    {
    	font-size:12px;
    }
    #selectType
    {
        width:120px;
        height:400px;	
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<input type ="hidden" id="id" class="field" name="id" />
 <cc1:ToolbarControl ID="ToolbarControl1" runat="server">
    <Buttons>
        <cc1:ButtonItem ID="btnclose" runat="server" Text="关闭" CssClass="icon icon-cross" />
        <cc1:ButtonItem ID="btnSureInput" runat="server" Text="拷贝" CssClass="icon icon-copy" Callback="btnCopy" />
    </Buttons>
 </cc1:ToolbarControl>
    <table id="tb">
        <tr>
            <td style="width:120px;">可拷贝的单据列表</td>    
            <td style="width:160px;">当前所查询单据：<span id="seltype"></span></td>    
            <td>开始日期：</td>    
            <td> <cc1:DatePicker ID="begdate" runat="server" CssClass="field " Width="90px" /></td>    
            <td>结束日期：</td>    
            <td><cc1:DatePicker ID="enddate" runat="server" CssClass="field " Width="90px" /></td>    
            <td>
                <input type="button" id="btnquery" value="查询" />
            </td>
        </tr>
    </table>
 <div style="width:125px;float:left;">
     <select id="selectType" size="20"  class="field" name="selectType" >
        <option value="d_outindentset">退货发货</option>
        <option value="d_inventory">盘点单</option>
     </select>
 </div>
 <div  style="width:750px;float:left;">
  <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="false" AutoLoad="false"
        AllowSort="True" HightLight="True" RowSelectType="Multiple" ServerSide="false" AjaxSource="getlist"
        BottomHeight="10" AllowPaginate="false" DisplayInfo="true" AjaxParams="$('.field').serializeObject"
        DisplayLength="15" >
    <columns>
        <cc1:GridControlColumn Caption="流水码" Width="140"  ColumnName="Sellboxid" Visibled="false"  />
        <cc1:GridControlColumn Caption="单据编号" Width="140"  ColumnName="czid"  />
        <cc1:GridControlColumn Caption="箱号" Width="60"  ColumnName="Sellbox"  />
        <cc1:GridControlColumn Caption="箱号条码" Width="140"  ColumnName="boxtm" />
        <cc1:GridControlColumn Caption="发货地" Width="100"  ColumnName="setdptname" />
        <cc1:GridControlColumn Caption="收货地" Width="100"  ColumnName="getdptname" />
        <cc1:GridControlColumn Caption="数量" Width="80"  ColumnName="nums" />
        <cc1:GridControlColumn Caption="现价金额" Width="80"  ColumnName="xsums" />
    </columns>
    </cc1:GridControl>
 </div>
</asp:Content>
