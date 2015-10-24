<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="BookAdd.aspx.cs" Inherits="EPReper.Web.EPSafe.BookAdd" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" type="text/css" href="style/Css/base.min.css">
    <link id="templateFrame" rel="stylesheet" type="text/css" href="style/Css/332.min.css">
    <script type="text/javascript" src="style/Script/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="style/Script/fai.min.js"></script>
    <script type="text/javascript" src="style/Script/jquery.imageSwitch.js"></script>
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <meta charset="utf-8" content="" />
    <link href="../kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../kindediter/themes/default/default.css" />
    <link rel="stylesheet" href="../kindediter/plugins/code/prettify.css" />
    <script charset="utf-8" src="../kindediter/kindeditor.js" type="text/javascript"></script>
    <script charset="utf-8" src="../kindediter/lang/zh_CN.js" type="text/javascript"></script>
    <script charset="utf-8" src="../kindediter/plugins/code/prettify.js" type="text/javascript"></script>
    <script type="text/javascript">
   
    </script>
    <style type="text/css">
        #TextArea1
        {
            height: 140px;
            width: 450px;
        }
        #TextArea2
        {
            height: 60px;
            width: 450px;
        }
        #TextArea3
        {
            height: 60px;
            width: 450px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700; color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 693px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>
            </div>
        </div>
        <div style="float: left; width: 120px;">
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全新闻管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="SateUl" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全新闻&type=安全新闻">安全新闻</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全信息管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul1" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全公文">安全公文</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全公告">安全公告</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=规章制度">规章制度</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=会议纪要">会议纪要</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全法规">安全法规</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全知识">安全知识</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全工作管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul3" style="list-style: none; padding-left: 20px;">
                     <li><a href="SafeAdmin.aspx?Infotype=安全工作&type=安全工作">安全工作</a></li>
                      <li><a href="SafeSugList.aspx">安全建议</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全责任管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul2" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeResAdd.aspx">安全隐患</a></li>
                    <li><a href="SafeDuAdd.aspx">安全责任</a></li>
                    <li><a href="SafeRewAdd.aspx">安全奖励</a></li>
                     <li><a href="SafeMoney.aspx">部门金额</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全书籍推荐</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul4" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeBookAdd.aspx">安全书籍</a></li>
                </ul>
            </div>
             <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全热点专题</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul5" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeZhuan.aspx">安全热点专题</a></li>
                </ul>
            </div>
        </div>
        <div style="float: left; width: 840px;">
            <div style="width: 240px; padding-left: 5px;">
                <div class="NewsTabList" id="lableType" runat="server" style="width: 520px;">
                    <span runat="server" id="SpanType" style="color: #0087ce;">安全新闻</span>
                </div>
                <div>
                    <table style="width: 700px;">
                        <tr>
                            <td style="width: 100px;">
                                书籍标题
                            </td>
                            <td>
                                <asp:TextBox ID="Txtctitle" runat="server" Width="434px" AutoCompleteType="Disabled"></asp:TextBox>
                            </td>
                           
                        </tr>
                        <tr>
                            <td colspan="2">
                                书籍内容描述
                            </td>
                        </tr>
                    </table>
                    <textarea id="TxtNewsContent" cols="100" rows="8" style="visibility: hidden; width: 820px; height: 400px;" runat="server"></textarea>
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="提交内容" OnClick="GetValue" OnClientClick="return CheckNull();" />
                    <script type="text/javascript">
                        var editor;
                        KindEditor.ready(function (K) {
                            editor = K.create('#<%=TxtNewsContent.ClientID %>', {
                                cssPath: '../kindediter/plugins/code/prettify.css',
                                uploadJson: '../kindediter/asp.net/upload_json.ashx',
                                fileManagerJson: '../kindediter/asp.net/file_manager_json.ashx',
                                allowFileManager: false,
                                afterCreate: function () {
                                    var self = this;
                                    K.ctrl(document, 13, function () {
                                        self.sync();

                                    });
                                    K.ctrl(self.edit.doc, 13, function () {
                                        self.sync();
                                    });
                                }
                            });
                            prettyPrint();

                        });

                        function Trim(str) { return str.replace(/(^\s*)|(\s*$)/g, ""); }
                        function CheckNull() {
                            var v_ctitle = document.getElementById("<%= Txtctitle.ClientID%>").value;
                            if (Trim(v_ctitle).length <= 0) {
                                alert('书籍标题 不能为空！');
                                return false;
                            }
                            if (editor.isEmpty()) {
                                alert('书籍内容描述 不能为空！');
                                return false;
                            }
                            return true;
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
