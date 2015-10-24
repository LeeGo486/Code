// 名称：Analyse3.js
// 创建人：郭琦琦
// 创建日期：2014-07-04
// 修改人：
// 修改日期：
// 修改内容：

var m_UserId;//登入名
var 角色ID;//角色ID
var authorization_name;//权限名称
var m_DepotId;//店铺编号
var jsid;//角色ID
$(function () {
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });

    //获取用户ID
    htmlobj = $.ajax({
        url: GetWSRRURL('LoginName'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.UserName != "") {
        m_UserId = result.UserName;
    };

    //获取店铺ID
    htmlobj = $.ajax({
        url: GetWSRRURL('DepotID'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.DepotID != "") {
        m_DepotId = result.DepotID;
    }

    var xmlData = GetFormJson("", 'CheckAuzbyuserid');
    htmlobj = $.ajax({
        url: GetWSRRURL('c3a37422-92d0-4c1d-b59e-850bb07a3304'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
     authorization_name = result.rows[0]['authorization_name'];
    //m_DepotId = "P0018007";
    //角色ID = "5269";
    if (m_DepotId == "" || m_DepotId == undefined) {

        //authorization_name = "澳门";

        auzkz(authorization_name);//权限转化//雅莹总部华南西南郑州泓雅新疆雅斓华中维姬澳门
    }
    else {
        authorization_name = "店铺";
        角色ID = m_DepotId;
    }

    //initGird();//加载数据
});
//查询
function btnSearch() {
    initGird()
}

function initGird() {

    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": authorization_name };
    data[data.length] = { "name": "txt类型", "value": "汇总" };
    data[data.length] = { "name": "txt角色ID", "value": 角色ID };
    data[data.length] = { "name": "txt发展日期1", "value": $('#txtBeginDate').datebox('getValue') };
    data[data.length] = { "name": "txt发展日期2", "value": $('#txtend').datebox('getValue') };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('32ac2b8e-528a-419e-b1cc-89371f2e884a') + xmlData
    $('#Analyse3_List').datagrid(
        {
            url: url,
            async: false,
            //sortName: 'po1_pocode', //排序字段
            //idField: 'dyyyno', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            //sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号,
            onClickCell: onClickCell,
            columns: [[
                { field: 'companyname', title: '分公司', width: 100, rowspan: 2 },
                { field: 'deptname', title: '店铺名称', width: 150, rowspan: 2 },
                { title: '3天售后回访', colspan: 2 },
                { title: '15天穿着了解', colspan: 2 },
                { title: '40天新款上市沟通', colspan: 2 },
                { title: '90天礼券过期提醒', colspan: 2 }
            ], [
                { field: 'yes3', title: '完成人数', width: 80 },
                { field: 'no3', title: '未完成人数', width: 80 },
                { field: 'yes15', title: '完成人数', width: 80 },
                { field: 'no15', title: '未完成人数', width: 80 },
                { field: 'yes50', title: '完成人数', width: 80 },
                { field: 'no50', title: '未完成人数', width: 80 },
                { field: 'yes90', title: '完成人数', width: 80 },
                { field: 'no90', title: '未完成人数', width: 80 }
            ]],
            onLoadSuccess: function (data) {
                //if (data.rows == null || data.rows.length == 0) {
                //    data.total = 0;
                //}
                //else {
                //    data.total = data.rows[0].count_num;
                //}
                if (data.rows.length == 1 && data.rows[0].companyname == "") {
                    ClearGrid("#Analyse3_List");
                }
            }
        });
}

//权限转化
function auzkz(name) {
    if (authorization_name == "总部") {
        角色ID = "ALL";
    } else if (authorization_name == "华南") {
        角色ID = "华南";
        authorization_name = "分公司";
    } else if (authorization_name == "西南") {
        角色ID = "西南";
        authorization_name = "分公司";
    } else if (authorization_name == "郑州") {
        角色ID = "郑州";
        authorization_name = "分公司";
    } else if (authorization_name == "泓雅") {
        角色ID = "泓雅";
        authorization_name = "分公司";
    } else if (authorization_name == "新疆") {
        角色ID = "新疆";
        authorization_name = "分公司";
    } else if (authorization_name == "华中") {
        角色ID = "华中";
        authorization_name = "分公司";
    } else if (authorization_name == "维姬") {
        角色ID = "维姬";
        authorization_name = "分公司";
    } else if (authorization_name == "澳门") {
        角色ID = "澳门";
        authorization_name = "分公司";
    }
    else if (authorization_name == "督导") {
        角色ID = m_UserId;
    }
}




//单元歌数据抽取
function onClickCell(index, field) {
    if (field == "deptname" || field == "companyname") {
        return;
    }
    var selectedRow = $('#Analyse3_List').datagrid('selectRow', index).datagrid('getSelected')
    //yes3 3 no3 4 yes15 5 no15 6  yes50 7 no50 8   yes90 9yes90 10
    var dq = selectedRow.companyname;//大区
    var deptname = selectedRow.deptname;//大区
    authorization_name //实体

    jsid = 角色ID //角色ID
    var newtype;//新客户类型
    var isorno;//是否完成

    if (field == "yes3" || field == "no3") {
        newtype = "T000007";
    } else if (field == "yes15" || field == "no15") {
        newtype = "T000008";
    } else if (field == "yes50" || field == "no50") {
        newtype = "T000010";
    }
    else if (field == "yes90" || field == "no90") {
        newtype = "T000010";
    }

    if (field.substr(0, 2) == "ye") {
        isorno = "是";
    }
    else {
        isorno = "否"
    }

    window.open("Analyse4.HTML?&isorno=" + isorno +
                                "&newtype=" + newtype +
                                "&authorization_name=" + authorization_name +
                                "&jsid=" + jsid +
                                "&deptname=" + deptname +
                                 "&time1=" + $('#txtBeginDate').datebox('getValue') +
                                  "&time2=" + $('#txtend').datebox('getValue') +
                                "&dq=" + dq + "", target = '_blank');
}

//3天售后回访对应T000007；15天穿着了解对应T000008；40天新款上市沟通对应T000010；90天礼券过期提醒对应T000010
//<Interface WSID="32ac2b8e-528a-419e-b1cc-89371f2e884a"  App="CMT"  SessionID="">
//<InputFormat>AML</InputFormat>
//<OutputContentType>RS</OutputContentType>
//<ConditionStr>操作类型,GET】【实体,总部】【类型,明细】【角色ID,ALL】
//【分公司,西北区】【店铺名称,西安世纪金花赛高店】【新客户类型,T000007】【是否完成,是】【发展日期1,2014-01-01】【发展日期2,2014-09-30】
//</ConditionStr> 
//</Interface>
