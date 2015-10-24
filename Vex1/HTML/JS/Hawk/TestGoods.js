///试用品新增
///创建人:俞佳伟
///创建时间:2015-02-05

var m_state = [{ "id": "20", "text": "正常", "selected": true }, { "id": "99", "text": "禁用" }];
var m_st1_grade = [{ "id": "合格品", "text": "合格品", "selected": true }, { "id": "降级品", "text": "降级品" }];
var m_nMaxId = 1;//定义图片开始ID

//初始化页面
$(function () {

    //文件上传相关-----------------
    var button = $('#btnUp'), interval;
    $('#formGoods').find("input").blur(function () {
        if (this.id == "txtst1_supperierstyle" || this.id == "txtst2_supperiercolor") {
            var st1_SupperierStyle = $('#formGoods').find("#txtst1_supperierstyle").val()//取供应商款号
            var st2_SupperierColor = $('#formGoods').find("#txtst2_supperiercolor").val()//取供应商颜色
            //如果如果款号和颜色有一个为空不进行操作，返回
            if (st1_SupperierStyle == "" || st2_SupperierColor == "") {
                return;
            }
            else {
                $('#formGoods').find("#txtst2_supperierskc").val(st1_SupperierStyle + st2_SupperierColor)
            }
        }
        else {
            if ($('#formGoods').find("#txtst2_skccode").val() == "") {
                return;
            }
            else {
                updateFile(button, $('#formGoods').find("#txtst2_skccode").val() + "_" + m_nMaxId)
            }
        }
    });

    //加载供应商编码
    $('#formGoods #txtst1_suppliercode').combogrid({
        panelWidth: 200,
        url: GetWSRRURL('643a8280-09c8-4e52-aaff-1d27440b7d41') + "&XML=" + GetFormJson([], 'SupplierInfo'),
        idField: 'sp1_suppliercode',
        textField: 'sp1_name',
        mode: 'remote',
        required: true,
        columns: [[
                { field: 'sp1_suppliercode', title: '供应商编号', width: 80 },
                { field: 'sp1_name', title: '供应商简称', width: 80 }
        ]]
    });

    //加载品牌名称
    $('#formGoods #txtst1_br1_brandcode').combogrid({
        url: GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&XML=" + GetFormJson([], 'GETBRAND'),
        panelWidth: 160,
        idField: 'br1_brandcode',
        textField: 'br1_name',
        mode: 'remote',
        required: true,
        columns: [[
                { field: 'br1_brandcode', title: '品牌编码', width: 55 },
                { field: 'br1_name', title: '品牌名称', width: 80 }
        ]]
    });

    //加载年份combobox下拉
    $('#formGoods #txtst1_years').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "YEAR" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () { autoSKC(); }
    });

    //加载单位下拉
    $('#formGoods #txtst1_unit').combogrid({
        panelWidth: 100,
        url: GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "UNIT" + "'",
        idField: 'ct1_optionsvalues',
        textField: 'ct1_options',
        mode: 'remote',
        required: true,
        columns: [[
            { field: 'ct1_options', title: '单位', width: 80 },
        ]]
    });
    $('#formGoods #txtst1_unit').combogrid('setValue', 'EA');

    //加载品类combobox下拉
    $('#formGoods #txtst1_category').combobox({
        url: GetComboxALLColumnWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITCL" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function (data) {
            autoSKC();
            //加载大类combobox下拉
            $('#formGoods #txtst1_largeclass').combobox({
                url: GetComboxALLColumnWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGR" + "' and CT1_FatherID='" + data.CT1_ID + "'",
                panelHeight: '120',
                editable: false,
                valueField: 'id',
                textField: 'text',
                required: true,
                async: false,//同步,
                onSelect: function (data) {
                    //加载小类combobox下拉
                    var data = $.ajax({
                        url: GetComboxALLColumnWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGL" + "' and CT1_FatherID='" + data.CT1_ID + "'",
                        type: 'post',
                        async: false//同步,
                    });

                    var data1 = $.parseJSON(data.responseText)
                    $('#formGoods #txtst1_smallclass').combobox({
                        data: data1,
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: 'auto',
                        editable: false
                    });

                    if (data1.length == 0 || data1[0].id == "") {
                        $('#formGoods #txtst1_smallclass').combobox({ required: false })
                        $('#formGoods #txtst1_smallclass').combobox('disable')
                    }
                    else {
                        $('#formGoods #txtst1_smallclass').combobox({ required: true })
                        $('#formGoods #txtst1_smallclass').combobox('enable')
                    }
                    autoSKC();
                }
            });
        }
    });
    //初始化小类大类combobox
    $('#formGoods #txtst1_smallclass').combobox({ required: true });
    $('#formGoods #txtst1_largeclass').combobox({ required: true });

    //加载等级combobox下拉
    $('#formGoods #txtst1_grade').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_st1_grade,
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    //加载颜色combobox下拉
    $('#formGoods #txtst2_color').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "COLO" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () { autoSKC1(); }
    });

    //加载尺码组combobox下拉
    $('#formGoods #txtst2_sizegroup').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "SDGP" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true
    });

    //加载产地
    $('#formGoods #txtst1_provenance').combogrid({
        panelWidth: 100,
        url: GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "COTY" + "'",
        idField: 'ct1_optionsvalues',
        textField: 'ct1_options',
        mode: 'remote',
        required: false,
        sortName: 'ct1_options', //排序字段
        columns: [[
            { field: 'ct1_options', title: '国家', width: 80 },
        ]]
    });

    //加载执行标准txtst1_standard下拉
    $('#formGoods #txtst1_standard').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "STRD" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //加载安全技术类别txtst1_safetechnology下拉
    $('#formGoods #txtst1_safetechnology').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "STCL" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //加载币种combobox下拉
    $('#formGoods #txtst1_currency').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "CUCD" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () {
            var bzUnit = $("#txtst1_currency").combobox('getValue'); //根据币种值联动采购价中的价格单位
            $("#txtst2_purchaseprice_unit").val(bzUnit);
        }
    });

    //状态下拉
    $('#formGoods #txtst1_state').combobox({
        data: m_state,
        panelHeight: '90',
        editable: true,
        valueField: 'id',
        textField: 'text'
    });

    //日期格式转换
    $('#txtst1_productdate').datebox({
        formatter: timeFormatter
    });

    //初始化时 赋值采购单价、吊牌单价 为0
    $('#txtst2_saleprice').val(0);
    $('#txtst2_purchaseprice').val(0);
});

//自动生成SKC
function autoSKC() {
    var st1_Years = $('#formGoods').find("#txtst1_years").combobox('getValue'); //取年份
    if (st1_Years != "") {
        st1_Years = st1_Years.substr(2, 2);
    }
    var st1_Category = $('#formGoods').find("#txtst1_category").combobox('getValue'); //取品类
    var st1_Largeclass = $('#formGoods').find("#txtst1_largeclass").combobox('getValue'); //取大类
    var st2_Color = $('#formGoods').find("#txtst2_color").combobox('getValue'); //取SKC颜色
    //如果品类，大类为空返回
    if (st1_Years == "" || st1_Category == "" || st1_Largeclass == "") {
        return;
    }
    else {
        //Ajax取最大值
        var data = [];
        data[data.length] = { "name": "txtst1_years", "value": st1_Years };
        data[data.length] = { "name": "txtst1_category", "value": st1_Category };
        data[data.length] = { "name": "txtst1_largeclass", "value": st1_Largeclass };
        data[data.length] = { "name": "txtdivi", "value": "LX" };
        var xmlData = GetFormJson(data, 'GETMAXSKCTEST');
        htmlobj = $.ajax({
            url: GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8'),
            data: { "XML": xmlData },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        if (result.rows[0]['maxskc'] == "") {

        }
        else {
            $('#formGoods').find("#txtst2_st1_stylecode").val(result.rows[0]['maxskc']);  //加上颜色
        }

        //如果颜色为空返回，不生成SKC如果有自动生成SKC
        if (st2_Color == "") {
            return;
        }
        else {
            $('#formGoods').find("#txtst2_skccode").val($('#formGoods').find("#txtst2_st1_stylecode").val() + st2_Color);
        }
    }
}

//需求更改，单独颜色联动剥离出来。
function autoSKC1() {
    var st1_Years = $('#formGoods').find("#txtst1_years").combobox('getValue'); //取年份
    var st1_Category = $('#formGoods').find("#txtst1_category").combobox('getValue'); //取品类
    var st1_Largeclass = $('#formGoods').find("#txtst1_largeclass").combobox('getValue'); //取大类
    var st2_Color = $('#formGoods').find("#txtst2_color").combobox('getValue'); //取SKC颜色
    //如果季节，品类，大类为空返回
    if (st1_Years == "" || st1_Category == "" || st1_Largeclass == "") {
        return;
    }
    if (st2_Color == "") {
        return;
    }
    else {
        $('#formGoods').find("#txtst2_skccode").val($('#formGoods').find("#txtst2_st1_stylecode").val() + st2_Color);
    }
}

//新增修改保存操作
function formGoodsSubmit(type) {
    $('#formGoods').form('submit', {
        onSubmit: function (e) {
            $('#formGoods').form('validate')
            if ($('#formGoods').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }

            if ($('#formGoods').find("#txtst2_st1_stylecode").val() == "" || $('#formGoods').find("#txtst2_skccode").val() == "") {
                $.messager.alert("提示", "数据异常请联系信息管理部！", 'error');
                return false;
            }
            var data = [];
            //考虑到多种控制，直接每次保存都获取更新或者新增
            data[data.length] = { "name": "txtst1_id", "value": $('#formGoods').find("#txtst1_id").val() };
            data[data.length] = { "name": "txtst2_id", "value": $('#formGoods').find("#txtst2_id").val() };
            data[data.length] = { "name": "txtst1_suppliercode", "value": $('#formGoods').find("#txtst1_suppliercode").combogrid('getValue') };
            data[data.length] = { "name": "txtst1_br1_brandcode", "value": $('#formGoods').find("#txtst1_br1_brandcode").combogrid('getValue') };
            data[data.length] = { "name": "txtst2_imagepath", "value": $('#formGoods').find("#txtst2_imagepath").val() };
            data[data.length] = { "name": "txtst1_supperierstyle", "value": $('#formGoods').find("#txtst1_supperierstyle").val() };
            data[data.length] = { "name": "txtst2_supperiercolor", "value": $('#formGoods').find("#txtst2_supperiercolor").val() };
            data[data.length] = { "name": "txtst2_supperierskc", "value": $('#formGoods').find("#txtst2_supperierskc").val() };
            data[data.length] = { "name": "txtst1_years", "value": $('#formGoods').find("#txtst1_years").combobox('getValue') };
            data[data.length] = { "name": "txtst1_commodity", "value": $('#formGoods').find("#txtst1_commodity").val() };
            data[data.length] = { "name": "txtst1_unit", "value": $('#formGoods').find("#txtst1_unit").combogrid('getValue') };
            data[data.length] = { "name": "txtst1_category", "value": $('#formGoods').find("#txtst1_category").combobox('getValue') };
            data[data.length] = { "name": "txtst1_largeclass", "value": $('#formGoods').find("#txtst1_largeclass").combobox('getValue') };
            data[data.length] = { "name": "txtst1_smallclass", "value": $('#formGoods').find("#txtst1_smallclass").combobox('getText') };
            data[data.length] = { "name": "txtst1_series", "value": $('#formGoods').find("#txtst1_series").val() }; //系列
            data[data.length] = { "name": "txtst1_styleline", "value": $('#formGoods').find("#txtst1_styleline").val() }; //风格线
            data[data.length] = { "name": "txtst2_color", "value": $('#formGoods').find("#txtst2_color").combogrid('getValue') };
            data[data.length] = { "name": "txtst2_st1_stylecode", "value": $('#formGoods').find("#txtst2_st1_stylecode").val() };
            data[data.length] = { "name": "txtst2_skccode", "value": $('#formGoods').find("#txtst2_skccode").val() };
            data[data.length] = { "name": "txtst1_grade", "value": $('#formGoods').find("#txtst1_grade").combobox('getText') };
            data[data.length] = { "name": "txtst1_currency", "value": $('#formGoods').find("#txtst1_currency").combobox('getValue') };
            data[data.length] = { "name": "txtst2_sizegroup", "value": $('#formGoods').find("#txtst2_sizegroup").combobox('getValue') };
            data[data.length] = { "name": "txtst1_provenance", "value": $('#formGoods').find("#txtst1_provenance").combobox('getText') };
            data[data.length] = { "name": "txtst1_ingredients", "value": $('#formGoods').find("#txtst1_ingredients").val() };
            data[data.length] = { "name": "txtst1_standard", "value": $('#formGoods').find("#txtst1_standard").combobox('getValue') };
            data[data.length] = { "name": "txtst1_safetechnology", "value": $('#formGoods').find("#txtst1_safetechnology").combobox('getValue') };
            data[data.length] = { "name": "txtst2_saleprice", "value": $('#formGoods').find("#txtst2_saleprice").val() };
            data[data.length] = { "name": "txtst2_purchaseprice", "value": $('#formGoods').find("#txtst2_purchaseprice").val() };
            data[data.length] = { "name": "txtst1_state", "value": $('#formGoods').find("#txtst1_state").combobox('getValue') };
            data[data.length] = { "name": "txtst1_usedmethod", "value": $('#formGoods').find("#txtst1_usedmethod").val() };     //使用方法
            data[data.length] = { "name": "txtst1_attention", "value": $('#formGoods').find("#txtst1_attention").val() };       //注意事项
            data[data.length] = { "name": "txtst1_permitno", "value": $('#formGoods').find("#txtst1_permitno").val() };         //批准文号
            data[data.length] = { "name": "txtst1_fragrance", "value": $('#formGoods').find("#txtst1_fragrance").val() };       //香味
            data[data.length] = { "name": "txtst1_netweight", "value": $('#formGoods').find("#txtst1_netweight").val() };       //净含量
            data[data.length] = { "name": "txtst1_productdate", "value": $('#formGoods').find("#txtst1_productdate").datebox('getValue') };   //生产日期
            data[data.length] = { "name": "txtst1_expiration", "value": $('#formGoods').find("#txtst1_expiration").val() };     //保质期


            var xmlData = GetFormJson(data, 'EDITGoods');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('0299c774-0dff-496b-b7dc-4fae25e96f9d'),
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
                            if (type == '保存并继续新建') {
                                addGoods();
                            }
                            else if (type == '保存') {
                                $('#formGoods #txtst1_years').combobox('disable');
                                $('#formGoods #txtst1_category').combobox('disable');
                                $('#formGoods #txtst1_largeclass').combobox('disable');
                                $('#formGoods #txtst1_smallclass').combobox('disable');
                                $("#btnUp").show();
                                $.messager.alert("提示", result[0].rows[0].message);
                                $('#formGoods #txtst1_id').val(result[0].rows[1].message);
                                $('#formGoods #txtst2_id').val(result[0].rows[2].message);
                                $('#DivGoods').window('close');
                            }
                            //$('#tab_list').datagrid("unselectAll");
                            //$('#tab_list').datagrid("reload");

                            var button = $('#btnUp');
                            updateFile(button, $('#formGoods').find("#txtst2_skccode").val() + "_" + m_nMaxId);
                        }
                    } catch (ex) {
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

//新增品牌
function addGoods() {
    $('#DivGoods').window({
        title: "商品新增",
        top: 20,
        width: 1100,
        height: 800,
        modal: true,
        maximized: true
    });
    $('#formGoods').form('clear');
    $('#formGoods #txtst1_state').combobox('setValue', "20");
    $('#formGoods #txtst1_grade').combobox('setValue', "合格品");
    $('#formGoods #txtst1_unit').combogrid('setValue', "EA");
    $('#formGoods #txtst1_years').combobox('enable');
    $('#formGoods #txtst1_category').combobox('enable');
    $('#formGoods #txtst1_largeclass').combobox('enable');
    $('#formGoods #txtst1_smallclass').combobox('enable');
    $('#txtst2_saleprice').val('0');
    $('#txtst2_purchaseprice').val('0');
    $("#btnUp").hide();
    $("#Select").empty();//清空Select
    $('#txtimgupload').html("");
}

//增加选择
function col_add(text) {
    var selObj = $("#Select");
    selObj.append("<option>" + text + "</option>");
}

// 删除  
function col_delete() {
    var selOpt = $("#Select option:selected");
    selOpt.remove();
    viewSelected();
    formGoodsSubmit('保存');
}

//选择
function selectviw() {
    var selOpt = $("#Select option:selected");
    if (selOpt == undefined || selOpt.length == 0) {
        return;
    } else {
        $('#txtimgupload').html("");
        $("<img style='width:80px;height:90px'/>").appendTo($('#txtimgupload')).attr("src", selOpt[0].innerHTML);
    }
}

//文件上传
function updateFile(button, fileName) {
    new AjaxUpload(button, {
        action: '/Handler_Upload.ashx?filePath=HawkGoods&fileName=' + fileName,
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|JPG|BMP|bmp)$/.test(ext))) {
                alert('图片格式不正确,请选择 jpg,bmp 格式的文件!', '系统提示');
                return false;
            }
            button.val('文件上传中');
            this.disable();
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) {
                    button.val(text + '.');
                } else {
                    button.val('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            button.val('上传');
            window.clearInterval(interval);
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
                    $('#txtimgupload').html("");
                    var value = result[0].rows[0].message;
                    $("<img style='width:80px;height:90px'/>").appendTo($('#txtimgupload')).attr("src", value);
                    col_add(value);
                    viewSelected();
                    formGoodsSubmit('保存');
                    maxImagepath();

                    updateFile(button, $('#formGoods').find("#txtst2_skccode").val() + "_" + m_nMaxId);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });
    //文件上传相关-----------------
}

//计算select控件里面所有值，加付给图片路径
function viewSelected() {
    var m_allSelectOption = ""
    var select = document.getElementById('Select')
    for (i = 0; i < select.length; i++) {
        if (i == select.length - 1) {
            m_allSelectOption += select.options[i].text;
        } else {
            m_allSelectOption += select.options[i].text + ",";
        }
    }
    $('#formGoods #txtst2_imagepath').val(m_allSelectOption);
}

//计算图片最大值
function maxImagepath() {
    m_nMaxId = 0;
    var select = document.getElementById('Select')
    for (var i = 0; i < select.length; i++) {
        if (parseInt(select.options[i].text.substr(32, 1)) > m_nMaxId) {
            m_nMaxId = parseInt(select.options[i].text.substr(32, 1));
        }
    }
    m_nMaxId++;
}

//日期格式转换
function timeFormatter(date) {
    return date.getFullYear() + '年' + (date.getMonth() + 1) + '月' + date.getDate() + '日';
}
function timeParser(date) {
    //var newDate = date.replace("年", "/").replace("月", "/").replace("日", "");
    return date;
}


//新建已有商品 为试用品 事件
function btnNewTestGood() {
    $('#GoodSelect').show();
    $('#GoodSelect').window({
        title: '请输入已建好的商品',
        top: 20,
        modal: true,
        height: 130,
        width: 250,
        resizable: false
    });
}

//确认按钮事件,根据SKC查询
function btnSRHGood() {
    var skc = $('#txtSKC').val();
    var data = [];
    data[data.length] = { "name": "txtst2_skccode", "value": skc };
    data[data.length] = { "name": "txtzt", "value": "LX" };
    var xmlData = GetFormJson(data, 'GoodsInfoForPageList');
    var htmlobj = $.ajax({
        url: GetWSRRURL('0299c774-0dff-496b-b7dc-4fae25e96f9d'),
        type: 'post',
        async: false, //异步,
        data: { "XML": xmlData },
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.rows.length < 1) {
        alert('没有相关商品');

        return false;
    }

    //数据填充
    $('#txtst1_suppliercode').combogrid('setValue', result.rows[0].st1_suppliercode); //供应商编码
    $('#txtst1_br1_brandcode').combogrid('setValue', result.rows[0].st1_br1_brandcode); //品牌
    //$('#txtst1_id').val(result.rows[0].st1_id);
    //$('#txtst2_id').val(result.rows[0].st2_id);

    $('#txtst1_supperierstyle').val(result.rows[0].st1_supperierstyle);  //供应商款号
    $('#txtst2_supperiercolor').val(result.rows[0].st2_supperiercolor);  //供应商颜色/简
    $('#txtst2_supperierskc').val(result.rows[0].st2_supperierskc);    //供应商SKC
    $('#txtst1_years').combobox('setValue', result.rows[0].st1_years);      //年份
    $('#txtst1_commodity').val(result.rows[0].st1_commodity);       //品名
    $('#txtst1_unit').combogrid('setValue', result.rows[0].st1_unit);       //单位

    $('#txtst1_currency').combobox('setValue', result.rows[0].st1_currency);   //币种
    $('#txtst1_category').combobox('setValue', result.rows[0].st1_category);   //款式品类
    $('#txtst1_largeclass').combobox('setValue', result.rows[0].st1_largeclass);                       //款式大类
    $('#txtst1_smallclass').combobox('setValue', result.rows[0].st1_smallclass);                       //款式小类
    $('#txtst1_grade').combobox('setValue', result.rows[0].st1_grade);      //等级
    $('#txtst2_color').combobox('setValue', result.rows[0].st2_color);      //颜色/简
    autoSKC();//款号
    autoSKC1();//SKC    
    $('#txtst2_sizegroup').combobox('setValue', result.rows[0].st2_sizegroup);   //尺码组
    $('#txtst1_provenance').combogrid('setValue', result.rows[0].st1_provenance);       //产地
    $('#txtst1_standard').combobox('setValue', result.rows[0].st1_standard);   //执行标准
    $('#txtst1_safetechnology').combobox('setValue', result.rows[0].st1_safetechnology); //安全技术类别
    $('#txtst1_permitno').val(result.rows[0].st1_permitno);      //批准文号
    $('#txtst1_styleline').val(result.rows[0].st1_styleline);  //风格线
    $('#txtst1_series').val(result.rows[0].st1_series);    //系列
    $('#txtst1_fragrance').val(result.rows[0].st1_fragrance); //香味
    $('#txtst1_netweight').val(result.rows[0].st1_netweight); //净含量
    $('#txtst1_usedmethod').val(result.rows[0].st1_usedmethod); //使用方法
    $('#txtst1_attention').val(result.rows[0].st1_attention); //注意事项
    $('#txtst1_ingredients').val(result.rows[0].st1_ingredients); //成分
    $('#txtst2_saleprice').val(result.rows[0].st2_saleprice); //吊牌价
    $('#txtst2_purchaseprice_unit').val(result.rows[0].st1_currency); //采购价单位
    $('#txtst2_purchaseprice').val(result.rows[0].st2_purchaseprice); //采购价
    $('#txtst1_state').combobox('setValue', result.rows[0].st1_state); //状态
    $('#txtst1_productdate').val(result.rows[0].st1_productdate); //生产日期
    $('#txtst1_expiration').val(result.rows[0].st1_expiration); //保质期
    $('#txtst1_lmuser').val(result.rows[0].st1_lmuser); //更新人
    $('#txtst1_lmdt').val(result.rows[0].st1_lmdt); //更新日期

    $('#GoodSelect').window('close');
    $('#txtSKC').val("");
}

//取消按钮事件
function btnCancel() {
    $('#txtSKC').val("");
    $('#GoodSelect').window('close');
}