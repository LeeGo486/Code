<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_depotDate, App_Web_report_depotdate.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <script src="js/setday.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            font-size:14px;	
        }
        #main
        {
        	width:100%;
           	height:400px;    
        }
        #mian .top
        {
        	width:100%;
            height:50px;
            border-bottom:solid 2px black;
        }
        #main .content
        {
        	margin-top:5px;
            height:340px;
            width:100%;
            overflow:scroll;
        }
        #main .content td
        {
            border:solid 1px black;
            text-align:center;
            word-break: keep-all;	    
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="top" id="topDiv" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <tr>
                    <td width="70%">
                        日期：<input id="txt_btime" type="text" runat="server" onfocus="setday(this)"/>
                        至<input id="txt_etime" type="text" runat="server" onfocus="setday(this)" />
                    </td>
                    <td width="15%">
                        <asp:Button ID="btn_search" runat="server" Text="查询" 
                            onclick="btn_search_Click" />
                    </td>
                    <td width="15%">
                        <asp:Button ID="btn_excel" runat="server" Text="导出Excel" 
                            onclick="btn_excel_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="content" runat="server" id="codiv">
        </div>
    </div>
    </form>
</body>
</html>
