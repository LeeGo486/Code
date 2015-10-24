<%@ Page Title="选择文件" Language="C#" MasterPageFile="~/MasterPage/Modal.Master" AutoEventWireup="true"
    CodeBehind="UploadFiles.aspx.cs" Inherits="F23Web.Public.UploadFiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  
    <link href="lib/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="dtype" name="dtype" class="field" value="1" />
    <input type="hidden" id="current_userid" name="current_userid" value="" />
    <input type="hidden" id="action" name="action" class="field" value="" />
    <input type="hidden" id="dirid" name="dirid" class="field" value="" />
    <input type="hidden" id="type" name="type" class="field" value="" />
    <input type="hidden" id="parentid" name="parentid" class="field" value="" />
    <input type="hidden" id="isprivate" name="isprivate" class="field" value="0" />
    <input type="hidden" id="sel_dirname" name="seldirname" value="" />
    <input type="hidden" id="sel_orderby" name="selorderby" value="" />
    <input type="hidden" id="fileid" name="fileid" value="" />
    <div id="upload" style="height: 100%;">
        <div class="float" style="height: 300px; width: 720px; padding-top: 10px; border: 1px solid #ddd;">
            <label class="caption" style="margin-top: 5px">
                选择文件：</label>
            <input id="file_upload" name="file_upload" type="file" style="width: 100%" />
        </div>
    </div>
</asp:Content>
