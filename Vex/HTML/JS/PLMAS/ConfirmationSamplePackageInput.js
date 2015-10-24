﻿/// JS名：ConfirmationSamplePackageInput.js
/// 说明：确认工艺包录入查询
/// 创建人：郭琦琦 
/// 创建日期：2014-09-03
var m_DDHComboxData = null;//定义订货会季节下拉
var m_username = "";//定义登入名
var data1;
var editIndex;
var m_updateCheck;//更新数据重组check
var m_table1_list;//list
var m_table2_list_YP;//list_YP
var m_table1_list_other;//表头表
var m_plmseason = "";
var BXJ;
var m_zt;
var m_brand = '';
$(function () {
    m_brand = '';
    ClearGrid("#tabPrint");
    m_username = window.m_UserID;
    $('#formSub').find("input[type='checkbox']").attr("checked", false);//默认所有的checkbox全不选
    $('#formSub').find("textarea").val("");//默认所有的input全不选
});

//初始化表格
function initPrintGird() {

    //dccbb750-ca87-4649-964e-ffd237e71586
    var data = new Object();

    data.DYYYNO = $("#txtdyyyno").val();
    data.OrderSeason = $("#txtcmbdhhjj").val();

    if (m_plmseason == "" || m_plmseason == undefined) {
        m_plmseason = arguments[1];
    };
    data.PlmSeason = m_plmseason;
    //data.brand = arguments[2];
    data.user = m_username;
    m_username = m_username;
    data.DIVI = m_zt;
    if (m_brand == '' || m_brand == undefined) {
        m_brand = arguments[2];
    }
    //$('#txtbrand').val(arguments[2]);

    htmlobj = $.ajax({
        url: GetWSRRURL('dccbb750-ca87-4649-964e-ffd237e71586') + "&MultiTable=true",
        data: data,
        type: 'post',
        async: false
    });

    var result = $.parseJSON(htmlobj.responseText);

    if (result[0].rows[0].result == "False") {
        alert(result[0].rows[0].message);
        return;
    }
    var table1 = result[0];//返回的主信息
    var table2 = result[1];//返回的次表信息
    var table3 = result[2];//表头数据
    m_table1_list = table1;
    m_table2_list_YP = table2;
    m_table1_list_other = table3;


    BXJ = m_table1_list_other.rows[0].bxj;

    $('#tabPrint').datagrid(
        {
            data: table1,
            async: false,
            width: '90%', //宽度
            height: $(document).height(), //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: false, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'DESC', //排序类型
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            onClickCell: onClickCell,//单元格操作
            onLoadSuccess: function (data) {
                $.messager.progress('close');

                //var brand = $('#txtbrand').val();
                if (m_brand == "" || m_brand == undefined) {
                    $.messager.alert("提示", "无法获取品牌", "warning");
                    return;
                }
                //var brand = $("#cmbBrand").combobox("getValue");//获取品牌

                $("#dahuohao").val(m_table1_list_other.rows[6].dhh);//大货号
                $('#EPAsampleMachinest').combobox({
                    url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "CBRCID", "CBTX40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtBrand", "value": m_brand }], 'GETZYR'),
                    valueField: 'id',
                    textField: 'text',
                    panelHeight: '120',
                    editable: false,
                    required: false
                });
                $('#tt').tabs('select', '确认样工艺包录入功能与查询');
            },
            columns: [[
                { field: 'key', title: 'key', width: 70, hidden: true },
                { field: 'name', title: 'name', title: '部位名称', width: 100, editor: { type: 'text' } },
                {
                    field: 'samplevaluerequested', title: '样板尺寸', align: 'right', width: 100, editor: { type: 'numberbox', options: { precision: '1', required: false } },
                    formatter: function (value) { if (value * 1 == "0") { return ""; } else { return Formater.Account2(value); } }
                },
                {
                    field: 'samplevalue', title: '成衣要求尺寸', align: 'right', width: 150, editor: { type: 'numberbox', options: { precision: '1', required: false } },
                    formatter: function (value) { if (value * 1 == "0") { return ""; } else { return Formater.Account2(value); } }
                }
            ]],
            toolbar: [
                 {
                     id: 'btn_Save',
                     text: '保存',
                     iconCls: 'icon-save',
                     handler: function () {
                         save();
                     }
                 },
               {
                   id: 'btn_Print',
                   text: '版师打印',
                   iconCls: 'icon-print',
                   handler: function () {
                       btnPrint();
                   }
               },
               {
                   id: 'btn_Print',
                   text: '工艺打印',
                   iconCls: 'icon-print',
                   handler: function () {
                       btnPrint_GY();
                   }
               }
            ]
        });

    formsubCheck(table2);
}

//第一次获取数据之后默认打上勾
function formsubCheck(table2) {
    if (table2.rows[0].materialsusageinformation == "null" && table2.rows[0].samplerequirement1 == "null" && table2.rows[0].samplerequirement2 == "null" && table2.rows[0].samplerequirement3 == "null"
       && table2.rows[0].samplerequirement4 == "null" && table2.rows[0].samplerequirement5 == "null" && table2.rows[0].samplerequirement6 == "null"
        && table2.rows[0].samplestatus == "null" && table2.rows[0].sampleclass == "null") {
        return;
    }
    else {
        var materialsusageinformation = table2.rows[0].materialsusageinformation.replace(/\\n/g, "\n");//面辅料代用信息
        if (materialsusageinformation != "null") {

            $('#MaterialsUsageInformation').val(materialsusageinformation);
        }

        var samplerequirement1 = table2.rows[0].samplerequirement1;//绣花、印花要求

        if (samplerequirement1 != "null") {

            var strsamplerequirement1 = new Array(); //定义一数组 
            strsamplerequirement1 = samplerequirement1.split("|~*~|"); //字符分割 

            //遍历数组
            for (var h = 0; h < strsamplerequirement1.length; h++) {

                var strsamplerequirement1sub = strsamplerequirement1[h];//循环遍历数组,获取数据值
                if (strsamplerequirement1sub != "") {
                    $('#formSub').find($("#" + strsamplerequirement1sub)).attr("checked", "checked");//默认选中
                }

            }

        }


        var sampleclass = table2.rows[0].sampleclass;//款别

        if (sampleclass != "null") {

            var strsampleclass = new Array(); //定义一数组 
            strsampleclass = sampleclass.split("|~*~|"); //字符分割 

            //遍历数组
            for (var h = 0; h < strsampleclass.length; h++) {

                var strsampleclasssub = strsampleclass[h];//循环遍历数组,获取数据值
                if (strsampleclasssub != "") {
                    $('#formSub').find($("#" + strsampleclasssub)).attr("checked", "checked");//默认选中
                }

            }

        }



        var samplerequirement2 = table2.rows[0].samplerequirement2;//推码要求

        if (samplerequirement2 != "null") {

            var strsamplerequirement2 = new Array(); //定义一数组 
            strsamplerequirement2 = samplerequirement2.split("|~*~|"); //字符分割 

            //遍历数组
            for (var h = 0; h < strsamplerequirement2.length; h++) {

                var strsamplerequirement2sub = strsamplerequirement2[h];//循环遍历数组,获取数据值
                if (strsamplerequirement2sub != "") {
                    $('#formSub').find($("#" + strsamplerequirement2sub)).attr("checked", "checked");//默认选中
                }

            }

        }

        var samplerequirement3 = table2.rows[0].samplerequirement3;//排版要求

        if (samplerequirement3 != "null") {

            var strsamplerequirement3 = new Array(); //定义一数组 
            strsamplerequirement3 = samplerequirement3.split("|~*~|"); //字符分割 

            //遍历数组
            for (var h = 0; h < strsamplerequirement3.length; h++) {

                var strsamplerequirement3sub = strsamplerequirement3[h];//循环遍历数组,获取数据值
                if (strsamplerequirement3sub != "") {
                    $('#formSub').find($("#" + strsamplerequirement3sub)).attr("checked", "checked");//默认选中
                }

            }

        }
        var samplerequirement4 = table2.rows[0].samplerequirement4.replace(/\\n/g, "\n");//其他要求

        if (samplerequirement4 != "null") {

            $('#SampleRequirement4').val(samplerequirement4);

        }

        var samplerequirement5 = table2.rows[0].samplerequirement5.replace(/\\n/g, "\n");//技术要求

        if (samplerequirement5 != "null") {

            $('#SampleRequirement5').val(samplerequirement5);

        }


        var samplerequirement6 = table2.rows[0].samplerequirement6;//面料性能信息

        if (samplerequirement6 != "null") {

            var strsamplerequirement6 = new Array(); //定义一数组 
            strsamplerequirement6 = samplerequirement6.split("|~*~|"); //字符分割 

            //遍历数组
            for (var h = 0; h < strsamplerequirement6.length; h++) {

                var strsamplerequirement6sub = strsamplerequirement6[h];//循环遍历数组,获取数据值
                if (strsamplerequirement6sub != "") {
                    $('#formSub').find($("#" + strsamplerequirement6sub)).attr("checked", "checked");//默认选中
                }

            }

        }

        var samplerequirement7 = table2.rows[0].samplerequirement7;//洗涤要求信息

        if (samplerequirement7 != "null") {

            var strsamplerequirement7 = new Array(); //定义一数组 
            strsamplerequirement7 = samplerequirement7.split("|~*~|"); //字符分割 

            //遍历数组
            for (var h = 0; h < strsamplerequirement7.length; h++) {

                var strsamplerequirement7sub = strsamplerequirement7[h];//循环遍历数组,获取数据值
                if (strsamplerequirement7sub != "") {
                    $('#formSub').find($("#" + strsamplerequirement7sub)).attr("checked", "checked");//默认选中
                }

            }

        }

        var EPAsampleMachinest = m_table2_list_YP.rows[0].epasamplemachinest; //样衣师
        if (EPAsampleMachinest != "null") {

            $('#EPAsampleMachinest').combobox('setValue', EPAsampleMachinest);
        }



    }

}


//单元格编辑
function onClickCell(index, field) {
    if (endEditing1(index, field)) {
        var selectedRow = $('#tabPrint').datagrid('selectRow', index).datagrid('getSelected');

        if ($('#tabPrint').datagrid('getRows')[index][field] == "0.0") {
            selectedRow[field] = "";
        };

        $('#tabPrint').datagrid('editCell', { index: index, field: field });
        editIndex = index;
    }
}

function endEditing1() {
    if (editIndex == undefined) { return true };
    if ($('#tabPrint').datagrid('validateRow', editIndex)) {

        updateCell(arguments);

        $('#tabPrint').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}

//保存1
function save() {

    var allRows = $("#tabPrint").datagrid('getRows'); //获取当前所有行的数据
    if (allRows.length == 0) {
        alert("异常!,请先加载数据!")
        return;
    }

    m_updateCheck = [];

    var table = $("#tbSub");
    table.find("td").each(function (index, ele) {
        var td = $(this);
        var hhh = "";
        td.find(':checkbox').each(function () {
            var chk = $(this);
            if (chk.attr('checked') == "checked") {
                //hhh = "";
                hhh += chk[0].id + "|~*~|";
            }
        })
        if (hhh != "") {
            var obj = new Object();
            obj.SampleValue = hhh;
            obj.Key = td[0].id;
            m_updateCheck.push(obj)
        } else {
            var obj = new Object();
            obj.SampleValue = "null";
            obj.Key = td[0].id;
            m_updateCheck.push(obj)
        }
    });

    var obj1 = new Object();
    obj1.SampleValue = $('#MaterialsUsageInformation').val();
    obj1.Key = 'MaterialsUsageInformation';
    m_updateCheck.push(obj1)

    var obj2 = new Object();
    obj2.SampleValue = $('#SampleRequirement4').val();
    obj2.Key = 'SampleRequirement4';
    m_updateCheck.push(obj2)

    var obj3 = new Object();
    obj3.SampleValue = $('#SampleRequirement5').val();
    obj3.Key = 'SampleRequirement5';
    m_updateCheck.push(obj3)

    var obj4 = new Object();
    var EPAsampleMachinest = $('#EPAsampleMachinest').combobox('getText')
    if (EPAsampleMachinest == "") {
        EPAsampleMachinest = "null";
    }
    obj4.SampleValue = EPAsampleMachinest;
    obj4.Key = 'EPAsampleMachinest';
    m_updateCheck.push(obj4)

    m_updateCheck = GetEditJson2(m_updateCheck);

    saveupdate();

}

//保存2
function saveupdate() {

    if (endEditing1()) {
        $dg = $("#tabPrint");

        var updateJSON = [];

        if ($dg.datagrid('getChanges').length) {
            var updatedgetChanges = $dg.datagrid('getChanges', "updated");

            updateJSON = GetEditJson1(updatedgetChanges);

        } else {
            var allRows = $dg.datagrid('getRows'); //获取当前所有行的数据
            //for (var i = 0; i < 1; i++) {
            //    updateJSON.push(allRows[i]);
            //}
            //updateJSON = GetEditJson1(updateJSON);
            updateJSON = GetEditJson1(allRows);
        }

        var data1 = new Object();
        data1.DYYYNO = $("#txtdyyyno").val();
        data1.OrderSeason = $("#txtcmbdhhjj").val();
        data1.user = m_username;
        data1.BXJ = BXJ;
        data1.PlmSeason = m_plmseason;
        var XML = "<ROOT>" + m_updateCheck + updateJSON + "</ROOT>";
        data1.xml = XML;

        data1.DIVI = m_zt;


        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('e9852ce2-7c94-44c6-bb75-f32bb99aef71'),
            type: 'post',
            async: false, //异步,
            data: data1,
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');

                        //$.messager.alert("系统错误", result[0].Error, 'error');
                        $.messager.progress('close');
                    } else if (result[0].Result == "False") {


                        //$.messager.alert("提示", result[0].rows[0].message, 'error');
                        $.messager.progress('close');
                    }
                    else {
                        $.messager.progress('close');
                        initPrintGird();
                        //$.messager.alert("提示", result[0].rows[0].message);
                    }
                } catch (ex) {
                    $.messager.progress('close');

                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
                $.messager.progress('close');
            }
        });
    }
}

//重写easyuiGetEditJson2方法
function GetEditJson3(updatedgetChanges) {
    var updatedData = ''
    updatedData += '<DYYYNO>' + ReplaceSpecialXMLString(updatedgetChanges.DYYYNO) + '</DYYYNO>';
    updatedData += '<OrderSeason>' + ReplaceSpecialXMLString(updatedgetChanges.OrderSeason) + '</OrderSeason>';
    return updatedData;
}

//重写easyuiGetEditJson方法
function GetEditJson1(updatedgetChanges) {
    var updatedData = ''
    if (updatedgetChanges != null && updatedgetChanges.length) {
        updatedData += '<List>'
        for (var i = 0; i < updatedgetChanges.length; i++) {
            updatedData += '<Rows>'

            for (var key in updatedgetChanges[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(updatedgetChanges[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'
        }
        updatedData += "</List>";
    }
    return updatedData;
}


//重写easyuiGetEditJson方法checkBOX
function GetEditJson2(update) {
    var updatedData = ''
    if (update != null && update.length) {
        updatedData += '<LIST_YP>'
        for (var i = 0; i < update.length; i++) {
            updatedData += '<Rows>'

            for (var key in update[i]) {
                if (key) {
                    updatedData += '<' + key + '>' + ReplaceSpecialXMLString(update[i][key]) + '</' + key + '>';
                }
            }
            updatedData += '</Rows>'
        }
        updatedData += "</LIST_YP>";
    }
    return updatedData;
}

//打印
function btnPrint() {

    var allRows = $("#tabPrint").datagrid('getRows'); //获取当前所有行的数据
    if (allRows.length == 0) {
        alert("异常!,请先加载数据!")
        return;
    }
    save();

    //定义头
    var 大货号 = "", 样板号 = "", 上货时间 = "", 系列 = "";
    //定义类型
    var 上装 = "";
    //定义部位名称19个名称
    var 部位0名称 = "", 部位1名称 = "", 部位2名称 = "", 部位3名称 = "", 部位4名称 = "", 部位5名称 = "", 部位6名称 = "", 部位7名称 = "", 部位8名称 = "", 部位9名称 = "",
        部位10名称 = "", 部位11名称 = "", 部位12名称 = "", 部位13名称 = "", 部位14名称 = "", 部位15名称 = "", 部位16名称 = "", 部位17名称 = "", 部位18名称 = "";
    //定义部位名称19个名称值
    var 部位0值 = "", 部位1值 = "", 部位2值 = "", 部位3值 = "", 部位4值 = "", 部位5值 = "", 部位6值 = "", 部位7值 = "", 部位8值 = "", 部位9值 = "",
        部位10值 = "", 部位11值 = "", 部位12值 = "", 部位13值 = "", 部位14值 = "", 部位15值 = "", 部位16值 = "", 部位17值 = "", 部位18值 = "";

    //定义部位名称19个名称值
    var 部位0值1 = "", 部位1值1 = "", 部位2值1 = "", 部位3值1 = "", 部位4值1 = "", 部位5值1 = "", 部位6值1 = "", 部位7值1 = "", 部位8值1 = "", 部位9值1 = "",
        部位10值1 = "", 部位11值1 = "", 部位12值1 = "", 部位13值1 = "", 部位14值1 = "", 部位15值1 = "", 部位16值1 = "", 部位17值1 = "", 部位18值1 = "";


    //定义check是否选中
    var 面辅料代用信息 = "", 其他要求 = "", 绣花印花要求 = "", 排版要求 = "", 推码要求 = "", 款别 = "";
    var 起毛起球 = "", 拔丝排丝 = "", 搭色 = "", 褪色 = "", 缩率大 = "";//面辅料代用信息
    var 裁片 = "", 面料 = "", 成品 = "";//绣花印花要求
    var 倒毛 = "", 顺毛 = "", 定位 = "", 直裁 = "", 横裁 = "", 斜裁 = "", 对花 = "", 对格 = "", 对条 = "";//排版要求
    var 按标准 = "", 其他 = "";//推码要求
    var A = "", B = "", C = "", D = "";//款别

    var 样衣师 = "", 制版师 = "", 设计师 = "";

    m_table1_list_other = eval(m_table1_list_other);
    系列 = m_table1_list_other.rows[1].dyseri;
    上货时间 = m_table1_list_other.rows[2].dyband;
    上装 = m_table1_list_other.rows[3].part;
    样板号 = $("#txtdyyyno").val();
    大货号 = m_table1_list_other.rows[6].dhh;;

    //打印页下面设计师等签字
    制版师 = m_table1_list_other.rows[4].muser;
    设计师 = m_table1_list_other.rows[5].designer;

    var EPAsampleMachinest = m_table2_list_YP.rows[0].epasamplemachinest; //样衣师
    if (EPAsampleMachinest != "null") { 样衣师 = EPAsampleMachinest }

    for (var i = 0; i < m_table1_list.rows.length; i++) {
        eval("部位" + i + "名称" + "=" + "'" + m_table1_list.rows[i].name + "'");
        var samplevalue = m_table1_list.rows[i].samplevalue;
        if (samplevalue * 1 == "0" || samplevalue == "") {
            samplevalue = "";
        }
        else {
            eval("部位" + i + "值" + "=" + "'" + (samplevalue * 1).toFixed(1) + "'");
        }

    };

    for (var i = 0; i < m_table1_list.rows.length; i++) {

        var samplevaluerequested = m_table1_list.rows[i].samplevaluerequested;
        if (samplevaluerequested * 1 == "0" || samplevaluerequested == "") {
            samplevaluerequested = "";
        }
        else {
            eval("部位" + i + "值1" + "=" + "'" + (samplevaluerequested * 1).toFixed(1) + "'");
        }
    };

    var sampleclass = m_table2_list_YP.rows[0].sampleclass;//款别
    if (sampleclass != "null") {
        var strsampleclass = new Array(); //定义一数组 
        strsampleclass = sampleclass.split("|~*~|"); //字符分割 
        if ($.inArray("EPVA", strsampleclass) >= 0) {
            A = "√";
        } if ($.inArray("EPVB", strsampleclass) >= 0) {
            B = "√";
        } if ($.inArray("EPVC", strsampleclass) >= 0) {
            C = "√";
        } if ($.inArray("EPVD", strsampleclass) >= 0) {
            D = "√";
        }
    }

    var materialsusageinformation = m_table2_list_YP.rows[0].materialsusageinformation.replace(/\\n/g, "\n");//面辅料代用信息
    if (materialsusageinformation != "null") { 面辅料代用信息 = materialsusageinformation }

    var samplerequirement6 = m_table2_list_YP.rows[0].samplerequirement6;//面料性能信息
    if (samplerequirement6 != "null") {
        var strsamplerequirement6 = new Array(); //定义一数组 
        strsamplerequirement6 = samplerequirement6.split("|~*~|"); //字符分割 
        if ($.inArray("EPVRequirement6Sub1", strsamplerequirement6) >= 0) {
            起毛起球 = "√";
        } if ($.inArray("EPVRequirement6Sub2", strsamplerequirement6) >= 0) {
            拔丝排丝 = "√";
        } if ($.inArray("EPVRequirement6Sub3", strsamplerequirement6) >= 0) {
            搭色 = "√";
        } if ($.inArray("EPVRequirement6Sub4", strsamplerequirement6) >= 0) {
            褪色 = "√";
        } if ($.inArray("EPVRequirement6Sub5", strsamplerequirement6) >= 0) {
            缩率大 = "√";
        }
    }

    var samplerequirement1 = m_table2_list_YP.rows[0].samplerequirement1;//绣花印花要求
    if (samplerequirement1 != "null") {
        var strsamplerequirement1 = new Array(); //定义一数组 
        strsamplerequirement1 = samplerequirement1.split("|~*~|"); //字符分割 
        if ($.inArray("EPVRequirement1Sub1", strsamplerequirement1) >= 0) {
            裁片 = "√";
        } if ($.inArray("EPVRequirement1Sub2", strsamplerequirement1) >= 0) {
            面料 = "√";
        } if ($.inArray("EPVRequirement1Sub3", strsamplerequirement1) >= 0) {
            成品 = "√";
        }
    }

    var samplerequirement3 = m_table2_list_YP.rows[0].samplerequirement3;//排版要求

    if (samplerequirement3 != "null") {

        var strsamplerequirement3 = new Array(); //定义一数组 
        strsamplerequirement3 = samplerequirement3.split("|~*~|"); //字符分割 

        if ($.inArray("EPVRequirement3Sub1", strsamplerequirement3) >= 0) {
            倒毛 = "√";
        } if ($.inArray("EPVRequirement3Sub2", strsamplerequirement3) >= 0) {
            顺毛 = "√";
        } if ($.inArray("EPVRequirement3Sub3", strsamplerequirement3) >= 0) {
            定位 = "√";
        } if ($.inArray("EPVRequirement3Sub4", strsamplerequirement3) >= 0) {
            对花 = "√";
        } if ($.inArray("EPVRequirement3Sub5", strsamplerequirement3) >= 0) {
            对格 = "√";
        } if ($.inArray("EPVRequirement3Sub6", strsamplerequirement3) >= 0) {
            对条 = "√";
        } if ($.inArray("EPVRequirement3Sub7", strsamplerequirement3) >= 0) {
            直裁 = "√";
        } if ($.inArray("EPVRequirement3Sub8", strsamplerequirement3) >= 0) {
            横裁 = "√";
        } if ($.inArray("EPVRequirement3Sub9", strsamplerequirement3) >= 0) {
            斜裁 = "√";
        }
    }

    var samplerequirement2 = m_table2_list_YP.rows[0].samplerequirement2;//推码要求
    if (samplerequirement2 != "null") {
        var strsamplerequirement2 = new Array(); //定义一数组 
        strsamplerequirement2 = samplerequirement2.split("|~*~|"); //字符分割 
        if ($.inArray("EPVRequirement2Sub1", strsamplerequirement2) >= 0) {
            按标准 = "√";
        } if ($.inArray("EPVRequirement2Sub2", strsamplerequirement2) >= 0) {
            其他 = "√";
        }
    }







    LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");

    LODOP.PRINT_INITA(0, 0, 403, 569, "");
    LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='/image/前.jpg?v=4'>");
    LODOP.SET_SHOW_MODE("BKIMG_WIDTH", 395);
    LODOP.SET_SHOW_MODE("BKIMG_HEIGHT", 567);
    LODOP.SET_SHOW_MODE("BKIMG_PRINT", true);
    LODOP.ADD_PRINT_TEXT(64, 50, 139, 20, 大货号);//大货号
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(89, 50, 140, 20, 样板号);//样板号
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(66, 211, 20, 15, A);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(66, 261, 20, 15, B);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(89, 229, 73, 20, 上货时间);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(89, 342, 54, 20, 系列);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(282, 10, 19, 20, 上装);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(159, 26, 90, 20, 部位0名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(178, 26, 90, 20, 部位1名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(197, 26, 90, 20, 部位2名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(216, 26, 90, 20, 部位3名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(235, 26, 90, 20, 部位4名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(254, 26, 90, 20, 部位5名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(273, 26, 90, 20, 部位6名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(292, 26, 90, 20, 部位7名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(311, 26, 90, 20, 部位8名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(330, 26, 90, 20, 部位9名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(349, 26, 90, 20, 部位10名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(368, 26, 90, 20, 部位11名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(387, 26, 90, 20, 部位12名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(406, 26, 90, 20, 部位13名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(425, 26, 90, 20, 部位14名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(444, 26, 90, 20, 部位15名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(463, 26, 90, 20, 部位16名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(482, 26, 90, 20, 部位17名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(499, 26, 90, 20, 部位18名称);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(150, 222, 128, 79, 面辅料代用信息);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(250, 221, 20, 20, 起毛起球);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(250, 302, 20, 20, 拔丝排丝);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(264, 221, 20, 20, 搭色);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(264, 326, 20, 20, 缩率大);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(264, 276, 20, 20, 褪色);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(308, 276, 20, 20, 面料);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(309, 220, 20, 20, 裁片);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(308, 338, 20, 20, 成品);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(355, 220, 20, 20, 倒毛);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(355, 275, 20, 20, 顺毛);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(355, 337, 20, 20, 定位);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(368, 220, 20, 20, 直裁);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(370, 275, 20, 20, 横裁);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(370, 337, 20, 20, 斜裁);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(385, 221, 20, 20, 对花);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(385, 275, 20, 20, 对格);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(385, 337, 20, 20, 对条);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(433, 221, 20, 20, 按标准);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(433, 276, 20, 20, 其他);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(534, 296, 54, 20, 样衣师);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(534, 53, 54, 20, 制版师);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(534, 184, 54, 20, 设计师);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.ADD_PRINT_TEXT(158, 155, 62, 20, 部位0值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(177, 155, 62, 20, 部位1值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(196, 155, 62, 20, 部位2值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(215, 155, 62, 20, 部位3值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(234, 155, 62, 20, 部位4值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(253, 155, 62, 20, 部位5值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(272, 155, 62, 20, 部位6值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(291, 155, 62, 20, 部位7值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(310, 155, 62, 20, 部位8值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(329, 155, 62, 20, 部位9值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(348, 155, 62, 20, 部位10值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(367, 155, 62, 20, 部位11值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(386, 155, 62, 20, 部位12值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(405, 155, 62, 20, 部位13值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(424, 155, 62, 20, 部位14值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(443, 155, 62, 20, 部位15值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(462, 155, 62, 20, 部位16值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(481, 155, 62, 20, 部位17值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(499, 155, 62, 20, 部位18值);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);

    LODOP.ADD_PRINT_TEXT(159, 95, 62, 20, 部位0值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(178, 95, 62, 20, 部位1值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(197, 95, 62, 20, 部位2值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(216, 95, 62, 20, 部位3值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(235, 95, 62, 20, 部位4值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(254, 95, 62, 20, 部位5值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(273, 95, 62, 20, 部位6值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(292, 95, 62, 20, 部位7值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(311, 95, 62, 20, 部位8值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(330, 95, 62, 20, 部位9值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(349, 95, 62, 20, 部位10值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(368, 95, 62, 20, 部位11值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(387, 95, 62, 20, 部位12值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(406, 95, 62, 20, 部位13值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(425, 95, 62, 20, 部位14值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(444, 95, 62, 20, 部位15值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(463, 95, 62, 20, 部位16值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(482, 95, 62, 20, 部位17值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.ADD_PRINT_TEXT(499, 95, 62, 20, 部位18值1);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 8);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);


    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.ADD_PRINT_TEXT(66, 362, 20, 15, D);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.ADD_PRINT_TEXT(66, 310, 20, 15, C);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);
    LODOP.SET_PRINT_PAGESIZE(0, 1100, 1600, "plmads");//自定义纸张大小
    LODOP.PREVIEW();    //浏览模式
    //LODOP.PRINT_DESIGN();//设计模式
};

//工艺师打印
function btnPrint_GY() {

    var allRows = $("#tabPrint").datagrid('getRows'); //获取当前所有行的数据
    if (allRows.length == 0) {
        alert("异常!,请先加载数据!")
        return;
    }
    save();
    var 技术要求 = "";
    var 水洗 = "", 干洗 = "", 机洗 = "", 手洗 = "";

    var samplerequirement5 = m_table2_list_YP.rows[0].samplerequirement5.replace(/\\n/g, "\n");//技术要求

    if (samplerequirement5 != "null") { 技术要求 = samplerequirement5; }

    var 其他要求 = "";

    var samplerequirement4 = m_table2_list_YP.rows[0].samplerequirement4.replace(/\\n/g, "\n");//其他要求
    if (samplerequirement4 != "null") { 其他要求 = samplerequirement4; }

    var samplerequirement7 = m_table2_list_YP.rows[0].samplerequirement7.replace(/\\n/g, "\n");//洗涤要求信息
    if (samplerequirement7 != "null") {
        var strsamplerequirement7 = new Array(); //定义一数组 
        strsamplerequirement7 = samplerequirement7.split("|~*~|"); //字符分割 
        if ($.inArray("EPVWaterScrubbing", strsamplerequirement7) >= 0) {
            水洗 = "√";
        } if ($.inArray("EPVDryCleaning", strsamplerequirement7) >= 0) {
            干洗 = "√";
        } if ($.inArray("EPVHandWash", strsamplerequirement7) >= 0) {
            手洗 = "√";
        } if ($.inArray("EPVMachineWash", strsamplerequirement7) >= 0) {
            机洗 = "√";
        }
    }


    LODOP = "";
    LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");


    LODOP.PRINT_INITA(0, 0, 403, 569, "");
    LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='/image/背.jpg'>");
    LODOP.SET_SHOW_MODE("BKIMG_WIDTH", 386);
    LODOP.SET_SHOW_MODE("BKIMG_HEIGHT", 567);
    LODOP.SET_SHOW_MODE("BKIMG_PRINT", true);
    LODOP.ADD_PRINT_TEXT(78, 63, 23, 20, 水洗);
    LODOP.ADD_PRINT_TEXT(78, 107, 23, 20, 干洗);
    LODOP.ADD_PRINT_TEXT(78, 154, 23, 20, 手洗);
    LODOP.ADD_PRINT_TEXT(78, 199, 23, 20, 机洗);
    LODOP.ADD_PRINT_TEXT(156, 8, 322, 245, 技术要求);
    LODOP.ADD_PRINT_TEXT(128, 258, 23, 20, "");
    LODOP.ADD_PRINT_TEXT(128, 304, 23, 20, "");
    LODOP.ADD_PRINT_TEXT(103, 63, 265, 23, 其他要求);
    LODOP.SET_PRINT_PAGESIZE(0, 1100, 1600, "plmads");//自定义纸张大小
    LODOP.PREVIEW();    //浏览模式
    //LODOP.PRINT_DESIGN();//设计模式
}

function updateCell(cell) {
    var index = cell[0],
        cellType = typeof index;
    if (cellType == "number") {
        var cellObj = $("#tabPrint").datagrid("getSelected"),
            cellVal = cellObj[cell[1]];
        if (cellVal == "") {
            cellObj[cell[1]] = 0.0;
        };
    };
}