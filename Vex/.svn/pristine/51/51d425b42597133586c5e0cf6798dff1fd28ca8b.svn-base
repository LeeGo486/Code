///盘亏索赔跟踪表
///创建人:俞佳伟
///创建时间:2015-01-31

$(function () {
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    if (month < 10) {
        month = '0' + month;
    }
    if (day < 10) {
        day = '0' + day;
    }
    var curDate = year + '-' + month + '-' + '01'; //当前月的第一天
    var endDate = year + '-' + month + '-' + day;  //当前月的当天
    $('#dateCheckB').datebox('setText', curDate);
    $('#dateCheckE').datebox('setText', endDate);
    var data = [];
    data[data.length] = { "name": "txtbegindate", "value": curDate };
    data[data.length] = { "name": "txtenddate", "value": endDate };
    var url = GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588') + "&XML=" + GetFormJson(data, 'GETLOSSTABLE');
    InitGrid(url);
});

//加载盘亏索赔表数据
function InitGrid(url) {
    $('#tabList').datagrid({
        title: '盘亏索赔表',
        url: url,
        fit: true,
        striped: true, //True 奇偶行使用不同背景色
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        columns: [[
            { field: 'inventoryid', title: '盘点单据号', width: 165, search: true, sortable: true },
            { field: 'areaname', title: '所属大区', width: 70, search: true },
            { field: 'd_dd', title: '督导姓名', width: 65, search: true },
            { field: 'depotid', title: '店铺编号', width: 80, search: true },
            { field: 'depotname', title: '店铺名称', width: 110, search: true },
            { field: 'nums', title: '盘亏数量', width: 65, search: true, sortable: true },
            { field: 'sums', title: '盘亏金额', width: 80, search: true, sortable: true },
            { field: 'return_sums', title: '申请赔偿金额', width: 80, search: true, sortable: true },
            { field: 'setdate', title: '盘点日期', width: 80, search: true, sortable: true },
            { field: 'sure_date', title: '登帐时间', width: 130, search: true, sortable: true },
            { field: 'state', title: '当前状态', width: 80, search: true },
            { field: 'createtime', title: '提交时间', width: 130, search: true, sortable: true }
        ]]
    });
}

//查询 事件
function btnSearch() {
    var dateB = $('#dateCheckB').datebox('getText');
    var dateE = $('#dateCheckE').datebox('getText');
    var ckWhere = '1=1';
    var ckValue = [];
    $("input[name='ckState']:checked").each(function () {
        ckValue[ckValue.length] = $(this).val();
    });
    if (ckValue.length > 0) {
        ckWhere += " and State in('" + ckValue[0] + "'";
        for (var i = 1; i < ckValue.length; i++) {
            ckWhere += ",'" + ckValue[i] + "'";
        }
        ckWhere += ")";
    }
    var data = [];
    data[data.length] = { "name": "txtbegindate", "value": dateB };
    data[data.length] = { "name": "txtenddate", "value": dateE };
    //if (dateB != "") {
    //    ckWhere += " and setDate>='" + dateB + "'";
    //}
    //if (dateE != "") {
    //    ckWhere += " and setDate<='" + dateE + "'";
    //}
    var url = GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588') + "&XML=" + GetFormJson(data, 'GETLOSSTABLE') + "&Where=" + escape(ckWhere);
    InitGrid(url);
}

//日期格式转化
function dateFormat(date) {
    var yy = date.getFullYear();
    var mm = date.getMonth() + 1;
    var dd = date.getDate();
    if (mm < 10) {
        mm = '0' + mm;
    }
    if (dd < 10) {
        dd = '0' + dd;
    }
    return yy + '-' + mm + '-' + dd;
}