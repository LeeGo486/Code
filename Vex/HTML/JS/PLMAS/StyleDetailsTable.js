/// 设计目标与款式明细对照表
/// StyleDetailsTable.js
/// 创建人：俞佳伟
/// 创建时间：2015-08-18


var m_Username = '';
var m_zt = '';

//初始化
$(function () {
    m_Username = window.m_UserID;//取登入姓名
    m_zt = $.cookie('m_zt');

    $('#txtSeason').combobox();
    //产品线下拉数据加载
    $('#txtProductLine').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrandProductLine'),
        valueField: 'id',
        textField: 'text',
        async: false,
        editable: false,
        onSelect: function (productLine) {
            //季节下拉数据加载
            $('#txtSeason').combobox({
                url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetFlexPLMSeason') + "&Where=CBSTKY='" + escape(productLine.id) + "'",
                valueField: 'id',
                textField: 'text',
                panelHeight: 'auto',
                editable: false
            });

        }
    });
    InitGridList();
});


//主页查询按钮事件
function btnSearch() {
    var txtProductLine = $('#txtProductLine').combobox('getValue');
    var txtSeason = $('#txtSeason').combobox('getValue');

    if (txtProductLine == '' || txtProductLine == undefined) {
        $.messager.alert('提示', '产品线不能为空', 'warning');
        return;
    }
    if (txtSeason == '' || txtSeason == undefined) {
        $.messager.alert('提示', '季节不能为空', 'warning');
        return;
    }
    var url = GetTreeWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetProductPlanDataForTree')
        + "&Where=Brand='" + escape(txtProductLine) + "' AND Season='" + escape(txtSeason) + "' AND RIGHT(BoDuan,4) NOT IN ('1201','0601') ";

    $('#ProductPlanTree').tree({
        checkbox: false,
        url: url,
        onClick: function (node) {
            //$(this).tree('toggle', node.target);//单击的时候打开树  
            var urlForDataGrid = GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetProductPlan')
                + "&Where=Brand='" + escape($('#txtProductLine').combobox('getValue')) + "' AND Season='" + escape($('#txtSeason').combobox('getValue')) + "'";
            var father = $(this).tree('getParent', node.target);
            if (father != null) {
                if (father.id == "波段") {
                    urlForDataGrid += " AND BoDuan='" + node.id + "'";
                }
                else {

                    var grandfather = $(this).tree('getParent', father.target);
                    if (grandfather != null) {
                        if (grandfather.id == "波段") {
                            urlForDataGrid += " AND BoDuan='" + father.id + "' AND StyleSeries='" + escape(node.id) + "'";
                        }
                        else {
                            urlForDataGrid += " AND BoDuan='" + grandfather.id + "' AND StyleSeries='" + escape(father.id) + "' AND Category='" + escape(node.id) + "'";
                        }
                    }
                }
            }

            InitGridList(urlForDataGrid);
        },
        //onContextMenu: function (e, node) { },
        onLoadSuccess: function (node, data) {
            if (data[0].children == undefined) {
                $.messager.alert('提示', '无数据', 'warning');
                return;
            }
            $('#ProductPlanTree').tree('collapseAll');
            if (data.Error != null) {
                $.messager.alert("提示", data.error, 'error');
            }
            //else {
            //    $('#ProductPlanTree').tree('collapseAll');
            //}
        },
        onLoadError: function (arguments) {
            alert(arguments);
        }
    });
}

//主页数据列表加载
function InitGridList() {

    //声明列表显示格式
    //var cardview = $.extend({}, $.fn.datagrid.defaults.view, {
    //    renderRow: function (target, fields, frozen, rowIndex, rowData) {
    //        var cc = [];
    //        cc.push('<td colspan=' + fields.length + ' style="padding:10px 5px;border:0;">');
    //        if (!frozen && rowData.itemid) {
    //            var aa = rowData.itemid.split('-');
    //            var img = 'shirt' + aa[1] + '.gif';
    //            cc.push('<img src="images/' + img + '" style="width:150px;float:left">');
    //            cc.push('<div style="float:left;margin-left:20px;">');
    //            for (var i = 0; i < fields.length; i++) {
    //                var copts = $(target).datagrid('getColumnOption', fields[i]);
    //                cc.push('<p><span class="c-label">' + copts.title + ':</span> ' + rowData[fields[i]] + '</p>');
    //            }
    //            cc.push('</div>');
    //        }
    //        cc.push('</td>');
    //        return cc.join('');
    //    }
    //});

    ClearGrid("#ProductPlanList");
    $('#ProductPlanList').datagrid({
        url: GetWSRRURL('6e647c56-cd98-4eb9-ae95-0021cc435801') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtuser", "value": m_Username }], 'GetStyleDetailTable'),
        //view: cardview,
        //fitColumns: true,
        singleSelect: true,
        //onDblClickRow: onDblClickRow,
        rownumbers: true,
        pagination: true,
        fit: true,
        columns: [[
            { field: 'placeholderid', title: '占位符' },
            { field: 'displaysubcategory', title: 'skc要求' },
            { field: 'costmultiplyingpower', title: '成本倍率' },
            { field: 'targetcost', title: '目标成本' },
            { field: 'planedretailedprice', title: '计划吊牌价' },
            { field: 'planedfabriccost', title: '计划面料成本' },
            {
                field: 'designimagebig', title: '大图', formatter: function (value, row, index) {
                    //return "<img  src='" + value + "' style='height:70px' border='0'/>"
                }
            },
            {
                field: 'designimagesmall', title: '小图', formatter: function (value, row, index) {
                    return "<img  src='" + value + "' style='height:70px' border='0'/>"
                }
            },
            { field: 'samplenum', title: '样衣号' }
        ]],
        onLoadSuccess: function (data) {
            if (data.length == 1 && data[0].placeholderid == "") {
                ClearGrid("#ProductPlanList");
            }
        }
    });
}



