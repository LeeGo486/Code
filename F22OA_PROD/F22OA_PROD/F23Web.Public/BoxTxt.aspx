<%@ Page Title="盘点机分箱导入" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" 
CodeBehind="BoxTxt.aspx.cs" Inherits="F23Web.Public.BoxTxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css">
        boyd,form
        {
            font-size:12px;	
        }
     </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" name="importtype" id ="importtype" class="field" />
    <input type="hidden" id="filename" name="filename" class="field" />
    <input type="hidden" name="czid" id ="czid" class="field" />
     <input type="hidden" id="testid" name="testid" />
    <div style="padding: 20px;">
        <fieldset>
            <legend>
                <h3>
                    1.上传盘点机文件
                </h3>
            </legend>
            <div class="container ">
                <div class="spacer">
                    &nbsp;
                </div>
                <div class="float">
                    <label class="caption">
                        选择盘点机文件：</label>
                    <div class="uploadcontrol">
                        <iframe src="Upload.aspx?filetype=txt" id="ifUpload" name="ifUpload" frameborder="no"
                            scrolling="no" style="width: 180px; height: 28px;"></iframe>
                    </div>
                    <div id="uploading">
                    </div>
                </div>
            </div>
        </fieldset>
        <div>
            &nbsp;</div>
        <fieldset>
            <legend>
                <h3>
                    2.设置数据提取参数
                </h3>
            </legend>
            <div class="container ">

             
                <div class="float medium ">
                    <label class="caption">
                        截取位数：</label>
                    <input type="text" name="txt_cut" class="field numeric textInput small" id="txt_cut" maxlength="2" />
                </div>
                <div class="float medium">
                    <label class="caption">
                        分隔符：</label>
                    <input type="text" name="txt_split" class="field  textInput small" maxlength="1" id="txt_split" />
                </div>
                <div class="clear">
                    &nbsp;</div>
       
                <div class="spacer">
                    &nbsp;
                </div>
            </div>
        </fieldset>
        <div>
            &nbsp;</div>
        <fieldset>
            <legend>
                <h3>
                    3.提取结果
                </h3>
            </legend>
            <div id="divdemo" class=" bluepanel">
                <span id="demo">请选择盘点机文件</span>
            </div>
            <div id="divmsg" style="display: none; height: 180px;">
                <textarea id="msg" name="msg" style="width: 95%; height: 160px;" cols="80"" class="redpanel"></textarea>
            </div>
        </fieldset>
    </div>
</asp:Content>
