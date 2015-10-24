<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" CodeBehind="BoxTxtImport.aspx.cs" Inherits="F23Web.Public.BoxTxtImport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css">
        boyd,form
        {
            font-size:12px;	
        }
     </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="id" name="id" class="field" />
    <input type="hidden" id="type" name="type" class="field" />
    <input type="hidden" id="target" name="target" class="field" />
    <input type="hidden" id="reprice" name="reprice" class="field" />  
    <input type="hidden" id="filename" name="filename" class="field" />
    <input type="hidden" id="testid" name="testid" />
    <input type="hidden" id="boxid" name="boxid" class="field" />

    <div style="padding: 20px;">
        <center><h2 id="txtboxid">当前箱号：</h2></center> 
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
                <div class="spacer">
                    &nbsp;
                </div>
                <div class="float">
                    <label class="caption">
                        <b>分隔符：</b></label>
                    <input class="field" type="radio" name="split" id="split0" value="0" /><label for="split0">空格或TAB</label> 
                </div>
                <div class="clear ">
                    &nbsp;</div>
                <div class="float medium">
                    <label class="caption">
                        款号起始位：</label>
                    <input type="text" name="clothingid_beg" class="field numeric textInput small" id="clothingid_beg" />
                </div>
                <div class="float medium">
                    <label class="caption">
                        款号长度：</label>
                    <input type="text" name="clothingid_len" class="field numeric textInput small" id="clothingid_len" />
                </div>
                <div class="clear ">
                    &nbsp;</div>
                <div class="float medium">
                    <label class="caption">
                        数量起始位：</label>
                    <input type="text" name="num_beg" class="field numeric textInput small" id="num_beg" />
                </div>
                <div class="float medium">
                    <label class="caption">
                        数量长度：</label>
                    <input type="text" name="num_len" class="field numeric textInput small" id="num_len" />
                </div>
                <div class="clear">
                    &nbsp;</div>
                  <div class="float ">
                    <label class="caption ">
                        <b>分隔符：</b></label>
                    <input class="field" type="radio" name="split" id="split1" value="1" checked="checked" /><label for="split1">逗号</label> 
                </div> 
                 <div class="clear ">
                    &nbsp;</div>
                <div class="float medium ">
                    <label class="caption">
                        款号位置：</label>
                    <input type="text" name="clothingid_loc" class="field numeric textInput small" id="clothingid_loc" />
                </div>
                <div class="float medium">
                    <label class="caption">
                        数量位置：</label>
                    <input type="text" name="num_loc" class="field numeric textInput small" id="num_loc" />
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
            <div id="divmsg" style="display: none; height: 80px;">
                <textarea id="msg" name="msg" style="width: 95%; height: 60px;" cols="80"" class="redpanel"></textarea>
            </div>
        </fieldset>
    </div>
</asp:Content>
