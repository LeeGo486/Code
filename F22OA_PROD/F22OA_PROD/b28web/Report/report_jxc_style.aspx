<%@ page language="C#" autoeventwireup="true" enableeventvalidation="false" inherits="pos_annil_report_jxc_style, App_Web_report_jxc_style.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>进销存查询</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />

    <script src="../Utility/command.js" type="text/javascript"></script>

    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Utility/jquery-1.2.6.min.js"></script>

    <script type="text/javascript" src="../Utility/dateChooser.js"></script>

    <style type="text/css">
             html
        {
            overflow: auto;
        }
        body, td, th
        {
            font-size: 12px;
        }
        body
        {
            padding: 10px;
        }
        form
        {
            margin: 0px;
        }
        .nb
        {
            border: 0px;
        }
      
         .fixedHeaderTr
        {
            position: relative;
            top: expression(this.offsetParent.scrollTop);
            height:30px;
        }
        
        .mainDiv
        {
            overflow: auto;
            scrollbar-face-color: 9999ff;
            height: expression((document.body.clientHeight-this.offsetTop-0>this.children[0].offsetHeight)?(this.children[0].offsetHeight+0)   :   (document.body.clientHeight-this.offsetTop-0));
            width: expression(document.body.clientWidth-20);
        }
        
          #tblreport
        {
            margin: 10px;
        }
        .tablesorter th
        {
            background: #bfd7fa;
            cursor: pointer;
        }
        .tablesorter tbody tr
        {
            height: 18px;
            background-color: expression((this.sectionRowIndex%2==0)?   "#ebf6ff" : "#f5faff" );
        }
       
    </style>

    <script type="text/javascript">
    function selectStyle(){
		showModalDialog('..\\..\\pos\\pos\\f22\\report\\select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
	
    function jcxbycode(styleid)
    {
        var dt1 = document.getElementById('ddt1');
        var dt2 = document.getElementById('ddt2')
        var depotid = document.getElementById('depotid');
        var url="report_jxc_code.aspx?dt1="+dt1.value+"&dt2="+dt2.value+"&styleid="+styleid+"&depotid="+depotid.value;
        var sm = showModalDialog(url,window,'dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
    //
    }
    </script>

 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center>
            <h3 id="header">
                进 销 存 查 询
            </h3>
        </center>
        <table width="100%" border="0" cellpadding="0" class="f14">
            <tr>
                <td>
                    <asp:HiddenField ID="depotid" runat="server" />
                    <asp:HiddenField ID="ddt1" runat="server" />
                    <asp:HiddenField ID="ddt2" runat="server" />
                    &nbsp; &nbsp; 开始日期：<asp:TextBox ID="dt1" runat="server" CssClass="calendarSelectDate"></asp:TextBox>
                    结束日期：<asp:TextBox ID="dt2" runat="server" CssClass="calendarSelectDate"></asp:TextBox>
                    <input name="button2" type="button" id="button2" value="选择款式" onclick="javascript:selectStyle()" />
                    <asp:Button ID="Button1" runat="server" Text="查　询" OnClick="Button1_Click" />
                    &nbsp;<asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="导出到EXCEL" />
                </td>
            </tr>
        </table>
    </div>
   
    <div id="divMain" class="mainDiv" style="height:430px; width:99%;" runat="server">
        <table id="tblreport" class="tablesorter" border="0" cellspacing="1" cellpadding="3"
            width="95%" style="margin-top:-2px">
            <thead>
                <tr class="fixedHeaderTr" >
                    <th   nowrap onclick="sortTable('tblreport','str',this,1,0)" sorttype="asc">
                        款式
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        期初
                    </th>
                    <!--   <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        生产入库
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        次品退厂
                    </th>
                    -->
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        发货
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        发货收货
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        调拨发货
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        调拨收货
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        退货
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        退货收货
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        零售
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        在途
                    </th>
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        盘点差异
                    </th>
                    <th   nowrap onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        期末
                    </th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="gvreport" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <a href="javascript:;" onclick="jcxbycode('<%# DataBinder.Eval(Container.DataItem,"styleid") %>')">
                                    <%# DataBinder.Eval(Container.DataItem,"styleid") %></a>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "qckc")%>
                            </td>
                            <!--  <td>
                                <%# DataBinder.Eval(Container.DataItem, "indepot")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "outdepot")%>
                            </td>
                            -->
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "sellset")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "sellget")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "moveset")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "moveget")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "outindentset")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "outindentget")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "retail")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "zt")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "pd")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "qmkc")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    </form>
</body>
</html>
