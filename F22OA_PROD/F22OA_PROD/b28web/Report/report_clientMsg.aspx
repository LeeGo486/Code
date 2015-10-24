<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_clientMsg, App_Web_report_clientmsg.aspx.7863a146" enableviewstatemac="false" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>顾客资料综合查询</title>
    <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="js/setday.js" type="text/javascript"></script>
    <script type="text/javascript">
        function checkDate(){
            var bt=$("#txt_btime").val();
            var et=$("#txt_etime").val();
            var b=bt.split("-");
            var bd=new Date(b[0],b[1],b[2]);
            var e=et.split("-");
            var ed=new Date(e[0],e[1],e[2]);
            if(b>e){
                alert("开始日期应该少于或者等于结束日期");
                return false;
            }
            return true;
        }
        
        function btnClick(){
            $("#btn_search").click(function(){
                $(this).hide();
                $("#btn_exl").hide();
            });
        }
        jQuery(function(){
            btnClick();
        })
    </script>
    <link href="css/f22jxctz2009Css.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server" onsubmit="return checkDate()">
    <div id="main">
        <div class="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="70%">
                        <asp:Literal ID="lit_title" runat="server"></asp:Literal>
                        <input id="txt_btime" type="text" runat="server" readonly="readonly" class="txtSty" onfocus="setday(this)"/>至
                        <input id="txt_etime" type="text" runat="server" readonly="readonly" class="txtSty" onfocus="setday(this)"/>
                        <asp:RadioButton ID="rtn_retaildate" runat="server" GroupName="d" Checked="true"/>按销售日期
                        <asp:RadioButton ID="rtn_vipdate" runat="server"  GroupName="d"/>按发卡日期
                    </td>
                    <td width="15%">
                        <asp:Button ID="btn_search" runat="server" Text="查询" 
                            onclick="btn_search_Click" /></td>
                    <td width="15%">
                        <asp:Button ID="btn_exl" runat="server" Text="导出Excel" onclick="btn_exl_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="content" runat="server">
            <asp:GridView ID="gv_content" runat="server" Width="100%" 
                CssClass="gridviewSty" EmptyDataText="没有数据" >
               <HeaderStyle CssClass="FixedTitleRow" />
            </asp:GridView>
        </div>
    </div>
    </form>
</body>
</html>
