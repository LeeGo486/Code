<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_Brand, App_Web_report_brand.aspx.7863a146" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>竞争品牌调查表</title>

    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <%--<script src="js/Fixed.js" type="text/javascript"></script>--%>
    <%--<link type="text/css" rel="Stylesheet" href="css/lockedheaders.css" mce_href="css/lockedheaders.css" />--%>
    <script src="../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
    <style type="text/css">
        .head
        {
            height:25px;
            font-size:13px;
            font-weight:bold;
            background:#99CCFF;
        }
        .tit
        {
            font-size:13px;
            font-weight:bold;
            margin-top:10px;
            margin-bottom:5px;
        }
    </style>
    <style type="text/css">
    .divmain
{
	overflow: scroll; border: solid 1px gray;
}
.miantable 
{
    text-align:center;
	border-collapse: collapse; 
}
.miantable td 
{
	position: relative; padding: 5px;
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}
.miantable td.Locked /* 水平与垂直方向锁住单元格, 不随鼠标或滚动条移动 */
{
	z-index: 30; position: relative; 
    top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop); 
    left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
    background-color: #99CCFF; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}
.miantable td.HLocked /* 水平方向锁住单元格 */
{
	z-index: 10; position: relative; left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
    background-color: #fff; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}

.miantable td.xHLocked /* 水平方向锁住单元格 */
{
	z-index: 10; position: relative; left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
    background-color: #99CCFF; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}

.miantable td.VLocked /* 垂直方向锁住单元格 */
{
	z-index: 20; position: relative; top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop); 
    background-color: #99CCFF; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}

.miantable td.xVLocked /* 垂直方向锁住单元格 */
{
	z-index: 20; position: relative; top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop); 
    background-color: #FFFF99; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}
    </style>
    <script type="text/javascript">
        function LoadData(y, bm, em) {
            $("#main").html("");
            $("#main").html("<div style='width:100%;text-align:center;font-size:13px'>正在加载数据....</div>");
            $.ajax({
                url: "ajax/BrandRpt.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "BrandReport", "year": y, "bm": bm, "em": em, "dt": new Date().toString() },
                success: function (data) {
                    if (data.bid != "") {
                        if (data.msg == "") {
                            var m = data.m.split(','); //月份
                            var bid = data.bid.split(','); //品牌ID
                            var bname = data.bname.split(','); //品牌名称
                            var miandata = data.mlist;
                            if (miandata.length > 0) {
                                var width = 600 + (60 * m.length * 2) + (bid.length * 60 * m.length * 2) + (bid.length * 80);
                                var html = "<table id='mainTable' class='miantable' width='" + width + "'>";
                                html += "<thead><tr><td width='60px' class='Locked' rowspan='3'>店铺编号</td><td width='100px' class='Locked' rowspan='3'>店铺</td><td width='120px' rowspan='3' class='Locked'>督导</td>" +
                            "<td width='120px' rowspan='3' class='Locked'>类型</td><td width='80px' rowspan='3' class='Locked'>所属楼层</td><td width='100px' rowspan='3' class='Locked'>楼层女装数</td><td class='VLocked' colspan='" + (m.length * 2) + "'>本店铺</td>";
                                //加载竞争品牌
                                for (var i = 0; i < bid.length; i++) {
                                    html += "<td class='VLocked' colspan='" + (m.length * 2 + 1) + "'>主力竞品" + (i + 1) + "</td>";
                                }
                                html += "</tr>";
                                var head2 = "<tr >";
                                var head3 = "<tr >";
                                for (var i = 0; i < m.length; i++) {
                                    head2 += "<td class='VLocked' colspan='2'>" + m[i] + "月</td>";
                                    head3 += "<td class='VLocked' width='60px'>销售</td><td class='VLocked' width='60px'>排名</td>";
                                }
                                //加载竞争品牌
                                for (var j = 0; j < bid.length; j++) {
                                    head2 += "<td class='VLocked' rowspan='2' width='80px'>品牌名称</td>";
                                    for (var i = 0; i < m.length; i++) {
                                        head2 += "<td class='VLocked' colspan='2'>" + m[i] + "月</td>";
                                        head3 += "<td class='VLocked' width='60px'>销售</td><td width='60px' class='VLocked'>排名</td>";
                                    }
                                }
                                head2 += "</tr>";
                                head3 += "</tr></thead>";
                                html += head2; //二级表头
                                html += head3; //三级表头
                                //加载数据
                                //alert(data.xs["dpt_0001Z03"]);
                                html += "<tbody>";
                                $.each(miandata, function (i, item) {
                                    var tr = "<tr><td class='HLocked' width='60px'>" + item["depotid"] + "&nbsp;</td><td class='HLocked' width='100px'>" + item["d_name"] + "&nbsp;</td><td width='120px' class='HLocked'>" + item["d_dd"] + "&nbsp;</td><td class='HLocked' width='120px'>" + item["d_lx"] + "&nbsp;</td><td class='HLocked' width='80px'>" + item["floor"] + "&nbsp;</td><td class='HLocked' width='100px'>" + item["BrandNumber"] + "&nbsp;</td>";
                                    for (var i = 0; i < m.length; i++) {
                                        var v = item[m[i] + "月"];

                                        var xs = (parseFloat(v.split('|')[1]) == 0 || parseFloat(v.split('|')[1]) == -1) ? "-" : (parseFloat(v.split('|')[1]) / 10000).toFixed(1);
                                        var pm = parseInt(v.split('|')[0]) == 0 ? "-" : v.split('|')[0];
                                        tr += "<td class='xcount_xs" + m[i] + "'>" + xs + "</td><td>" + pm + "</td>";
                                    }

                                    var depxs = data.xs["dpt_" + item["depotid"]];
                                    var deppm = data.pm["dpt_" + item["depotid"]];

                                    if (depxs == undefined) {
                                        depxs = [];
                                    }
                                    if (deppm == undefined) {
                                        deppm = [];
                                    }
                                    var xsleng = 0;
                                    var d = Arr(depxs, deppm, m);
                                    var c = {};
                                    var cx = 0;
                                    if (d != undefined) {
                                        for (var obj in d) {
                                            tr += "<td width='60px'>" + d[obj]["BrandName"] + "&nbsp;</td>";
                                            for (var i = 0; i < m.length; i++) {
                                                var v = parseFloat(d[obj]["xs_" + m[i]]) == 0 ? "-" : (parseFloat(d[obj]["xs_" + m[i]]) / 10000).toFixed(1);
                                                var v1 = parseFloat(d[obj]["pm_" + m[i]]) == 0 ? "-" : d[obj]["pm_" + m[i]];
                                                tr += "<td class='count_" + cx + "_xs" + m[i] + "' width='60px'>" + v + "</td><td width='60px'>" + v1 + "</td>";
                                            }
                                            xsleng += 1;
                                            cx += 1;
                                        }

                                    }
                                    var xbleng = bid.length - xsleng;
                                    //加载竞争品牌
                                    for (var j = 0; j < xbleng; j++) {
                                        tr += "<td width='80px'>&nbsp;</td>";
                                        for (var i = 0; i < m.length; i++) {
                                            tr += "<td width='60px'>-</td><td width='60px'>-</td>";
                                        }
                                    }
                                    tr += "</tr>";
                                    html += tr;
                                });
                                html += "</tbody>";
                                html += "</table>";
                                $("#main").html("");
                                $("#main").html(html);

                                var counttr = "<tr class='head'><td colspan='6' class='xHLocked'>合计</td>";
                                for (var i = 0; i < m.length; i++) {
                                    var classid = "xcount_xs" + m[i];
                                    var sums = 0;
                                    $("." + classid).each(function () {
                                        if ($(this).html() != "" && $(this).html() != "-") {
                                            sums += Number($(this).html());
                                        }
                                    });
                                    var v = sums == 0 ? "" : sums.toFixed(1);
                                    counttr += "<td>" + v + "&nbsp;</td><td>&nbsp;</td>";
                                }
                                for (var j = 0; j < bid.length; j++) {
                                    counttr += "<td>&nbsp;</td>";
                                    for (var i = 0; i < m.length; i++) {
                                        var classid = "count_" + j + "_xs" + m[i];
                                        var sums = 0;
                                        $("." + classid).each(function () {
                                            if ($(this).html() != "" && $(this).html() != "-") {
                                                sums += Number($(this).html());
                                            }
                                        });
                                        var v = sums == 0 ? "" : sums.toFixed(1);
                                        counttr += "<td>" + v + "&nbsp;</td><td>&nbsp;</td>";
                                    }
                                }
                                counttr += "</tr>";
                                $("#mainTable tbody").append(counttr);
                            }
                        }
                        else {
                            $("#main").html("<div style='width:100%;text-align:center;font-size:13px'>请选择店铺再查询</div>");
                        }
                    } else {
                        $("#main").html("<div style='width:100%;text-align:center;font-size:13px'>没有设置竞争品牌</div>");
                    }
                    //var width = $(document.body).width();
                    //FixTable("mainTable", 1, width - 10, 500);
                },
                error: function (d) {
                    alert("加载数据出错");
                }
            });
        }

        $(function () {
            var height = $(window).height();
            $("#main").height(height-100);
            var year = $("#year").val();
            var bm = $("#begMonth").val();
            var em = $("#endMonth").val();
            LoadData(year, bm, em);
        });

        function Arr(array1, array2, array3) {
            array1 = array1.concat(array2);
            var audit = {};
            for (var i = 0; i < array1.length; i++) {
                if (audit[array1[i].BrandId] != undefined) {
                    if (array1[i].t == "pm") {
                        for (var j = 0; j < array3.length; j++) {
                            audit[array1[i].BrandId]["pm_" + array3[j]] = parseInt(audit[array1[i].BrandId]["pm_" + array3[j]]) + parseInt(array1[i][array3[j] + "月"]);
                        }
                    }
                    if (array1[i].t == "xs") {
                        for (var j = 0; j < array3.length; j++) {
                            audit[array1[i].BrandId]["xs_" + array3[j]] = parseFloat(audit[array1[i].BrandId]["xs_" + array3[j]]) + parseFloat(array1[i][array3[j] + "月"]);
                        }
                    }
                } else {
                    var obj = {};
                    obj["BrandName"] = array1[i]["BrandName"];
                    if (array1[i].t == "pm") {
                        for (var j = 0; j < array3.length; j++) {
                            obj["pm_" + array3[j]] = array1[i][array3[j] + "月"];
                            obj["xs_" + array3[j]] = "0";
                        }
                    }
                    if (array1[i].t == "xs") {
                        for (var j = 0; j < array3.length; j++) {
                            obj["pm_" + array3[j]] = "0";
                            obj["xs_" + array3[j]] = array1[i][array3[j] + "月"];
                        }
                    }
                    audit[array1[i].BrandId] = obj;
                }
            }
            return audit;
        }

        function query() {
            var year = $("#year").val();
            var bm = $("#begMonth").val();
            var em = $("#endMonth").val();
            if (parseInt(bm) > parseInt(em)) {
                alert("开始月份不能大于结束月份!");
                return false;
            }
            LoadData(year, bm, em);
        }

        function selectDpt() {
            showModalDialog("../../branch/public/DepotMultiSelector.aspx?act=powergetdepot", window, "dialogHeight:500px;dialogWidth:760px;center:yes;help:no;resizable:no;status:no;scroll:no");
        }
        function Excel() {
            var year = $("#year").val();
            var bm = $("#begMonth").val();
            var em = $("#endMonth").val();

            window.location = "ajax/Excel.aspx?act=4&year=" + year + "&bm=" + bm + "&em=" + em;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="x-toolbar" >
    <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="查询" CssClass="icon icon-find" Callback="query" />
                 <cc1:ButtonItem ID="btndpt" runat="server" Text="选店" CssClass="icon icon-tick" Callback="selectDpt" />
                 <cc1:ButtonItem ID="btnexcel" runat="server" Text="导出Excel" CssClass="icon icon-export" Callback="Excel" Width="80px" />
            </Buttons>
        </cc1:ToolbarControl>
</div>   
    <div style="margin-top:10px;margin-left:10px">
        年份：<asp:DropDownList runat="server" ID="year"></asp:DropDownList>&nbsp;&nbsp;
        开始月份：<asp:DropDownList runat="server" ID="begMonth"></asp:DropDownList>&nbsp;&nbsp;
        开始月份：<asp:DropDownList runat="server" ID="endMonth"></asp:DropDownList>&nbsp;&nbsp;
    </div>
    <div style="margin-top:10px;margin-left:10px;font-size:13px;font-weight:bold;color:Red">“销售”金额以“万元”单位</div>
    <div id="main" style="width: 100%;" class="divmain">
    </div>
    </form>
</body>
</html>
