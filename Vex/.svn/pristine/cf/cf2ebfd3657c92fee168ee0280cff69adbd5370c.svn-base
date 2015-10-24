/// JS名：ContractInfo.js
/// 说明：合同管理
/// 创建人：郭琦琦 
/// 创建日期：2014-11-01

var m_Firstdate = "";//年初
var m_Enddate = "";//明年年初
var m_SelectRow = undefined;//主表选中的行
//var m_SelectRowDetail = undefined;//子表选中行
var m_ConDetail = "";
var m_cond_feeperiod = [{ "id": "每月", "text": "每月" }, { "id": "每年", "text": "每年" }, { "id": "每季", "text": "每季" }, { "id": "合同期", "text": "合同期" }];
var m_cond_calculatetype = [{ "id": "人工计算", "text": "人工计算", "selected": true }, { "id": "自动计算", "text": "自动计算" }]
var m_cond_paytype = [{ "id": "固定扣点", "text": "固定扣点", "selected": true }, { "id": "保内保外", "text": "保内保外" }, { "id": "取高值", "text": "取高值" }
, { "id": "固定金额", "text": "固定金额" }]
var m_url = "";//供导出URL
var m_conh_startdate = undefined;
var m_conh_enddate = undefined;

$(function () {

    //光标移走自动计算付款申请单总金额
    $('#formContractDetail #txtcond_guaranteeamount').blur(function () {
        if ($('#formContractDetail #txtcond_guaranteeamount').val() == "" || $('#formContractDetail #txtcond_guaranteeamount').val() == undefined) {
            $('#formContractDetail #txtcond_totalperiod').combobox({ required: false })
        } else {
            $('#formContractDetail #txtcond_totalperiod').combobox({ required: true })
        }
    });


    ////htmlobj = $.ajax({
    //    url: GetWSRRURL('Ip'),
    //    options: "JSON",
    //    async: false
    //});
    //var result = $.parseJSON(htmlobj.responseText);
    //if (result.Ip != "") {
    //    Ip = result.Ip;
    //};

    //var m_ip = $.cookie('m_ip');



    var nowDate = new Date();
    nowDate = new Date(nowDate.getFullYear() + "/" + "01" + "/" + "01")

    m_Firstdate = nowDate.format("yyyy-MM-dd");
    m_Enddate = nowDate.DateAdd('y', 1).format("yyyy-MM-dd");

    $('#txtBeginDate').datebox("setValue", m_Firstdate);
    $('#txtEndDate').datebox("setValue", m_Enddate);

    //月结时间
    $('#txtconh_monthclosedate').combobox({
        required: true,
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //添加日
    var data = $('#txtconh_monthclosedate').combobox("getData");
    if (data.length == 0 || data[0].id != "0") {
        for (var i = 1; i <= 31; i++) {
            ComboboxAddRow({ "id": i + "日", "text": i + "日" }, i, '#txtconh_monthclosedate');
        }
        ComboboxAddRow({ "id": "月底", "text": "月底" }, 32, '#txtconh_monthclosedate');
    }

    $('#formContract #txtshopname').combogrid({
        panelWidth: 210,
        url: GetWSRRURL('2b54ffdb-1b84-4fc8-8255-5aab7c3160eb') + "&pagerows=20000&XML=" + GetFormJson([], 'GetDepotInfo'),
        idField: '店铺id',
        textField: '店铺名称',
        mode: 'remote',
        columns: [[
                 { field: '店铺id', title: '店铺ID', width: 65 },
                 { field: '店铺名称', title: '店铺名称', width: 100 }
        ]],
        async: false,
        required: true,
        onSelect: function (rowIndex, rowData) {
            var Depotid = rowData.店铺id;
            $('#formContract #txtconh_dept_id').val(Depotid);
        }
    });

    $(' #txtconh_delaystate').combobox({
        data: [{ "id": "", "text": "无", "selected": true }, { "id": "中止", "text": "中止" }],
        required: false,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //费用周期
    $('#formContractDetail #txtcond_feeperiod').combobox({
        data: m_cond_feeperiod,
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //计算类型
    $('#formContractDetail #txtcond_calculatetype').combobox({
        data: m_cond_calculatetype,
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: function () {
            if ($('#formContractDetail #txtcond_calculatetype').combobox('getValue') == "自动计算") {
                $('#bd').show();
                $('#txtcond_fixamount').numberbox('setValue', "");
                $('#txtcond_fixrate').numberbox('setValue', "");
                $('#txtcond_inguaranteerate').numberbox('setValue', "");
                $('#txtcond_outguaranteerate').numberbox('setValue', "");
                $('#formContractDetail #txtcond_paytype').combobox({ required: true })
                $('#formContractDetail #txtcond_paytype').combobox('setValue','')
            } else {
                $('#bd').hide();
                $('#txtcond_fixamount').numberbox('setValue', "0");
                $('#txtcond_fixrate').numberbox('setValue', "0");
                $('#txtcond_inguaranteerate').numberbox('setValue', "0");
                $('#txtcond_outguaranteerate').numberbox('setValue', "0");
                $('#formContractDetail #txtcond_totalperiod').combobox({ required: false })
                $('#formContractDetail #txtcond_paytype').combobox({ required: false })
            }
        }
    });

    //累计周期
    $('#formContractDetail #txtcond_totalperiod').combobox({
        data: m_cond_feeperiod,
        required: false,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });
    //扣款类型
    $('#formContractDetail #txtcond_paytype').combobox({
        data: m_cond_paytype,
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onSelect: function () {
            //txtcond_fixamount 金额
            //txtcond_fixrate 固定扣点
            //txtcond_inguaranteerate 保内扣点
            // txtcond_outguaranteerate 保外扣点
            if ($('#formContractDetail #txtcond_paytype').combobox('getValue') == "固定扣点") {

                $('#txtcond_fixamount').numberbox('setValue', "0");
                $('#txtcond_fixrate').numberbox('setValue', "0");
                $('#txtcond_inguaranteerate').numberbox('setValue', "0");
                $('#txtcond_outguaranteerate').numberbox('setValue', "0");

                $('#txtcond_fixrate').numberbox({ required: true });
                $('#txtcond_inguaranteerate').numberbox({ required: false });
                $('#txtcond_outguaranteerate').numberbox({ required: false });
                $('#txtcond_fixamount').numberbox({ required: false });

                $('#txtcond_fixrate').numberbox('enable');
                $('#txtcond_inguaranteerate').numberbox('disable');
                $('#txtcond_outguaranteerate').numberbox('disable');
                $('#txtcond_fixamount').numberbox('disable');
            }
            else if ($('#formContractDetail #txtcond_paytype').combobox('getValue') == "保内保外") {
                $('#txtcond_fixamount').numberbox('setValue', "0");
                $('#txtcond_fixrate').numberbox('setValue', "0");
                $('#txtcond_inguaranteerate').numberbox('setValue', "0");
                $('#txtcond_outguaranteerate').numberbox('setValue', "0");

                $('#txtcond_fixrate').numberbox({ required: false });
                $('#txtcond_inguaranteerate').numberbox({ required: true });
                $('#txtcond_outguaranteerate').numberbox({ required: true });
                $('#txtcond_fixamount').numberbox({ required: false });

                $('#txtcond_fixrate').numberbox('disable');
                $('#txtcond_inguaranteerate').numberbox('enable');
                $('#txtcond_outguaranteerate').numberbox('enable');
                $('#txtcond_fixamount').numberbox('disable');
            }
            else if ($('#formContractDetail #txtcond_paytype').combobox('getValue') == "取高值") {
                $('#txtcond_fixamount').numberbox('setValue', "0");
                $('#txtcond_fixrate').numberbox('setValue', "0");
                $('#txtcond_inguaranteerate').numberbox('setValue', "0");
                $('#txtcond_outguaranteerate').numberbox('setValue', "0");

                $('#txtcond_fixrate').numberbox({ required: false });
                $('#txtcond_inguaranteerate').numberbox({ required: false });
                $('#txtcond_outguaranteerate').numberbox({ required: false });
                $('#txtcond_fixamount').numberbox({ required: false });

                $('#txtcond_fixrate').numberbox('enable');
                $('#txtcond_inguaranteerate').numberbox('enable');
                $('#txtcond_outguaranteerate').numberbox('enable');
                $('#txtcond_fixamount').numberbox('enable');
            }
            else if ($('#formContractDetail #txtcond_paytype').combobox('getValue') == "固定金额") {
                $('#txtcond_fixamount').numberbox('setValue', "0");
                $('#txtcond_fixrate').numberbox('setValue', "0");
                $('#txtcond_inguaranteerate').numberbox('setValue', "0");
                $('#txtcond_outguaranteerate').numberbox('setValue', "0");

                $('#txtcond_fixrate').numberbox({ required: false });
                $('#txtcond_inguaranteerate').numberbox({ required: false });
                $('#txtcond_outguaranteerate').numberbox({ required: false });
                $('#txtcond_fixamount').numberbox({ required: true });

                $('#txtcond_fixrate').numberbox('disable');
                $('#txtcond_inguaranteerate').numberbox('disable');
                $('#txtcond_outguaranteerate').numberbox('disable');
                $('#txtcond_fixamount').numberbox('enable');
            }
        }
    });

    btnSearch();
})

//查询
function btnSearch() {

    var conh_code = $('#txtconh_code').val();   //合同编号
    var shopname = $('#txtshopname').val();//店铺名称
    var conh_rgdt = $('#txtBeginDate').datebox("getValue");
    var conh_EndDate = $('#txtEndDate').datebox("getValue");

    var data = [];
    data[data.length] = { "name": "txttype", "value": "head" };

    var url = GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d') + "&XML=" + GetFormJson(data, 'GetContractInfo') + "&WHERE=";

    url += " 1=1 and conh_rgdt between '" + conh_rgdt + "'" + " AND " + "'" + conh_EndDate + "'";

    if (conh_code == "") {

        url += " ";

    } else {

        url += escape(" and conh_code like  '%" + conh_code + "%' ");
    }
    if (shopname == "") {

        url += " ";

    } else {
        url += escape(" and 店铺名称 like  '%" + shopname + "%' ");
    }
    m_url = url;//把主表URL赋值给全局URL
    initGird(url);

}

//加载数据
function initGird(url) {
    $('#contractInfoHeadList').datagrid(
        {
            title: '', //表格标题
            url: url,
            sortName: 'conh_id', //排序字段
            idField: 'conh_id', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            exportExcel: false,
            onClickRow: function (rowIndex, rowData) {
                m_SelectRow = rowData;
                m_ConDetail = rowData.conh_id;//主表GUID

                if (m_ConDetail == "" || m_ConDetail == undefined) {
                    alert("异常");
                    return;
                } else {
                    initDetailInfo(rowData.conh_id);
                    m_conh_startdate = rowData.conh_startdate;
                    m_conh_enddate = rowData.conh_enddate;
                }
            },
            onLoadSuccess: function (data) {
                ClearGrid("#contractInfoDetailList");
            },
            rownumbers: true,
            columns: [[
                { field: 'conh_code', title: '合同编号', width: 80, search: true, sortable: true },
                { field: '店铺名称', title: '店铺名称', width: 100, search: true, sortable: true },
                { field: 'conh_dept_id', title: '店铺编号', width: 100, search: true, sortable: true, hidden: true },
                { field: '督导', title: '督导', width: 55, sortable: true },
                { field: '店铺等级', title: '店铺等级', width: 55, sortable: true, },
                { field: '楼层', title: '楼层', width: 55, sortable: true },
                { field: '位置', title: '位置', width: 55, sortable: true },
                { field: 'conh_area', title: '合同面积', width: 55, sortable: true },
                { field: '开店时间', title: '开店时间', width: 70, search: true, sortable: true, formatter: Formater.Date },
                { field: 'conh_startdate', title: '起始时间', width: 70, sortable: true, formatter: Formater.Date },
                { field: 'conh_enddate', title: '截止时间', width: 70, sortable: true, formatter: Formater.Date },
                { field: 'conh_state', title: '状态', width: 55, sortable: true },
                { field: 'conh_checkdate', title: '对账日期', width: 70, sortable: true, formatter: Formater.Date },
                { field: 'conh_monthclosedate', title: '月结日期', width: 70, sortable: true },
                { field: 'conh_delaydate', title: '延期日期', width: 70, sortable: true, formatter: Formater.Date },
                { field: 'conh_delaystate', title: '延期状态', width: 55, sortable: true },
            ]]
        });
}
//功能按钮
function btnFunction(type) {

    if (type == "add") {
        $('#divContract').window({
            title: "新增",
            top: 40,
            width: 515,
            height: 360,
            modal: true
        }).window("open");

      

        $('#formContract').form('clear')
        $('#formContract').form('validate');
        $('#formContract').find('#txtconh_state').val("未执行")
        $('#formContract').form('validate');
    } else if (type == "edit") {
        //m_SelectRow = $('#contractInfoHeadList').datagrid('getSelected');
        if (!m_SelectRow) {
            $.messager.alert("提示", "请选择修改行", 'error');
            return;
        } else {

            $('#divContract').window({
                title: "修改",
                top: 40,
                width: 515,
                height: 360,
                modal: true
            }).window("open");
            $('#formContract').form('validate');
            $('#formContract').find('#txtconh_id').val(m_SelectRow.conh_id);//合同ID
            $('#formContract').find('#txtconh_code').val(m_SelectRow.conh_code);//合同编号
            $('#formContract').find('#txtshopname').combogrid('setValue', (m_SelectRow.店铺名称));//店铺名称-------------------
            $('#formContract').find('#txtconh_dept_id').val(m_SelectRow.conh_dept_id);//店铺编号
            $('#formContract').find('#txtconh_area').val(m_SelectRow.conh_area);//合同面积
            $('#formContract').find('#txtconh_state').val(m_SelectRow.conh_state);//状态
            $('#formContract').find('#txtconh_startdate').datebox('setValue', m_SelectRow.conh_startdate);//起始日期
            $('#formContract').find('#txtconh_enddate').datebox('setValue', m_SelectRow.conh_enddate);//截止时间
            $('#formContract').find('#txtconh_monthclosedate').combobox("setValue", m_SelectRow.conh_monthclosedate);//月结日期
            $('#formContract').find('#txtconh_delaydate').datebox('setValue', m_SelectRow.conh_delaydate);//延期日期
            $('#formContract').find('#txtconh_delaystate').combobox('setValue', m_SelectRow.conh_delaystate);//延期状态
            $('#formContract').find('#txtconh_checkdate').val(m_SelectRow.conh_checkdate);//对账日期
            $('#formContract').find('#txtconh_state').val(m_SelectRow.conh_state)
            $('#formContract').form('validate');
        }
    }
}

//提交
function saveHead() {
    $('#formContract').form('submit', {
        onSubmit: function (e) {
            var $fc = $('#formContract');

            if ($fc.form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return;
            }
            if ($fc.find('#txtconh_enddate').datebox('getValue') < $fc.find('#txtconh_startdate').datebox('getValue')) {
                $.messager.alert("提示", "截止时间不能小于开始时间！", 'error');
                return;
            }

            if ($fc.find('#txtconh_delaydate').datebox('getValue') < $fc.find('#txtconh_enddate').datebox('getValue')) {
                $.messager.alert("提示", "延期时间不能小于截止时间！", 'error');
                return;
            }

            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {


                    var data = [];
                    data[data.length] = { "name": "txttype", "value": "head" }//主表


                    data[data.length] = { "name": "txtconh_id", "value": $fc.find('#txtconh_id').val() }//百货合同ID
                    data[data.length] = { "name": "txtconh_m01p_id", "value": "集团ID" } //集团ID
                    data[data.length] = { "name": "txtconh_m02c_id", "value": "事业体ID" } //事业体ID
                    data[data.length] = { "name": "txtconh_code", "value": $fc.find('#txtconh_code').val() }//百货合同编码
                    data[data.length] = { "name": "txtconh_dept_id", "value": $fc.find('#txtconh_dept_id').val() };//店铺ID
                    data[data.length] = { "name": "txtconh_area", "value": $fc.find('#txtconh_area').val() } //合同面积
                    data[data.length] = { "name": "txtconh_checkdate", "value": $fc.find('#txtconh_checkdate').val() }//对账日期特殊

                    data[data.length] = { "name": "txtconh_enddate", "value": $fc.find('#txtconh_enddate').datebox('getValue') }//截止日期
                    data[data.length] = { "name": "txtconh_state", "value": $fc.find('#txtconh_state').val() }//状态
                    data[data.length] = { "name": "txtconh_startdate", "value": $fc.find('#txtconh_startdate').datebox('getValue') }//起始日期

                    data[data.length] = { "name": "txtconh_monthclosedate", "value": $fc.find('#txtconh_monthclosedate').combobox('getValue') }//月结日期
                    data[data.length] = { "name": "txtconh_delaydate", "value": $fc.find('#txtconh_delaydate').datebox('getValue') }//延期日期
                    data[data.length] = { "name": "txtconh_delaystate", "value": $fc.find('#txtconh_delaystate').combobox('getValue') }//延期状态

                    var XMLData = GetFormJson(data, 'EditContractInfo');
                    //return;
                    $.messager.progress({ title: '请稍后', msg: '处理中' });
                    $.ajax({
                        url: GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d'),
                        type: 'post',
                        async: true, //异步,
                        data: { "XML": XMLData },
                        success: function (result) {
                            try {
                                var result = eval("[" + result + "]");

                                if (result[0].Error) {
                                    $.messager.progress('close');

                                    $.messager.alert("系统错误", result[0].Error, 'error');
                                } else if (result[0].rows[0].result == "False") {
                                    $.messager.progress('close');

                                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                                }
                                else {
                                    if (result[0].rows[0].result == "1") {
                                        $.messager.progress('close');
                                        //$('#contractInfoHeadList').datagrid("unselectAll");
                                        $('#contractInfoHeadList').datagrid("reload");
                                        $('#contractInfoHead').datagrid("reload");

                                        $.messager.alert("提示", result[0].rows[0].message);
                                    } else {
                                        $.messager.progress('close');
                                        $('#divContract').window('close');
                                        //$('#contractInfoHeadList').datagrid("unselectAll");
                                        $('#contractInfoHeadList').datagrid("reload");
                                        $('#contractInfoHead').datagrid("reload");

                                        $.messager.alert("提示", result[0].rows[0].message);
                                    }

                                }
                            } catch (ex) {
                                $.messager.progress('close');

                                $.messager.alert("提示", ex, 'error');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "提交错误了！", 'error');
                        }
                    });
                    return false;
                }
            })
        }
    });
}

//取消
function calcel(type) {
    if (type == "A1") {
        $('#divContract').window('close');
    }
    else if (type == "A2") {
        $('#divContractDetail').window('close');
    };
}

//删除
function btnDelete() {

    if (!m_SelectRow) {
        alert('请选择需要删除的一行');
        return;
    }
    if (m_SelectRow.conh_state != "未执行") {
        $.messager.alert("提示", "只有状态=未执行，可以删除！", 'error');
        return;
    }
    //var DatePO2_PODetailList = $('#PO2_PODetailList').datagrid('getData');
    //if (DatePO2_PODetailList.rows.length != "0") {
    //    alert('已经生成采购子表无法删除')
    //    return;
    //}
    $.messager.confirm('提示框', '是否确认删除', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtconh_id", "value": m_SelectRow.conh_id }
            data[data.length] = { "name": "txttype", "value": "head" }

            var XMLData = GetFormJson(data, 'DelContractInfo');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $('#contractInfoHeadList').datagrid("reload");
                            ClearGrid("#contractInfoDetailList");
                            $("#btn_AddDetail").hide();
                            $("#btn_EditDetail").hide();
                            $("#btn_RemoveDetail").hide();

                            $.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.progress('close');

                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    })




}

//----------------------------------------------------------------------子表
//子表加载
function initDetailInfo(m_ConDetail) {

    var data = [];
    data[data.length] = { "name": "txttype", "value": "detail" };

    ClearGrid("#contractInfoDetailList");
    $('#contractInfoDetailList').datagrid(
       {
           url: GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d'),
           queryParams: { "XML": GetFormJson(data, 'GetContractInfo'), "WHERE": "cond_dpcn_id=" + "'" + m_ConDetail + "'" },
           //sortName: ' COND_LmDt ', //排序字段
           sortable: true,
           idField: ' cond_id ', //标识字段,主键
           iconCls: '', //标题左边的图标
           nowrap: true, //是否换行，True 就会把数据显示在一行里
           striped: true, //True 奇偶行使用不同背景色
           collapsible: false, //可折叠
           sortOrder: ' asc ', //排序类型
           remoteSort: false, //定义是否从服务器给数据排序
           fit: true,
           //pagination: true, //是否开启分页
           //pageSize: 20, //默认一页数据条数
           singleSelect: true, //单行选择
           rownumbers: true,
           //onClickRow: function (rowIndex, rowData) {
           //    m_SelectRowDetail = rowData;
           //},
           columns: [[
               { field: 'cond_id', title: '百货合同明细ID', width: 60, hidden: true },
               { field: 'cond_dpcn_id', title: '百货合同ID', width: 60, hidden: true },
               { field: 'cond_feename', title: '费用名称', width: 60 },
               { field: 'cond_calculatetype', title: '计算类型', width: 60 },
               { field: 'cond_feeperiod', title: '费用周期', width: 70 },
               { field: 'cond_startdate', title: '起始日期', width: 70, formatter: Formater.Date },
               { field: 'cond_enddate', title: '截止日期', width: 70, formatter: Formater.Date },
               { field: 'cond_saletask', title: '销售任务', width: 60 },
               { field: 'cond_guaranteeamount', title: '保底金额', width: 60, formatter: Formater.Account },
               { field: 'cond_totalperiod', title: '累计周期', width: 60 },
               { field: 'cond_paytype', title: '扣费类型', width: 60 },
               { field: 'cond_fixamount', title: '固定金额', width: 60, formatter: Formater.Account },
               { field: 'cond_fixrate', title: '固定扣点', width: 60, formatter: Formater.Account },
               { field: 'cond_inguaranteerate', title: '保内扣点', width: 60, formatter: Formater.Account },
               { field: 'cond_outguaranteerate', title: '保外扣点', width: 60, formatter: Formater.Account },
               { field: 'cond_paydesp', title: '扣费说明', width: 120 }
           ]],
           onLoadSuccess: function (data) {
               if (data.rows.length == "0") {
                   m_SelectRowDetail = undefined;
               }
               $("#btn_AddDetail").show();
               $("#btn_EditDetail").show();
               $("#btn_RemoveDetail").show();

           },
           toolbar: "#tab_toolbar",
           toolbar: [
           {
               id: 'btn_AddDetail',
               text: '新增',
               iconCls: 'icon-add',
               hidden: true,
               handler: function () {
                   btnFunctionDetail("add");
               }
           },
           {
               id: 'btn_EditDetail',
               text: '修改',
               iconCls: 'icon-edit',
               hidden: true,
               handler: function () {
                   btnFunctionDetail("edit");
               }
           },
           {
               id: 'btn_RemoveDetail',
               text: '删除',
               iconCls: 'icon-cancel',
               hidden: true,
               handler: function () {
                   btnDeleteD()
               }
           }]
       }
 );
}

//子表功能按钮
function btnFunctionDetail(type) {

    if (type == "add") {
        $('#divContractDetail').window({
            title: "新增",
            top: 40,
            width: 515,
            height: 450,
            modal: true
        }).window("open");
        $('#bd').show();
        $('#formContractDetail').form('clear')
        $('#formContractDetail').find('#txtcond_dpcn_id').val(m_ConDetail)
        $('#formContractDetail').form('validate');


        $('#formContractDetail').find('#txtcond_startdate').datebox('setValue', m_conh_startdate)
        $('#formContractDetail').find('#txtcond_enddate').datebox('setValue', m_conh_enddate)

    } else if (type == "edit") {

        var selectRowEditDetail = $('#contractInfoDetailList').datagrid('getSelected');

        if (!selectRowEditDetail) {
            $.messager.alert("提示", "请选择修改行", 'error');
            return;
        } else {
            $('#divContractDetail').window({
                title: "修改",
                top: 40,
                width: 515,
                height: 450,
                modal: true
            }).window("open");

            $('#formContractDetail').form('validate');

            $('#formContractDetail').find('#txtcond_feename').val(selectRowEditDetail.cond_feename);//费用名称
            $('#formContractDetail').find('#txtcond_id').val(selectRowEditDetail.cond_id);//ID
            $('#formContractDetail').find('#txtcond_dpcn_id').val(selectRowEditDetail.cond_dpcn_id);//主ID
            $('#formContractDetail').find('#txtcond_calculatetype').combobox('setValue', selectRowEditDetail.cond_calculatetype);//计算类型
            $('#formContractDetail').find('#txtcond_feeperiod').combobox('setValue', selectRowEditDetail.cond_feeperiod);//费用周期
            $('#formContractDetail').find('#txtcond_saletask').val(selectRowEditDetail.cond_saletask);//销售任务
            $('#formContractDetail').find('#txtcond_startdate').datebox('setValue', selectRowEditDetail.cond_startdate);//起始日期
            $('#formContractDetail').find('#txtcond_enddate').datebox('setValue', selectRowEditDetail.cond_enddate);//截止日期
            $('#formContractDetail').find('#txtcond_guaranteeamount').numberbox('setValue', selectRowEditDetail.cond_guaranteeamount);//保底金额
            $('#formContractDetail').find('#txtcond_totalperiod').combobox('setValue', selectRowEditDetail.cond_totalperiod);//累计周期

            $('#formContractDetail').find('#txtcond_paytype').combobox('setValue', selectRowEditDetail.cond_paytype);//扣款类型
            $('#formContractDetail').find('#txtcond_fixamount').numberbox('setValue', selectRowEditDetail.cond_fixamount);//固定金额
            $('#formContractDetail').find('#txtcond_fixrate').numberbox('setValue', selectRowEditDetail.cond_fixrate);//固定扣点
            $('#formContractDetail').find('#txtcond_inguaranteerate').numberbox('setValue', selectRowEditDetail.cond_inguaranteerate);//保内扣点
            $('#formContractDetail').find('#txtcond_outguaranteerate').numberbox('setValue', selectRowEditDetail.cond_outguaranteerate);//保外扣点
            $('#formContractDetail').find('#txtcond_paydesp').val(selectRowEditDetail.cond_paydesp);//扣费说明

            $('#formContractDetail').form('validate');
        }
    }
}

//提交
function saveDetail() {
    $('#formContractDetail').form('submit', {
        onSubmit: function (e) {


            var $fc = $('#formContractDetail');
            if ($fc.form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }

            if ($fc.find('#txtcond_startdate').datebox('getValue') > $fc.find('#txtcond_enddate').datebox('getValue')) {
                $.messager.alert("提示", "开始时间不能大于截止时间！", 'error');
                return false;
            }

            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {


                    var data = [];
                    data[data.length] = { "name": "txttype", "value": "detail" }//主表
                    data[data.length] = { "name": "txtcond_feename", "value": $fc.find('#txtcond_feename').val() }//费用名称
                    data[data.length] = { "name": "txtcond_id", "value": $fc.find('#txtcond_id').val() }//ID
                    data[data.length] = { "name": "txtcond_dpcn_id", "value": $fc.find('#txtcond_dpcn_id').val() }//主ID
                    data[data.length] = { "name": "txtcond_calculatetype", "value": $fc.find('#txtcond_calculatetype').combobox('getValue') }//计算类型
                    data[data.length] = { "name": "txtcond_feeperiod", "value": $fc.find('#txtcond_feeperiod').combobox('getValue') }//费用周期
                    data[data.length] = { "name": "txtcond_saletask", "value": $fc.find('#txtcond_saletask').val() }//销售任务
                    data[data.length] = { "name": "txtcond_startdate", "value": $fc.find('#txtcond_startdate').datebox('getValue') }//起始日期
                    data[data.length] = { "name": "txtcond_enddate", "value": $fc.find('#txtcond_enddate').datebox('getValue') }//截止日期

                    //data[data.length] = { "name": "txtcond_guaranteeamount", "value": $fc.find('#txtcond_guaranteeamount').numberbox('getValue') }//保底金额
                    data[data.length] = { "name": "txtcond_guaranteeamount", "value": $fc.find('#txtcond_guaranteeamount').numberbox('getValue') == "" ? $fc.find('#txtcond_guaranteeamount').numberbox('getValue') : "0" }//保底金额

                    data[data.length] = { "name": "txtcond_totalperiod", "value": $fc.find('#txtcond_totalperiod').combobox('getValue') }//累计周期
                    data[data.length] = { "name": "txtcond_paytype", "value": $fc.find('#txtcond_paytype').combobox('getValue') }//扣款类型
                    data[data.length] = { "name": "txtcond_fixamount", "value": $fc.find('#txtcond_fixamount').numberbox('getValue') }//固定金额
                    data[data.length] = { "name": "txtcond_fixrate", "value": $fc.find('#txtcond_fixrate').numberbox('getValue') }//固定扣点
                    data[data.length] = { "name": "txtcond_inguaranteerate", "value": $fc.find('#txtcond_inguaranteerate').numberbox('getValue') }//保内扣点
                    data[data.length] = { "name": "txtcond_outguaranteerate", "value": $fc.find('#txtcond_outguaranteerate').numberbox('getValue') }//保外扣点
                    data[data.length] = { "name": "txtcond_paydesp", "value": $fc.find('#txtcond_paydesp').val() }//扣费说明

                    var XMLData = GetFormJson(data, 'EditContractInfo');
                    //return;
                    $.messager.progress({ title: '请稍后', msg: '处理中' });
                    $.ajax({
                        url: GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d'),
                        type: 'post',
                        async: true, //异步,
                        data: { "XML": XMLData },
                        success: function (result) {
                            try {
                                var result = eval("[" + result + "]");

                                if (result[0].Error) {
                                    $.messager.progress('close');
                                    $.messager.alert("系统错误", result[0].Error, 'error');
                                } else if (result[0].rows[0].result == "False") {
                                    $.messager.progress('close');

                                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                                }
                                else {
                                    $.messager.progress('close');
                                    $('#divContractDetail').window('close');
                                    $('#contractInfoDetailList').datagrid("unselectAll");
                                    $('#contractInfoDetailList').datagrid("reload");
                                    //m_SelectRowDetail = undefined;
                                    $.messager.alert("提示", result[0].rows[0].message);
                                }
                            } catch (ex) {
                                $.messager.progress('close');

                                $.messager.alert("提示", ex, 'error');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "提交错误了！", 'error');
                        }
                    });
                    return false;
                }
            })
        }
    });
}

//删除
function btnDeleteD() {
    var selectRowDeleteDetail = $('#contractInfoDetailList').datagrid('getSelected');
    if (!selectRowDeleteDetail) {
        $.messager.alert("提示", "请选择需要删除的一行", 'error');
        return;
    }
    $.messager.confirm('提示框', '是否确认删除', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtcond_id", "value": selectRowDeleteDetail.cond_id }
            data[data.length] = { "name": "txttype", "value": "detail" }

            var XMLData = GetFormJson(data, 'DelContractInfo');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $('#contractInfoDetailList').datagrid("unselectAll");
                            $('#contractInfoDetailList').datagrid("reload");
                            //m_SelectRowDetail = undefined;
                            $.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.progress('close');

                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    })
}



function btnExportEXCEL() {

    var listData = $('#contractInfoHeadList').datagrid('getRows')

    if (listData.length <= 1 && listData[0].conh_code == "" || listData == undefined) {
        alert("请先加载数据");
        return;
    }

    EasyUI_DataGrid_ExcelExport1("", "")
}

//导出Exel主函数
function EasyUI_DataGrid_ExcelExport1(pgrid, pagination) {
    var btnExcel = null;

    var exportExcelUrl = "";

    var conh_code = $('#txtconh_code').val();   // 合同编号
    var shopname = $('#txtshopname').val();//店铺名称
    var conh_rgdt = $('#txtBeginDate').datebox("getValue");
    var conh_EndDate = $('#txtEndDate').datebox("getValue");

    var data = [];
    data[data.length] = { "name": "txttype", "value": "" };

    var exportExcelUrl = GetWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d') + "&XML=" + GetFormJson(data, 'exportExcel') + "&WHERE=";

    exportExcelUrl += " 1=1 and conh_rgdt between '" + conh_rgdt + "'" + " AND " + "'" + conh_EndDate + "'";

    if (conh_code == "") {

        exportExcelUrl += " ";

    } else {

        exportExcelUrl += escape(" and 合同编号 like  '%" + conh_code + "%' ");
    }
    if (shopname == "") {

        exportExcelUrl += " ";

    } else {
        exportExcelUrl += escape(" and 店铺名称 like  '%" + shopname + "%' ");
    }

    var data = [];
    data[data.length] = { "name": "txttype", "value": "" };
    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('120995fd-4793-4e3b-b60e-66e6a6bbc90d') + "&XML=" + GetFormJson(data, 'exportExcel'),
        async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    var m_columns = Text.Col;
    m_columns = eval(m_columns);

    //pagination.find('a.l-btn').each(function () {
    //    if ($(this).find('span.icon-excel').length) {
    //        btnExcel = $(this);
    //        btnExcel.linkbutton('disable');
    //        btnExcel.linkbutton({ iconCls: "pagination-loading" });

    //    }
    //});

    //var dataOptions = pgrid.datagrid("options");

    var strUrl = exportExcelUrl;
    var dataColumns = eval(m_columns);
    var dataColumnsFrozen = null;
    var dataParam;
    //var dataParam = dataOptions.queryParams;//参数
    //var pageSize = dataOptions.pageSize;
    //var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "合同导出";

    var strXMLCol = "<Root><List>";

    if (dataColumnsFrozen != null && dataColumnsFrozen.length > 0) {
        for (var i = 0; i < dataColumnsFrozen[0].length; i++) {

            if (dataColumnsFrozen[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + dataColumnsFrozen[0][i].field + "</field>";

            if (dataColumnsFrozen[0][i].title) {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].title + "</title>";
            }
            else {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].field + "</title>";

            }
            if (dataColumnsFrozen[0][i].width) {
                strXMLCol += "<width>" + dataColumnsFrozen[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumnsFrozen[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumnsFrozen[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumnsFrozen[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }
            strXMLCol += "</Rows>";
        }
    }
    if (dataColumns != null && dataColumns.length > 0) {
        for (var i = 0; i < dataColumns[0].length; i++) {

            if (dataColumns[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + (dataColumns[0][i].field) + "</field>";

            if (dataColumns[0][i].title) {
                strXMLCol += "<title>" + (dataColumns[0][i].title) + "</title>";
            }
            else {
                strXMLCol += "<title>" + (dataColumns[0][i].field) + "</title>";

            }

            if (dataColumns[0][i].width) {
                strXMLCol += "<width>" + dataColumns[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumns[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumns[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumns[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }

            //if (dataColumns[0][i].align) {
            //    strXMLCol += "<align>" + dataColumns[0][i].align + "</align>";
            //}
            //else {
            //    strXMLCol += "<align>left</align>";
            //} 


            //if (dataColumns[0][i].halign) {
            //    strXMLCol += "<halign>" + dataColumns[0][i].halign + "</halign>";
            //}
            //else {
            //    strXMLCol += "<halign>center</halign>";
            //}
            strXMLCol += "</Rows>";
        }
    }

    strXMLCol += "</List></Root>";

    var dataParam = new Object();
    dataParam.ExcelExportColumns = strXMLCol

    $.messager.confirm('提示框', "是否导出", function (e) {
        if (e) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: strUrl + "&pagerows=0&pageNumber=1&ExcelExport=true&title=" + escape(title) + "&rd=" + Math.random(),
                data: dataParam,
                type: 'POST',
                options: "JSON",
                success: function (data) {
                    //if (btnExcel != null) {
                    //    btnExcel.linkbutton('enable');

                    //    btnExcel.linkbutton({ iconCls: "icon-excel" });
                    //}
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }
                    $.messager.progress('close');
                    var strFileName = eval("[" + data + "]")[0].FileName;
                    //strFileName = strFileName.substring(0, 29) + FileName.substring(4);
                    window.location.href = strFileName;
                }
            });
        }
    });
}
