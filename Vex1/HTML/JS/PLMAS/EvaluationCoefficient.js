﻿/// JS名：EvaluationCoefficient.js
/// 说明：考勤系数
/// 创建人：郭琦琦 
/// 创建日期：2014-10-14


$(function () {

    m_zt = $.cookie('m_zt');

    var nowDate = new Date();
    var m_Nowyear = nowDate.DateAdd('y', 0).format("yyyy");//当年
    var m_Lastyeay = nowDate.DateAdd('y', -1).format("yyyy");//去年
    var m_Nextyeay = nowDate.DateAdd('y', +1).format("yyyy");//明年

    $('#txtyear').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": m_Nowyear, "text": m_Nowyear, "selected": true }, { "id": m_Lastyeay, "text": m_Lastyeay }, { "id": m_Nextyeay, "text": m_Nextyeay }],
        panelHeight: 'auto',
        editable: false
    })

    var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    $("#txtbrand").val(result.rows[0].message)//把品牌赋值给HTML品牌
    //url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbstky", "cbstky") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
});
//点击查询
function SearchClick() {

    var selectYear = $('#txtyear').combobox("getValue");

    initGird();//加载数据
}

//加载数据
function initGird() {

    ClearGrid("#tabList");//清除表单数据
    var type = $('#txtyear').combobox('getValue');//获取年份

    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetProductSample" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtBomList", "value": "" };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#tabList').datagrid(
        {
            //title: '样衣信息', //表格标题
            url: url,
            //async: false,
            //sortName: 'po1_pocode', //排序字段
            //idField: 'dyyyno', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            //sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            //onClickRow: onClickRow,//单击事件
            //onDblClickRow: onDblClickRow,
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].year == "") {
                    ClearGrid("#tabList");
                }
            },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'measurementsid', title: '类别', width: 80 },
                {
                    field: 'measurementsid', title: '平均人/天', width: 80, editor: { type: 'numberbox', options: { precision: '2', required: false } },
                    formatter: function (value) { if (value == undefined || value == '0.000000') { return ""; } else { return Formater.Account0(value); } }
                },
                {
                    field: 'measurementsid', title: '新板系数', width: 80, editor: { type: 'numberbox', options: { precision: '2', required: false } },
                    formatter: function (value) { if (value == undefined || value == '0.00') { return ""; } else { return Formater.Account(value); } }
                },
                {
                    field: 'measurementsid', title: '调板系数', width: 80, editor: { type: 'numberbox', options: { precision: '2', required: false } },
                    formatter: function (value) { if (value == undefined || value == '0.00') { return ""; } else { return Formater.Account(value); } }
                },
                {
                    field: 'measurementsid', title: '大货系数', width: 80, editor: { type: 'numberbox', options: { precision: '2', required: false } },
                    formatter: function (value) { if (value == undefined || value == '0.00') { return ""; } else { return Formater.Account(value); } }
                }
            ]],
            toolbar: [
          {
              id: 'btnAdd',
              text: '新增',
              iconCls: 'icon-add',
              handler: function () {
                  add();
              }
          },
            {
                id: 'btnEdit',
                text: '修改',
                iconCls: 'icon-edit',
                handler: function () {
                    edit();
                }
            }]
        });
}