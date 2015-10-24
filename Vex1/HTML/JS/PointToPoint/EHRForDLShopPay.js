/// JS名：EHRForDLShopPay.js
/// 说明：贝爱店铺薪资报表
/// 创建人：郭琦琦 
/// 创建日期：2014-09-17
var m_columns = ""//表头
var m_Nowyear = ""//今年
var m_Lastyeay = ""//去年
var totalPage = "";//页码总数
var name = "";//登入名
//初始化
$(function () {
    //name =  Cookies.get("hzyapp.username");
    name = "周留娟";
    ////$('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });//初始化查询按钮
    //$('#btnALL').linkbutton({ iconCls: 'icon-search', plain: true });//初始化查询按钮
    //$('#btnPart').linkbutton({ iconCls: 'icon-search', plain: true });//初始化查询按钮

    var nowDate = new Date();
    var m_Nowyear = nowDate.DateAdd('y', 0).format("yyyy");//当年
    var m_Lastyeay = nowDate.DateAdd('y', -1).format("yyyy");//当年


    $('#txtpage').val("0");//初始化
    $('#txttotal').val("0");//初始化

    var selyearObj = $("#txtyear");
    selyearObj.append("<option >" + m_Lastyeay + "</option>");
    selyearObj.append("<option selected>" + m_Nowyear + "</option>");

    var value = new Array("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12");
    var text = new Array( "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月")
    var selmonthObj = $("#txtmonth");
    for (var i = 0; i < 12; i++) {
        selmonthObj.append("<option value='" + value[i] + "'>" + text[i] + "</option>");
    }

    var m_lastmonth = nowDate.DateAdd('m', -1).format("MM");
    //alert(m_lastmonth);
    //document.getElementByid('txtmonth').value = "2月";
    $("#txtmonth").val(m_lastmonth);

    ////初始化加载薪资报表表头
    //var htmlobj = $.ajax({
    //    url: GetGridColumnsWSRRURL('52d6f751-70af-42a1-be75-2216513911de', "80", "true", "false"),
    //    //url: GetGridColumnsWSRRURL('52d6f751-70af-42a1-be75-2216513911de'),
    //    data: "XML=" + GetFormJson([], 'GetEHRForDLShopPay'), async: false
    //});
    //var Text = $.parseJSON(htmlobj.responseText);
    //m_columns = Text.Col;
    btnSearch();
});

//查询
function btnSearch() {
    $('#txtpage').val("1");//初始化1
    ClearGrid("#list");
    //传参数到后台
    var data = [];
    data[data.length] = { "name": "txtyear", "value": $("#txtyear").val() };
    data[data.length] = { "name": "txtmonth", "value": $("#txtmonth").val() };
    data[data.length] = { "name": "txtname", "value": name };
    
    //encodeURIComponent
    var urlGetEHRForDLShopPay = GetWSRRURL('52d6f751-70af-42a1-be75-2216513911de') + "&XML=" + escape(GetFormJson(data, 'GetEHRForDLShopPay'));
    initGridGetEHRForDLShopPay(urlGetEHRForDLShopPay);
};

//加载数据
function initGridGetEHRForDLShopPay(url) {
    $('#list').datagrid(
            {
                //url: urlPacking('get', url),
                url:url,
                //columns: eval(m_columns),
                //idField: 'c_code', //标识字段,主键
                width: '90%', //宽度
                height: $(document).height() - 20, //高度
                nowrap: false, //是否换行，True 就会把数据显示在一行里
                remoteSort: true, //定义是否从服务器给数据排序
                collapsible: false, //可折叠
                sortOrder: 'DESC', //排序类型
                sortable: false,
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                fit: true,
                //pagination: true, //是否开启分页
                //pageSize: 20, //默认一页数据条数
                //exportExcel: false,
                frozenColumns: [[
                  {
                      field: '部门', title: '部门', align: 'center', width: 150, sortable: true,
                      styler: function (value, row, index) {
                          return 'background-color:#DFEDF6;color:#000000:';
                      }
                  },
                  {
                      field: '员工号', title: '员工号', align: 'center', width: 60, sortable: true,
                      styler: function (value, row, index) {
                          return 'background-color:#DFEDF6;color:#000000:';
                      }
                  },
                  {
                      field: '姓名', title: '姓名', align: 'center', width: 50, sortable: true,
                      styler: function (value, row, index) {
                          return 'background-color:#DFEDF6;color:#000000:';
                      }
                  },
                  {
                      field: '岗位', title: '岗位', align: 'center', width: 60, sortable: true,
                      styler: function (value, row, index) {
                          return 'background-color:#DFEDF6;color:#000000:';
                      }
                  }
                ]],
                columns: [[
                { field: '应发合计', title: '应发合计', width: 80, sortable: true, align: "right" },
                { field: '代扣养老金', title: '代扣养老金', width: 80, sortable: true, align: "right" },
                { field: '代扣失业金', title: '代扣失业金', width: 80, sortable: true, align: "right" },
                { field: '代扣基本医疗', title: '代扣基本医疗', width: 100, sortable: true, align: "right" },
                { field: '代扣住房公积金', title: '代扣住房公积金', width: 120, sortable: true, align: "right" },
                { field: '代扣个税', title: '代扣个税', width: 80, sortable: true, align: "right" },
                { field: '补充社保', title: '补充社保', width: 80, sortable: true, align: "right" },
                { field: '互助金', title: '互助金', width: 80, sortable: true, align: "right" },
                { field: '激励报销', title: '激励报销', width: 80, sortable: true, align: "right" },
                { field: '其他扣款', title: '其他扣款', width: 80, sortable: true, align: "right" },
                { field: '实发合计', title: '实发合计', width: 80, sortable: true, align: "right" },
                { field: '应出勤天数', title: '应出勤天数', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '出勤天数', title: '出勤天数', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '月基薪', title: '月基薪', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '实际月基薪', title: '实际月基薪', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '福利补贴', title: '福利补贴', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '固定加班', title: '固定加班', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '高销突破工资', title: '高销突破工资', width: 100, sortable: true, hidden: true, align: "right" },
                { field: '销售目标', title: '销售目标', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '实际销售额', title: '实际销售额', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '销售完成比率', title: '销售完成比率', width: 100, sortable: true, hidden: true, align: "right" },
                { field: '标准提成点', title: '标准提成点', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '个人提成系数', title: '个人提成系数', width: 100, sortable: true, hidden: true, align: "right" },
                { field: '个人销售提成', title: '个人销售提成', width: 100, sortable: true, hidden: true, align: "right" },
                { field: '高单奖', title: '高单奖', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '超时加班工资', title: '超时加班工资', width: 100, sortable: true, hidden: true, align: "right" },
                { field: '节日福利', title: '节日福利', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '特殊补贴', title: '特殊补贴', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '学历补贴', title: '学历补贴', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '其他', title: '其他', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '年限', title: '年限', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '年限工资', title: '年限工资', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '个人激励', title: '个人激励', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '养老保险', title: '养老保险', width: 80, sortable: true, hidden: true, align: "right" },
                { field: '其他说明', title: '其他说明', width: 160, sortable: true, hidden: true, align: "left" }
                ]],
                onLoadSuccess: function (data) {
                    totalPage = data.total;
                    if (parseInt(totalPage / 20) == "0" || parseInt(totalPage / 15) == "1") {
                        totalPage = "1";
                    } else {
                        totalPage = parseInt(totalPage / 15);
                    }
                    $('#txttotal').val(totalPage);
                },
                rowStyler: function (index, row) {
                    return 'background-color:#f4f8fa;';
                }
            });
};

//上一页
function lastpage() {

    var nextpage = $('#txtpage').val();
    if (nextpage == "" || nextpage == "1" || nextpage == "0") {
        alert("已经是第一页");
        return;
    }
    nextpage = nextpage * 1 - 1;
    //+ "&page=" + nextpage + "&pagerows=15" + 
    var data1 = new Object();
    data1.page = nextpage;
    data1.pagerows = "15";
    var data = [];
    data[data.length] = { "name": "txtyear", "value": $("#txtyear").val() };
    data[data.length] = { "name": "txtmonth", "value": $("#txtmonth").val() };
    data[data.length] = { "name": "txtname", "value": name };
    //encodeURIComponent
    var lastpagedata = $.ajax({
        url: GetWSRRURL('52d6f751-70af-42a1-be75-2216513911de') + "&XML=" + GetFormJson(data, 'GetEHRForDLShopPay'),
        data: data1,
        type: 'post',
        async: false
    });


    var result = $.parseJSON(lastpagedata.responseText);
    $('#list').datagrid("loadData", result);//重加载限定数据s
    $('#txtpage').val(nextpage);//把最新减一的值给页码

};

//下一页
function nextpage() {

    var nextpage = $('#txtpage').val();
    if (nextpage == "0" || nextpage == "") {
        alert("请先加载数据");
        return;
    }

    nextpage = nextpage * 1 + 1;

    if (nextpage * 1 > totalPage) {
        alert("已经是最后一页");
        return;
    }
    //+ "&page=" + nextpage + "&pagerows=15" + 
    var data1 = new Object();
    data1.page = nextpage;
    data1.pagerows = "15";
    var data = [];
    data[data.length] = { "name": "txtyear", "value": $("#txtyear").val() };
    data[data.length] = { "name": "txtmonth", "value": $("#txtmonth").val() };
    data[data.length] = { "name": "txtname", "value": name };

    var nextpagedata = $.ajax({
        url: GetWSRRURL('52d6f751-70af-42a1-be75-2216513911de') + "&XML=" + GetFormJson(data, 'GetEHRForDLShopPay'),
        data: data1,
        type: 'post',
        async: false

    });

    var result = $.parseJSON(nextpagedata.responseText);
    $('#list').datagrid("loadData", result);//重加载限定数据s
    $('#txtpage').val(nextpage);//把最新减一的值给页码
};
//首页
function firstpage() {

    var data1 = new Object();
    data1.page = "1";
    data1.pagerows = "15";
    //encodeURIComponent
    var data = [];
    data[data.length] = { "name": "txtyear", "value": $("#txtyear").val() };
    data[data.length] = { "name": "txtmonth", "value": $("#txtmonth").val() };
    data[data.length] = { "name": "txtname", "value": name };

    //+ "&page=" + nextpage + "&pagerows=15" + 
    var firstpagedata = $.ajax({
        url: GetWSRRURL('52d6f751-70af-42a1-be75-2216513911de') + "&XML=" + GetFormJson(data, 'GetEHRForDLShopPay'),
        data: data1,
        type: 'post',
        async: false
    });

    var result = $.parseJSON(firstpagedata.responseText);
    $('#list').datagrid("loadData", result);//重加载限定数据s
    $('#txtpage').val("1");//把最新减一的值给页码

};


//显示所有数据
function btnaLL() {
    //var allData = $('#list').datagrid('getData');
    var col = $('#list').datagrid('getColumnOption', '出勤天数');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '应出勤天数');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '月基薪');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '实际月基薪');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '福利补贴');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '固定加班');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '高销突破工资');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '销售目标');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '实际销售额');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '销售完成比率');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '标准提成点');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '个人提成系数');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '个人销售提成');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '高单奖');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '超时加班工资');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '节日福利');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '特殊补贴');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '学历补贴');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '其他');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '其他说明');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '年限');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '年限工资');
    col.hidden = false;

    var col = $('#list').datagrid('getColumnOption', '个人激励');
    col.hidden = false;
    var col = $('#list').datagrid('getColumnOption', '养老保险');
    col.hidden = false;

    $('#list').datagrid();

};

//显示部分数据
function btnPart() {

    var col = $('#list').datagrid('getColumnOption', '出勤天数');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '应出勤天数');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '月基薪');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '实际月基薪');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '福利补贴');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '固定加班');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '高销突破工资');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '销售目标');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '实际销售额');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '销售完成比率');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '标准提成点');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '个人提成系数');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '个人销售提成');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '高单奖');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '超时加班工资');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '节日福利');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '特殊补贴');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '学历补贴');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '其他');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '其他说明');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '年限');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '年限工资');
    col.hidden = true;

    var col = $('#list').datagrid('getColumnOption', '个人激励');
    col.hidden = true;
    var col = $('#list').datagrid('getColumnOption', '养老保险');
    col.hidden = true;
    $('#list').datagrid();



};