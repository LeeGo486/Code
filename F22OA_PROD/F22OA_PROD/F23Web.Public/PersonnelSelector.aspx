<%@ Page Title="人员选择" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="PersonnelSelector.aspx.cs" Inherits="F23Web.Public.PersonnelSelector" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="lib/tabs/jquery.ui.tabs.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="allowself" name="allowself" value="0" class="field" />
    <div id="tabs">
        <ul>
            <li><a href="#TypeSelector"><span>常用联系人</span></a></li>
            <li><a href="#MultiSelector"><span>按部门</span></a></li>
        </ul>
        <div id="TypeSelector">
            <div class="x-toolbar1" id="toolbar">
                <div class="float" style="margin-left: -40px; margin-top: 2px;">
                    <label class="caption">
                        员工姓名：</label>
                    <input type="text" id="key" name="key" class="field textInput" />
                </div>
                <div class="float" style="margin-left: -40px; margin-top: 2px;">
                    <Base:StateSelector ID="usertype" runat="server" DefaultValue="0" Callback="e_query"
                        CssClass="field">
                        <Status>
                            <Base:StateItem Enabled="True" Text="领导" Value="0" />
                            <Base:StateItem Enabled="True" Text="员工" Value="1" />
                        </Status>
                    </Base:StateSelector>
                </div>
            </div>
            <Base:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="false"
                AllowSort="false" HightLight="True" ServerSide="false" AjaxParams="getparams"
                Toolbar="#toolbar" Width="100%" Height="100%" BottomHeight="70" OnRowDoubleClick="e_submit"
                AllowPaginate="true" DisplayInfo="true" DisplayLength="30" AjaxSource="GetList"
                StateSave="true">
            </Base:GridControl>
        </div>
        <div id="MultiSelector">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top">
                        <div style="padding: 5px;">
                            <div style="width: 180px; height: 300px; margin-top: 10px; overflow: auto;">
                                <Base:AjaxTreeView ID="AjaxTreeView1" runat="server" url="ajax/AjaxMultiSelector.ashx?act=getorgstruct"
                                    data="null" showcheck="true" theme="arrows" onnodeclick="onnodeclick" oncheckboxclick="oncheckboxclick" />
                            </div>
                        </div>
                    </td>
                    <td>
                        <Base:MultiSelector ID="MultiSelector1" runat="server" callback="e_save" data="{act:'getorgpersonnelstruct'}"
                            url="/public/ajax/ajaxmultiselector.ashx" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
