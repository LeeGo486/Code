/// JS名：VIPPersonnel.js
/// 说明：VIP会员
/// 创建人：郭琦琦 
/// 创建日期：2014-07-30
var m_DepotID;//店铺编号
//var m_Username = window.m_UserID;//取登入姓名
//初始化
$(function () {
    m_DepotID = window.m_UserID.substring(0, 8);

    $('#txtvipbirth').datebox({
        valueField: 'id',
        textField: 'text',
        required: true,
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd") }
    });
    //性别下拉
    $('#txtvipsex').combobox({
        data: [{ "id": "男", "text": '男' }, { "id": "女", "text": "女", selected: true }],//, "selected": true
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    });


    var data = [];
    data[data.length] = { "name": "txtdepotid", "value": m_DepotID }; //店铺编号
    //客户经理
    $('#txttz_name').combobox({
        url: GetComboxWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e', "", "employeeid", "names") + "&XML=" + GetFormJson(data, 'Getemployee'),
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        async: true, //异步
        onLoadSuccess: function (data) {
            var m_data1 = $('#txttz_name').combobox('getData');
            $('#txttz_name').combobox('setValue', m_data1[m_data1.length - 1].text);
        },
        onSelect: function (data) {
            $('#txtemployeeid').val($('#txttz_name').combobox('getValue'));
        }
    });

    $('#txtvipoccupation').combobox({
        url: GetComboxWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e', "", "lookname", "lookname1") + "&XML=" + GetFormJson(data, 'Getlookname'),
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        async: true, //异步
        onLoadSuccess: function (data) {
            var m_data1 = $('#txtvipoccupation').combobox('getData');
            $('#txtvipoccupation').combobox('setValue', m_data1[m_data1.length - 1].text);
        }
    });


    //初始化城市
    $('#txtcity').combobox({});

    //调取省
    var url = GetComboxWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("省份");
    htmlobj = $.ajax({
        url: url,
        async: false
    });
    //初始化省
    var add_province = $.parseJSON(htmlobj.responseText);
    $('#txtadd_province').combobox({
        data: add_province,
        panelHeight: 300,
        editable: false,
        valueField: 'text',
        textField: 'text',
        required: true,
        onLoadSuccess: function (data) {
            var m_data3 = $('#txtadd_province').combobox('getData');
            $('#txtadd_province').combobox('setValue', m_data3[0].text);
        },
        onChange: function () {
            var selectProvince = $('#txtadd_province').combobox('getValue');//获取选择的省
            //获取城市

            var url = GetComboxALLColumnWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("地级市") + "&Province=" + escape(selectProvince);
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            var Prefecture = $.parseJSON(htmlobj.responseText);//城市
            $('#txtcity').combobox({
                data: Prefecture,
                valueField: 'text',
                textField: 'text',
                panelHeight: '200',
                editable: false,
                required: true,
                onLoadSuccess: function (data) {
                    if (data.Error == "Error:必须输入省份") {
                    }
                    else {
                        var m_data2 = $('#txtcity').combobox('getData');
                        $('#txtcity').combobox('setValue', m_data2[0].text);
                    }
                }
            });
        }
    });
    var urlGetVIPPersonnel = GetWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e') + "&XML=" + GetFormJson("", 'GetVIPPersonnel');
    initGridGetVIPPersonnel(urlGetVIPPersonnel);

    $('#DivVIPPersonnel').window('close');
})

//查询
function btnSearch() {
    var search = $('#txtParm').val();//取查询框数据
    //var url = "1=1";
    //if (search == "") {
    //    url = url
    //} else {
    //    url += " and vipname like '%" + search + "%' or mobtel like '%" + search + "%' ";
    //}
    var data = [];
    data[data.length] = { "name": "txtsearch", "value": search };
    var urlGetVIPPersonnel = GetWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e') + "&XML=" + GetFormJson(data, 'GetVIPPersonnel');
    initGridGetVIPPersonnel(urlGetVIPPersonnel);
}

//加载会员信息
function initGridGetVIPPersonnel(url) {
    $('#viplist').datagrid(
        {
            title: '会员信息', //表格标题
            url: url,
            sortName: 'crdate', //排序字段
            idField: 'vipid', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'DESC', //排序类型
            sortable: true,
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            columns: [[
                   { field: 'vipid', title: 'vipid', width: 150, hidden: true },
                   { field: 'vipcode', title: 'VIP卡号', width: 70, search: true, sortable: true },
                   { field: 'vipname', title: '姓名', width: 60, search: true, sortable: true },
                   { field: 'vipbirth', title: '出生日期', width: 75, formatter: Formater.Date, search: true, sortable: true },
                   { field: 'vipsex', title: '性别', width: 35 },
                   { field: 'mobtel', title: '移动电话', width: 90, search: true, sortable: true },
                   { field: 'vipoccupation', title: '职业', width: 130, search: true, sortable: true },
                   { field: 'tz_name', title: '拓展人', width: 60, search: true, sortable: true },
                   { field: 'employeeid', title: '拓展人id', width: 80 },
                   { field: 'add_province', title: '省', width: 80, search: true, sortable: true },
                   { field: 'add_city', title: '城市', width: 80, search: true, sortable: true },
                   { field: 'vipadd', title: '地址', width: 80 },
                   { field: 'qq', title: 'QQ', width: 80 },
                   { field: 'weibo', title: '微博', width: 80 },
                   { field: 'vipemail', title: '电子邮件', width: 80 },
                   { field: 'vipbrand1', title: '喜好的品牌', width: 80 },
                   { field: 'viplove', title: '个人爱好', width: 80 },
                   { field: 'liketalktype', title: '喜好的沟通', width: 80 },
                   { field: 'crdate', title: '创建时间', width: 80, formatter: Formater.Date }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_add',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    editVIP(true);
                }
            },
            {
                id: 'btn_edit',
                text: '维护会员',
                iconCls: 'icon-edit',
                handler: function () {
                    editVIP(false);
                }
            }]
        });
}

//新增会员
function editVIP(type) {

    if (type == true) {
        $('#DivVIPPersonnel').window({
            title: "新增会员信息",

            width: 700,
            height: 280
        });

        $('#DivVIPPersonnel').window("open");

        $('#txtvipname').val("");//姓名
        $('#txtvipcode').val("");//卡号
        $('#txtvipbirth').datebox('setValue', "");//出生年月
        $('#txtvipsex').combobox('setValue', "女");//性别
        $('#txtmobtel').numberbox('setValue', "");//电话
        $('#txtvipoccupation').combobox('setValue', "");//职业
        $('#txttz_name').combobox('setValue', "");//经理
        $('#txtemployeeid').val("");//经理ID
        $('#txtadd_province').combobox('setValue', "");//省
        $('#txtcity').combobox('setValue', "");//市
        $('#txtvipadd').val("");//地址
        $('#txtqq').numberbox('setValue', "");//QQ
        $('#txtweibo').val("");//微博账号
        $('#txtvipemail').val("");//电子邮件
        $('#txtvipbrand1').val("");//喜好的品牌
        $('#txtviplove').val("");//个人爱好
        $('#txtliketalktype').val("");//喜好的沟通方式
        //$("#txtmobtel").attr("disabled", false);
        $('#formVIPPersonnel').form('validate');

    }
    else {
        var selectRow = $('#viplist').datagrid('getSelected');
        if (!selectRow) {
            $.messager.alert("提示", "请选择修改行", 'error');
            return;
        } else {
            $('#DivVIPPersonnel').window({
                title: "修改会员信息",
                top: 100,
                width: 700,
                height: 280,
                modal: true
            });
            $('#DivVIPPersonnel').window("open");
            $('#txtvipname').val(selectRow.vipname);//姓名
            $('#txtvipcode').val(selectRow.vipcode);//卡号
            $('#txtvipbirth').datebox('setValue', selectRow.vipbirth);//出生年月
            $('#txtvipsex').combobox('setValue', selectRow.vipsex);//性别
            $('#txtmobtel').numberbox('setValue', selectRow.mobtel);//电话
            $('#txtvipoccupation').combobox('setValue', selectRow.vipoccupation);//职业
            $('#txttz_name').combobox('setValue', selectRow.tz_name);//经理
            $('#txtemployeeid').val(selectRow.employeeid);//经理ID
            $('#txtadd_province').combobox('setValue', selectRow.add_province);//省
            $('#txtcity').combobox('setValue', selectRow.add_city);//市
            $('#txtvipadd').val(selectRow.vipadd);//地址
            $('#txtqq').numberbox('setValue', selectRow.qq);//QQ
            $('#txtweibo').val(selectRow.weibo);//微博账号
            $('#txtvipemail').val(selectRow.vipemail);//电子邮件
            $('#txtvipbrand1').val(selectRow.vipbrand1);//喜好的品牌
            $('#txtviplove').val(selectRow.viplove);//个人爱好
            $('#txtliketalktype').val(selectRow.liketalktype);//喜好的沟通方式
            $('#formVIPPersonnel').form('validate');
            $("#txtvipcode").attr("disabled", "disabled");
            //$("#txtmobtel").attr("disabled", "disabled");
            $('#formVIPPersonnel').form('validate');
        }
    }
}

function calcel() {
    $('#DivVIPPersonnel').window('close');
    btnSearch();
}

//新增修改保存操作

function save() {
    $('#formVIPPersonnel').form('submit', {
        onSubmit: function (e) {
            $('#formVIPPersonnel').form('validate')
            if ($('#formVIPPersonnel').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            var data = [];
            //考虑到多种控制，直接每次保存都获取更新或者新增
            data[data.length] = { "name": "txtdepotid", "value": m_DepotID };//店铺编号
            data[data.length] = { "name": "txtvipname", "value": $('#formVIPPersonnel').find("#txtvipname").val() };
            data[data.length] = { "name": "txtvipcode", "value": $('#formVIPPersonnel').find("#txtvipcode").val() };
            data[data.length] = { "name": "txtvipbirth", "value": $('#formVIPPersonnel').find("#txtvipbirth").datebox('getValue') };
            data[data.length] = { "name": "txtvipsex", "value": $('#formVIPPersonnel').find("#txtvipsex").combobox('getValue') };
            data[data.length] = { "name": "txtmobtel", "value": $('#formVIPPersonnel').find("#txtmobtel").numberbox('getValue') };
            data[data.length] = { "name": "txtvipoccupation", "value": $('#formVIPPersonnel').find("#txtvipoccupation").combobox('getValue') };
            data[data.length] = { "name": "txttz_name", "value": $('#formVIPPersonnel').find("#txttz_name").combobox('getText') };
            data[data.length] = { "name": "txtemployeeid", "value": $('#formVIPPersonnel').find("#txtemployeeid").val() };
            data[data.length] = { "name": "txtadd_province", "value": $('#formVIPPersonnel').find("#txtadd_province").combobox('getValue') };
            data[data.length] = { "name": "txtcity", "value": $('#formVIPPersonnel').find("#txtcity").combobox('getValue') };
            data[data.length] = { "name": "txtvipadd", "value": $('#formVIPPersonnel').find("#txtvipadd").val() };
            data[data.length] = { "name": "txtqq", "value": $('#formVIPPersonnel').find("#txtqq").numberbox('getValue') };
            data[data.length] = { "name": "txtweibo", "value": $('#formVIPPersonnel').find("#txtweibo").val() };
            data[data.length] = { "name": "txtvipemail", "value": $('#formVIPPersonnel').find("#txtvipemail").val() };
            data[data.length] = { "name": "txtvipbrand1", "value": $('#formVIPPersonnel').find("#txtvipbrand1").val() };
            data[data.length] = { "name": "txtviplove", "value": $('#formVIPPersonnel').find("#txtviplove").val() };
            data[data.length] = { "name": "txtliketalktype", "value": $('#formVIPPersonnel').find("#txtliketalktype").val() };

            var parmVipName = $('#formVIPPersonnel').find("#txtvipname").val();
            var parmMobTel = $('#formVIPPersonnel').find("#txtmobtel").numberbox('getValue');

            if (parmVipName.indexOf("姐") > 0) {
                $.messager.alert("提示", "您输入姓名含有姐字样", 'error');
                return;
            } else if (parmVipName.indexOf("经理") > 0) {
                $.messager.alert("提示", "您输入姓名含有经理字样", 'error');
                return;
            }
            else if (parmVipName.indexOf("老师") > 0) {
                $.messager.alert("提示", "您输入姓名含有老师字样", 'error');
                return;
            }
            else if (parmVipName.indexOf("总") > 0) {
                $.messager.alert("提示", "您输入姓名含有总字样", 'error');
                return;
            }
            if (parmMobTel.length < 11) {
                $.messager.alert("提示", "请正确填写手机号", 'error');
                return;
            }

            var xmlData = GetFormJson(data, 'EDITVIPPersonnel');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e'),
                type: 'post',
                async: true, //异步,
                data: { "XML": xmlData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");
                        if (result[0].Error) {
                            $.messager.progress('close');
                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message);
                            $('#DivVIPPersonnel').window('close');
                            $('#viplist').datagrid("unselectAll");
                            //$('#viplist').datagrid("reload");
                            btnSearch();
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
    });
}