<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="ResAdd.aspx.cs" Inherits="EPReper.Web.EPSafe.ResAdd" validateRequest="false"  %>
 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">  <link rel="stylesheet" type="text/css" href="style/Css/base.min.css">
    <link id="templateFrame" rel="stylesheet" type="text/css" href="style/Css/332.min.css">
    <script type="text/javascript" src="style/Script/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="style/Script/fai.min.js"></script>
    <script type="text/javascript" src="style/Script/jquery.imageSwitch.js"></script>
    <link href="../kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../kindediter/themes/default/default.css" />
    <link rel="stylesheet" href="../kindediter/plugins/code/prettify.css" />
    <script charset="utf-8" src="../kindediter/kindeditor.js" type="text/javascript"></script>
    <script charset="utf-8" src="../kindediter/lang/zh_CN.js" type="text/javascript"></script>
    <script charset="utf-8" src="../kindediter/plugins/code/prettify.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#datepicker").datepicker({ dateFormat: "yy-mm-dd" });
        });
    </script>
    <style type="text/css">
        #TextArea1
        {
            height: 111px;
            width: 218px;
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
                    <span runat="server" id="SpanType" style="color: #0087ce;">安全责任</span>
                </div>
                <div style="border: 1px solid #C0C0C0; padding: 5px; height: 534px; width: 800px; margin: auto; float: left;">
                    <table style="width: 700px;">
                        <tr>
                            <td style="width: 60px;">
                                部门
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListDept" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" Width="140px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            &nbsp;</td>
                            <td style="width: 60px;">
                                区域
                            </td>
                            <td colspan="3" rowspan="4">
                                <textarea id="TextAreaQuYu" cols="40" rows="8" runat="server" name="S1"></textarea></td>
                        </tr>
                        <tr>
                            <td style="width: 60px;">
                                责任人
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListPerson" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="true" Width="140px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 60px;">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 60px;">
                                时间</td>
                            <td>
                                <asp:TextBox ID="TextBoxDate" runat="server" Width="103px" Height="21px"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender1" PopupButtonID="show" Format="yyyy-MM-dd" runat="server" TargetControlID="TextBoxDate">
                                </cc1:CalendarExtender>
                                <input type="button" id="show" style="background-image: url(images/calender.gif); background-repeat: no-repeat; width: 25px; height: 25px" />
                            </td>
                            <td style="width: 60px;">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 60px;">
                               罚款</td>
                            <td style="width: 40px;">
                            <asp:TextBox ID="TextBoxfk" runat="server" OnKeyPress="if(((event.keyCode>=48)&&(event.keyCode <=57)) ) {event.returnValue=true;} else{event.returnValue=false;}" MaxLength="15"> </asp:TextBox>
                               
                            </td>
                            <td style="width: 60px;">
                              元</td>
                        </tr>
                 
                        <tr>
                            <td style="width: 60px;">
                            </td>
                            
                            <td style="width: 60px;">
                            </td>
                            <tr>
                             <td colspan="3" >
                                处理意见
                            </td>
                            <td colspan="3" >
                                 处理结果
                            </td>

                            </tr>
                            <tr>
                            <td colspan="3">
                                <textarea id="TextAreaYijian" cols="30" rows="4" runat="server"></textarea>
                            </td>
                             <td colspan="3">
                                <textarea id="TextAreaJieguo" cols="40" rows="4" runat="server"></textarea>
                            </td>
                            </tr>
                            <td style="width: 60px;">
                            </td>
                           
                        
                        </tr>
                        <tr>
                         <td colspan="6">
                                隐患
                            </td>
                        </tr>
                        <tr>
                        <td colspan="6">
                                <textarea id="TextAreaYinhuan" cols="90" rows="12" runat="server"></textarea>
                            </td>
                        </tr>
                    </table>
                      
                    <asp:Button ID="Button1" runat="server" Text="提交内容" OnClick="GetValue" OnClientClick="return CheckNull();" />
                    <script type="text/javascript">
                        var editor;
                        KindEditor.ready(function (K) {
                            editor = K.create('#<%=TextAreaYinhuan.ClientID %>', {
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
                            prettyPrint() ;

                        });

                        function Trim(str) { return str.replace(/(^\s*)|(\s*$)/g, ""); }
                        function Trim(editor) { return editor.replace('"', "'"); }
                        function CheckNull() {
                            var v_TextBoxQuyu = document.getElementById("<%= TextAreaQuYu.ClientID%>").value;
                            var v_TextBoxPerson = document.getElementById("<%= DropDownListPerson.ClientID%>").value;
                            var v_TextBoxDate = document.getElementById("<%= TextBoxDate.ClientID%>").value;
                            var v_TextBoxfk= document.getElementById("<%= TextBoxfk.ClientID%>").value;

                            var v_TextAreaYinhuan = document.getElementById("<%= TextAreaYinhuan.ClientID%>").value;
                            var v_TextAreaYijian = document.getElementById("<%= TextAreaYijian.ClientID%>").value;
                            var v_TextAreaJieguo = document.getElementById("<%= TextAreaJieguo.ClientID%>").value;


                            if (Trim(v_TextBoxQuyu).length <= 0) {
                                alert('区域 不能为空！');
                                return false;
                            }

                            if (Trim(v_TextBoxPerson).length <= 0) {
                                alert('责任人 不能为空！');
                                return false;
                            }

                            if (Trim(v_TextBoxDate).length <= 0) {
                                alert('区域类型 不能为空！');
                                return false;
                            }

//                            if (Trim(v_TextAreaYinhuan).length <= 0) {
//                                alert('安全隐患 不能为空！');
//                                return false;
//                            }
                            if (editor.isEmpty()) {
                                alert('安全隐患 不能为空！');
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
