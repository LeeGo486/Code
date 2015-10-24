﻿<%@ Page Title="按虚拟结构选择店铺" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" 
CodeBehind="DepotStructSelector.aspx.cs" Inherits="F23Web.Public.DepotStructSelector" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <div style="padding: 20px 5px;">
                    <h3>
                        选择店铺虚拟结构</h3>
                    <div style="width: 180px; height: 300px; margin-top: 10px; overflow: auto;">
                        <Base:AjaxTreeView ID="AjaxTreeView1" runat="server" url="ajax/AjaxMultiSelector.ashx?act=getdepotstruct"
                            data="null" showcheck="true" theme="arrows" onnodeclick="onnodeclick" oncheckboxclick="oncheckboxclick" />
                    </div>
                </div>
            </td>
            <td>
                <Base:MultiSelector ID="MultiSelector1" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
