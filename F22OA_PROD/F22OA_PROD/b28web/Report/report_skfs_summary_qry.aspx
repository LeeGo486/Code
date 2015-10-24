<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_report_report_skfs_summary_qry, App_Web_report_skfs_summary_qry.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>店铺销售方式汇总表(券实际额)</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/command.js" type="text/javascript"></script>
    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../Utility/jquery-1.2.6.min.js"></script>
    <script type="text/javascript" src="../Utility/dateChooser.js"></script>
    <style type="text/css">
    body{
    	padding:10px;
    }
    #header{
    	text-align:center;
    	padding:10px;
    	line-height:30px;
    	}
    #header{
    	text-align:center;
    	padding:10px;
    	line-height:30px;
    	}
    #research table
    {
    	table-layout:fixed;
    }
    #research thead td
    {
    	text-align:center;
    	width:40px;
    	overflow:hidden;
    }
    #DataBody tr
    {
    	background:#F7F6F3
    }
    #DataBody tr.selected
    {
    	background:#E2DED6
    }
    .calendarSelectDate{ }
    .body
    {
    	padding:10px;
    	}
    	.fixedHeaderTr
    	{
    		background-color:rgb(93,123,157);
    	    height:25px;
    	    color:White;
    		}
    </style>

</head>
<body>

    <form id="form2" runat="server">
     <h3 id="header">
     店铺销售方式汇总表(券实际额)
    </h3>
    <div class="toolbar">   
        选择日期：<asp:TextBox ID="begdate" runat="server" cssclass="calendarSelectDate input" Width="80"  ></asp:TextBox>
        &nbsp;&nbsp;<asp:TextBox ID="enddate" runat="server" cssclass="calendarSelectDate input" Width="80"></asp:TextBox>
 
        <asp:Button ID="Button1" runat="server" Text="查　询" CssClass="btn2" OnClick="btnSeach_Click" />
    &nbsp;<asp:Button ID="Button3" runat="server" Text="导出到EXCEL" CssClass="btn2"  OnClick="Button3_Click"/>
    </div> 
 
         <div id="divMain" class="mainDiv" style="height: 430px; width: 99%;" runat="server">
        <table id="tblreport" class="tablesorter" border="1"   cellspacing="0" bordercolor='#999999' bordercolordark='#FFFFFF'
            width="98%" style=" ">
            <thead>
                <tr class="fixedHeaderTr">
                    <th rowspan="2">店铺编号</th>
                    <th rowspan="2">店铺名称</th>
                    <th rowspan="2">销售日期</th>
                    <th rowspan="2">开单数</th>
                    <th rowspan="2">总数量</th>
                    <th colspan="11">收款方式</th>
                    <th rowspan="2">结算金额</th>
                    <th rowspan="2">总实销金额</th>
                </tr>
                <tr class="fixedHeaderTr">
                    <th>低值券面额</th>
                    <th>现金券面额</th>
                    <th>券实际额</th>
                    <th>百联OK卡</th>
                    <th>充值卡</th>
                    <th>第三方卡</th>
                    <th>积分抵扣</th>
                    <th>刷卡</th>
                    <th>现金</th>
                    <th>信用卡</th>
                    <th>预存款</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="gvreport" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <tr>
                            <td> <%# DataBinder.Eval(Container.DataItem, "depotid")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem,"d_name") %>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem,"suredate") %>&nbsp;</td>

                            <td><%# DataBinder.Eval(Container.DataItem,"bill") %>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem,"nums") %>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem,"re1") %>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem,"re2") %>&nbsp;</td>

                            <td><%# DataBinder.Eval(Container.DataItem, "re3")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "re4")%>&nbsp;</td>

                            <td><%# DataBinder.Eval(Container.DataItem, "re5")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "re6")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "re7")%>&nbsp;</td>

                            <td><%# DataBinder.Eval(Container.DataItem, "re8")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "re9")%>&nbsp;</td>

                            <td><%# DataBinder.Eval(Container.DataItem, "re10")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "re11")%>&nbsp;</td>

                            <td><%# DataBinder.Eval(Container.DataItem, "sums")%>&nbsp;</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "fsums")%>&nbsp;</td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    
    </form>
</body>
</html>
