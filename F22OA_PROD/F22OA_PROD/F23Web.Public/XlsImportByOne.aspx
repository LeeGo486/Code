<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="XlsImportByOne.aspx.cs" Inherits="F23Web.Public.XlsImportByOne" %>

<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="id" name="id" class="field" />
    <input type="hidden" id="type" name="type" class="field" />
    <input type="hidden" id="filename" name="filename" />
    <input type="hidden" id="testid" name="testid" />
    <div class="x-page">
        <div class="x-toolbar">
            <div class="container ">
                <div class="spacer">
                    &nbsp;
                </div>
                <div class="float">
                    <label class="caption">
                        选择Excel文件：</label><div class="uploadcontrol">
                            <iframe src="Upload.aspx?filetype=onexls" id="ifUpload" frameborder="no" scrolling="no"
                                style="width: 180px; height: 28px;"></iframe>
                        </div>
                    <div id="uploading">
                    </div>
                </div>
                <label class="caption">
                </label>
                <div class="float">
                    <input type="checkbox" id="sure" name="sure" class="field" value="0" />导入系统时自动登帐</div>
            </div>
            <div class="x-grid">
                <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="True"
                    AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false"
                    Width="100%" Height="100%" BottomHeight="70" AllowPaginate="true" DisplayInfo="true"
                    DisplayLength="15" AjaxSource="GetList" StateSave="true">
                </cc1:GridControl>
            </div>
        </div>
    </div>
</asp:Content>
