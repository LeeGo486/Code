<%@ page language="C#" autoeventwireup="true" enableviewstate="false" inherits="Inventory, App_Web_lgfgcxdm" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>库存盘点优化</title>
    <style type="text/css">
        .ext-ie .button-fix table.x-btn, .ext-gecko .button-fix table.x-btn
        {
            top: 0px;
        }
        .ext-ie .button-fix .x-form-text, .ext-gecko .button-fix .x-form-text
        {
            margin-top: 1px;
        }
        body
        {
            font-size: 12px;
            padding: 40px 0px;
        }
        .tablemain
        {
            background-color: #EEE;
            border: 1px solid #DDD;
            height:100px;
        }
    </style>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
    <ext:ResourceManager ID="MainResourceMgr" EnableViewState="false" GZip="true" runat="server" />
    <table class="tablemain" align="center">
        <tr>
            <td colspan="2">
                <ext:Label runat="server" ID="lblistno">
                </ext:Label>
            </td>
        </tr>
        <tr>
            <td>
                <ext:FileUploadField ID="UpFile" runat="server" CtCls="button-fix" Width="200" ButtonText="浏览..."
                    AllowBlank="false" EmptyText="请选择文件" Icon="LinkAdd" />
            </td>
            <td>
                <ext:Button runat="server" ID="btnsave" Text="导入" Icon="ArrowIn">
                    <DirectEvents>
                        <Click OnEvent="StartLongAction" Method="POST">
                            <EventMask Msg="正在上传文件，请稍后..." ShowMask="true" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <ext:ProgressBar ID="Progress1" runat="server" Width="300" />
                <ext:TaskManager ID="TaskManager1" runat="server">
                    <Tasks>
                        <ext:Task TaskID="longactionprogress" Interval="1000" AutoRun="false" OnStart="#{btnsave}.setDisabled(true);" 
                        OnStop="#{btnsave}.setDisabled(false);">
                            <DirectEvents>
                                <Update OnEvent="RefreshProgress" />
                            </DirectEvents>
                        </ext:Task>
                    </Tasks>
                </ext:TaskManager>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
