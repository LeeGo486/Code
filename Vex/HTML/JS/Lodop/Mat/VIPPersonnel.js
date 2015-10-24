﻿/// JS名：VIPPersonnel.js
/// 说明：VIP会员
/// 创建人：郭琦琦 
/// 创建日期：2014-07-30
var m_DepotID;//店铺编号
//var m_Username = window.m_UserID;//取登入姓名
//初始化
$(function () {

    (function () {
        //扩展window方法
        $.extend($.fn.window.methods, {
            init: function (target) {
                $(target).window({
                    title: 'N.Paia 欢迎新会员',
                    collapsible: false,
                    minimizable: false,
                    maximizable: false,
                    closable: false,
                    draggable: false,
                    resizable: false,
                    maximized: true
                });
            }
        });
        //扩展combobox
        $.extend($.fn.combobox.methods, {
            init: function (target,obj) {
                $(target).combobox({
                    url: GetComboxWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e', "", "lookname", "lookname1") + "&XML=" + GetFormJson([{ 'name': 'txtid', 'value': obj.id }], 'GetIndividuation'),
                    valueField: 'id',
                    textField: 'text',
                    panelHeight: '200',
                    editable: false,
                    required: obj.required
                });
            }
        });
        //扩展日期
        $.extend($.fn.datebox.methods, {
            init: function (target, reqbool) {
                $(target).datebox({
                    panelHeight: 'auto',
                    required: reqbool,
                    editable: false,
                    formatter: function (date) { return date.format("yyyy-MM-dd") }
                });
            }
        });
    })();

    uoPic();

    m_DepotID = window.m_UserID.substring(0, 8);

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
                   //{ field: 'qq', title: 'QQ', width: 80 },
                   //{ field: 'weibo', title: '微博', width: 80 },
                   //{ field: 'vipemail', title: '电子邮件', width: 80 },
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
        initWin();
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
        //$('#txtqq').numberbox('setValue', "");//QQ
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
            initWin();
            $('#txtvipid').val(selectRow.vipid);
            $('#txtvipname').val(selectRow.vipname);//姓名
            $('#txtvipcode').val(selectRow.vipcode);//卡号
            $('#txtvipbirth').datebox('setValue', selectRow.vipbirth);//出生年月
            $('#txtvipsex').combobox('setValue', selectRow.vipsex);//性别
            $('#txtmobtel').numberbox('setValue', selectRow.mobtel);//电话
            $('#txtvipoccupation').combobox('setValue', selectRow.vipoccupation);//职业
            $('#txtstature').val(selectRow.stature);//身高
            $('#vipsize').combobox('setValue', selectRow.vipsize); //上身尺码
            $('#vipsize1').combobox('setValue', selectRow.vipsize1);//下身尺码
            $('#txttz_name').combobox('setValue', selectRow.tz_name);//经理
            $('#txtemployeeid').val(selectRow.employeeid);//经理ID
            $('#txtadd_province').combobox('setValue', selectRow.add_province);//省
            $('#txtcity').combobox('setValue', selectRow.add_city);//市
            $('#txtvipadd').val(selectRow.vipadd);//地址
            $('#txtqq').val(selectRow.qq);//QQ
            $('#txtweibo').val(selectRow.weibo);//微博账号
            $('#txtvipemail').val(selectRow.vipemail);//电子邮件
            $('#txtvipbrand1').combobox('setValue',selectRow.vipbrand1);//喜好的品牌
            $('#txtviplove').combobox('setValue',selectRow.viplove);//个人爱好
            $('#txtliketalktype').combobox('setValue',selectRow.liketalktype);//喜好的沟通方式
            $('#txtvippay').val(selectRow.vippay);//年收入

            $('#txtvipcolor').combobox('setValue',selectRow.vipcolor);//色彩喜好
            $('#txtvipbrand1').combobox('setValue',selectRow.vipbrand1);
            $('#txtliketalktype').combobox('setValue',selectRow.liketalktype);
            $('#txtHopeGift').combobox('setValue',selectRow.hopegift);//礼物
            $('#txtvipgrab').combobox('setValue',selectRow.vipgrab);//穿着风格
            $('#txtFabric').combobox('setValue',selectRow.fabric);//面料成份
            $('#txtStyleDemand1').combobox('setValue',selectRow.styledemand1);//风格需求1
            $('#txtStyleDemand2').combobox('setValue', selectRow.styledemand2);//风格需求2
            $('#txtOccasionDemand1').combobox('setValue', selectRow.occasiondemand1);//场合需求1
            $('#txtOccasionDemand2').combobox('setValue', selectRow.occasiondemand2);//场合需求2
            $('#Children').combobox('setValue',selectRow.children);//年龄段
            $('#txtToStoreTime1').combobox('setValue',selectRow.tostoretime1);//来店时间段1
            $('#txtToStoreTime2').combobox('setValue',selectRow.tostoretime2);//来店时间段2
            $('#txtMemorialDay1').datebox('setValue',selectRow.memorialday1);//最在乎1
            $('#txtMemorialDay2').datebox('setValue', selectRow.memorialday2);//最在乎2
            $('#userpicture').val(selectRow.vip_photo);//图片路径

            $('#tj_id').combogrid('setValue', selectRow.tj_id);
            $('#tj_name').val(selectRow.tj_name);

            $('#txtimgupload').html("");
            $("<img style='width:200px;height:200px;'/>").appendTo($('#txtimgupload')).attr("src", selectRow.vip_photo);
            
            if (selectRow.vipsex == '女') {//客户性别
                $('input[name=txtvipsex]').get(0).checked = true;
                $('input[name=txtvipsex]').get(1).checked = false;
            } else if (selectRow.vipsex == '男') {
                $('input[name=txtvipsex]').get(1).checked = true;
                $('input[name=txtvipsex]').get(0).checked = false;
            };
            if (selectRow.childrenhave == '有') {//是否有儿女
                $('input[name=txtChildrenHave]').get(0).checked = true;
                $('input[name=txtChildrenHave]').get(1).checked = false;
            } else if (selectRow.childrenhave == '无') {
                $('input[name=txtChildrenHave]').get(1).checked = true;
                $('input[name=txtChildrenHave]').get(0).checked = false;
            };
            if (selectRow.childrensex == '男') {//孩子性别
                $('input[name=txtChildrenSex]').get(0).checked = true;
                $('input[name=txtChildrenSex]').get(1).checked = false;
            } else if (selectRow.childrensex == '女') {
                $('input[name=txtChildrenSex]').get(1).checked = true;
                $('input[name=txtChildrenSex]').get(0).checked = false;
            };
            if (selectRow.isreceipt == 'True') {//发票
                $('input[name=txtisReceipt]').get(0).checked = true;
                $('input[name=txtisReceipt]').get(1).checked = false;
            } else if (selectRow.isreceipt == 'False') {
                $('input[name=txtisReceipt]').get(1).checked = true;
                $('input[name=txtisReceipt]').get(0).checked = false;
            };

            $('#txtReceiptName').val(selectRow.receiptname);
            $('#txtcomment').val(selectRow.comment);

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
            $('#formVIPPersonnel').form('validate');
            if ($('#formVIPPersonnel').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            };
            var data = $('#formVIPPersonnel').serializeArray();
            data.push({ 'name': 'txtdepotid', 'value': m_DepotID });
            data.push({ 'name': 'txtvipcode', 'value': $('#formVIPPersonnel').find("#txtvipcode").val() });
            data.push({ 'name': 'txtvipid', 'value': $('#formVIPPersonnel').find("#txtvipid").val() });
            data.push({ 'name': "txttz_name", 'value': $('#formVIPPersonnel').find("#txttz_name").combobox('getText') });

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


function undo() {
    $('input[name=txtvipsex]').get(0).checked = true;
    $('input[name=txtvipsex]').get(1).checked = false;

    $('input[name=txtvipsex]').get(1).checked = false;
    $('input[name=txtvipsex]').get(0).checked = false;


    $('input[name=txtChildrenHave]').get(0).checked = false;
    $('input[name=txtChildrenHave]').get(1).checked = false;

    $('input[name=txtChildrenHave]').get(1).checked = false;
    $('input[name=txtChildrenHave]').get(0).checked = false;

    $('input[name=txtChildrenSex]').get(0).checked = false;
    $('input[name=txtChildrenSex]').get(1).checked = false;

    $('input[name=txtChildrenSex]').get(1).checked = false;
    $('input[name=txtChildrenSex]').get(0).checked = false;

    $('input[name=txtisReceipt]').get(0).checked = false;
    $('input[name=txtisReceipt]').get(1).checked = false;

    $('input[name=txtisReceipt]').get(1).checked = false;
    $('input[name=txtisReceipt]').get(0).checked = false;

    $('#formVIPPersonnel input').val('');
    $('#DivVIPPersonnel').window('close');
    $('#txtimgupload').html("");
}

function initWin() {
    $('#txtvipname').validatebox({
        required: true,
        validType: 'text'
    });
    //初始化下拉框
    $('#txtFabric').combobox('init', { 'id': '3027', 'required': false });//面料喜好
    $('#txtHopeGift').combobox('init', { 'id': '3033', 'required': false });//收到的礼物
    $('#txtStyleDemand1').combobox('init', { 'id': '3015', 'required': false });//风格需求1
    $('#txtStyleDemand2').combobox('init', { 'id': '3016', 'required': false });//风格需求2
    $('#txtOccasionDemand1').combobox('init', { 'id': '3017', 'required': false });//场合需求1
    $('#txtOccasionDemand2').combobox('init', { 'id': '3018', 'required': false });//场合需求2
    $('#txtviplove').combobox('init', { 'id': '3019', 'required': false });//个人爱好
    $('#txtvipcolor').combobox('init', { 'id': '3032', 'required': false });//色彩喜好
    $('#txtvipbrand1').combobox('init', { 'id': '3022', 'required': true });//喜好品牌
    $('#txtvipgrab').combobox('init', { 'id': '3006', 'required': false });//着装风格
    $('#Children').combobox('init', { 'id': '3014', 'required': false });//育儿年龄
    $('#txtToStoreTime1').combobox('init', { 'id': '3024', 'required': false });//时间段1
    $('#txtToStoreTime2').combobox('init', { 'id': '3025', 'required': false });//时间段2
    $('#txtliketalktype').combobox('init', { 'id': '3028', 'required': false });//沟通方式
    $('#txtMemorialDay1').datebox('init', false);//最在乎的日子1 
    $('#txtMemorialDay2').datebox('init', false);//最在乎的日子2
    $('#txtvipbirth').datebox('init', true);
    var urlRoute = GetComboxWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e', "", "sizeid", "s_name") + "&XML=" + GetGetJson([], 'GetSize');
    $('#vipsize').combobox({
        url: urlRoute,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: false
    });
    $('#vipsize1').combobox({
        url: urlRoute,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: false
    });
    //推荐人
    $('#tj_id').combogrid({
        disabled: false,
        panelWidth: 370,
        url: GetWSRRURL('167cc50a-47ac-4c02-a98b-4ba96528143e') + "&XML=" + GetGetJson([], 'GetReferee'),
        async: false, //同步
        idField: 'vipid',
        textField: 'vipname',
        loadMsg: '请稍候',
        mode: 'remote',
        onClickRow: function (rowIndex, rowData) {
            var name = rowData.vipname;
            $('#tj_name').val(name);
        },
        columns: [[
        { field: 'vipid', hidden: true },
        { field: 'vipname', title: '推荐人姓名', width: 80 },
        { field: 'vipsex', title: '性别', width: 40 },
        { field: 'vipcode', title: '推荐人卡号', width: 100 },
        { field: 'mobtel', title: '推荐人电话', width: 120 }
        ]]
    });
    $('#sumbit').linkbutton({ iconCls: 'icon-save', plain: true }).unbind("click").click(save);
    $('#undo').linkbutton({ iconCls: 'icon-undo', plain: true }).unbind("click").click(undo);
    $('#btnUpload').linkbutton();
    //初始化窗口
    $('#DivVIPPersonnel').window('init');
    $('#DivVIPPersonnel').window("open");
}

function uoPic() { 
//文件上传相关-----------------
var button = $('#btnUpload'), interval;
new AjaxUpload(button, {
    //action: 'upload-test.php',文件上传服务器端执行的地址
    action: '/Handler_Upload.ashx?filePath=VIP_Images',
    name: 'myfile',
    onSubmit: function (file, ext) {
        if (!(ext && /^(jpg|png|bmp)$/.test(ext))) {
            alert('文本格式不正确,请选择 jpg,png,bmp 格式的文件!', '系统提示');
            return false;
        };

        this.disable();
    },
    onComplete: function (file, response) {

        window.clearInterval(interval);

        // enable upload button
        this.enable();
        var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

        try {
            var result = eval("[" + k + "]");
            if (result[0].Error) {
                $.messager.progress('close');

                $.messager.alert("系统错误", result[0].Error, 'error');
            }
            else if (result[0].rows[0].result == "False") {

                $.messager.progress('close');

                $.messager.alert("提示", result[0].rows[0].message, 'error');
            }
            else {
                $("#userpicture").val(result[0].rows[0].message);
                
                $('#txtimgupload').html("");
               
                $("<img style='width:200px;'/>").appendTo($('#txtimgupload')).attr("src", result[0].rows[0].message);
                
            }
        } catch (ex) {
            $.messager.progress('close');

            $.messager.alert("提示", ex, 'error');
        }
    }
});
//文件上传相关-----------------

}

