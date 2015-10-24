<%@ Page Title="二维电子表格导入" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" CodeBehind="BoxXlsImport.aspx.cs" Inherits="F23Web.Public.BoxXlsImport" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    form,body
    {
        font-size:12px;	
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="importtype" name="importtype" class="field" />
    <input type="hidden" id="czid" name="czid" class="field" />
    <div class="x-page">
        <div class="x-toolbar">
            <div class="container ">
                <div class="spacer">
                    &nbsp;
                </div>
                <div class="float">
                    <label class="caption">
                        选择Excel文件：</label><div class="uploadcontrol">
                            <iframe src="Upload.aspx?filetype=boxXls" id="ifUpload" name="ifUpload" frameborder="no" scrolling="no" style="width: 180px;
                                height: 28px;"> </iframe>
                        </div>
                    <div id="uploading">
                    </div>
                </div>
            </div>
            <div id="divchk" style="float:right;margin-top:-30px;margin-right:20px;"> <label><input type="checkbox" id="chkprice" name="chkprice" />取电子表格价格</label></div>

            <div class="x-grid">
                <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="True"
                    AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false" ShowFooter="true"
                    Width="100%" Height="100%" BottomHeight="70" AllowPaginate="true" DisplayInfo="true"
                    DisplayLength="15" AjaxSource="GetList" StateSave="true">
                </cc1:GridControl>
            </div>
        </div>
    </div>
</asp:Content>
