<%@ page language="C#" autoeventwireup="true" inherits="pos_annil_report_jxc_code, App_Web_report_jxc_code.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="pragma" content="no-cache" />
    <title>条码</title>
    <style type="text/css">

    body,td,th {
	    font-size: 12px;
    }
    body {
	    margin-top: 0px;
	    margin-bottom: 0px;
	    margin-left: 1px;
	    margin-right: 1px;
    }
    form {
	    margin:0px;
    }
    .nb {
	    border:0px;
    }
    #tblreport
    {
    	margin:10px;
    	}
    .tablesorter th
    {
    	background:#bfd7fa;
    	cursor:pointer;
    	}
    .tablesorter tbody tr
    {
    	height:18px;background-color:expression((this.sectionRowIndex%2==0)?"#ebf6ff":"#f5faff");
    	}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table id="tblreport" class="tablesorter" width="94%" cellspacing="1" cellpadding="3" >
        <caption>款式条码进销存统计</caption>
        <thead> <tr>
                    <th onclick="sortTable('tblreport','str',this,1,0)" sorttype="asc">
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
                    <th onclick="sortTable('tblreport','num',this,1,0)" sorttype="asc">
                        期末
                    </th>
        </tr></thead>
        <tbody>
        <asp:Repeater ID="gvreport" runat="server" EnableViewState="false">
      <ItemTemplate>
                        <tr>
                            <td>
                                
                                    <%# DataBinder.Eval(Container.DataItem,"clothingid") %>
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
    </table>
    </div>
    </form>
</body>
</html>
