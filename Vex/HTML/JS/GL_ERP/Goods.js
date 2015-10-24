/// JS名：Goods.js
/// 说明：商品
/// 创建人：郭琦琦 
/// 创建日期：2014-06-06

var m_state = [{ "id": "20", "text": "正常", "selected": true }, { "id": "99", "text": "禁用" }];
var m_st1_grade = [{ "id": "合格品", "text": "合格品", "selected": true }, { "id": "降级品", "text": "降级品" }];
var m_st2_upload = [{ "id": "未导入", "text": "未导入" }, { "id": "执行成功", "text": "执行成功" }, { "id": "失败", "text": "失败" }, { "id": "全部", "text": "全部", "selected": true }];
var m_allSelectOption = ""//定义select控件所有数据
var m_nMaxId = 1;//定义图片开始ID

$(function () {
    //文件上传相关-----------------
    var button = $('#btnUp'), interval;
    $('#formGoods').find("input").blur(function () {
        if (this.id == "txtst1_supperierstyle" || this.id == "txtst2_supperiercolor") {
            var st1_SupperierStyle = $('#formGoods').find("#txtst1_supperierstyle").val()//取供应商款号
            if (getByteLen(st1_SupperierStyle) > 20) {//供应商款号 不能超过20个字符
                $('#formGoods').find("#txtst1_supperierstyle").val('');
                alert('供应商款号不能超过20个字符');
                return false;
            }
            var st2_SupperierColor = $('#formGoods').find("#txtst2_supperiercolor").val()//取供应商颜色
            //如果如果款号和颜色有一个为空不进行操作，返回
            if (st1_SupperierStyle == "" || st2_SupperierColor == "") {
                return;
            }
            else {
                $('#formGoods').find("#txtst2_supperierskc").val(st1_SupperierStyle + st2_SupperierColor)
            }
        }
        else if (this.id == "txtst2_purchaseprice") {
            var st2_PurchasePrice = $('#formGoods').find("#txtst2_purchaseprice").val()//取采购价计算参考价格
            if (st2_PurchasePrice == "") {
                return;
            }
            else {
                $('#formGoods').find("#txtst2_refsaleprice").val(st2_PurchasePrice * 1 * (1 + 0.17) * (1 + 0.16) * (1 + 0.05) * 3)
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
    //供应商品牌联动
    //$('#formGoods #txtbr1_brandname').combobox({
    //    required: true
    //})

    //加载供应商下拉
    $('#formGoods #txtst1_suppliercode').combogrid({
        panelWidth: 200,
        url: GetWSRRURL('d15d8c7d-4eb5-47c8-a2ba-fe3b95bb811b') + "&XML=" + GetFormJson([], 'SupplierInfo'),
        idField: 'sp1_suppliercode',
        textField: 'sp1_name',
        mode: 'remote',
        required: true,
        columns: [[
                { field: 'sp1_suppliercode', title: '供应商编号', width: 80 },
                { field: 'sp1_name', title: '供应商简称', width: 80 }
        ]]
    });


    //加载品牌下拉
    var url = GetWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&XML=" + GetFormJson([], 'GETBRAND');

    $('#formGoods #txtbr1_brandname').combogrid({
        url: url,
        panelWidth: 200,
        required: true,
        idField: 'br1_brandcode',
        textField: 'br1_name',
        mode: 'remote',
        columns: [[
                { field: 'br1_brandcode', title: '品牌编号', width: 60 },
                { field: 'br1_name', title: '品牌名称', width: 80 }
        ]]
    });


    

    //加载年份combobox下拉
    $('#formGoods #txtst1_years').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "YEAR" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () { autoSKC() }
    });

    //加载织法combobox下拉
    $('#formGoods #txtst1_attr04').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "KNIT" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //7-15郭琦琦添加执行标准和安全下拉
    //加载执行标准txtst1_standard下拉
    $('#formGoods #txtst1_standard').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "STRD" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //加载安全技术类别txtst1_safetechnology下拉
    $('#formGoods #txtst1_safetechnology').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "STCL" + "'",
        panelHeight: 120,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //导入状态下拉
    $('#formselect #txtst2_upload').combobox({
        data: m_st2_upload,
        panelHeight: '90',
        editable: true,
        valueField: 'id',
        textField: 'text'
    });


    $('#formGoods #txtst1_unit').combogrid({
        panelWidth: 100,
        url: GetWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "UNIT" + "'",
        idField: 'ct1_optionsvalues',
        textField: 'ct1_options',
        mode: 'remote',
        required: true,
        columns: [[
            { field: 'ct1_options', title: '单位', width: 80 },
        ]]
    });


    //加载季节combobox下拉
    $('#formGoods #txtst1_season').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "SSON" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () { autoSKC() }
    });

    //初始化小类大类combobox
    $('#formGoods #txtst1_smallclass').combobox({ required: true });
    $('#formGoods #txtst1_largeclass').combobox({ required: true });

    //加载品类combobox下拉
    $('#formGoods #txtst1_category').combobox({
        url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITCL" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        //onSelect: function () { autoSKC() },
        onSelect: function (data) {
            autoSKC();
            //加载大类combobox下拉
            $('#formGoods #txtst1_largeclass').combobox({
                url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGR" + "' and CT1_FatherID='" + data.CT1_ID + "'",
                panelHeight: '120',
                editable: false,
                valueField: 'id',
                textField: 'text',
                required: true,
                async: false,//同步,
                onSelect: function (data) {
                    //加载小类combobox下拉
                    var data = $.ajax({
                        url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGL" + "' and CT1_FatherID='" + data.CT1_ID + "'",
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
                    autoSKC()
                }
                //onSelect: function () { autoSKC() }
            });
        }

    });

    //加载颜色combobox下拉
    $('#formGoods #txtst2_color').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "COLO" + "'",
        panelHeight: '120',
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () { autoSKC1() }
    });

    //加载等级combobox下拉
    $('#formGoods #txtst1_grade').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_st1_grade,
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    //加载币种combobox下拉
    $('#formGoods #txtst1_currency').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "CUCD" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true
    });

    //加载尺码组combobox下拉
    $('#formGoods #txtst2_sizegroup').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "SDGP" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true
    });

    //加载产地combobox下拉
    //$('#formGoods #txtst1_provenance').combobox({
    //    url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "COTY" + "'",
    //    panelHeight: '120',
    //    editable: true,
    //    valueField: 'id',
    //    textField: 'text'
    //    //required: true
    //});

    $('#formGoods #txtst1_provenance').combogrid({
        panelWidth: 100,
        url: GetWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "COTY" + "'",
        idField: 'ct1_optionsvalues',
        textField: 'ct1_options',
        mode: 'remote',
        required: false,
        sortName: 'ct1_options', //排序字段
        columns: [[
            { field: 'ct1_options', title: '国家', width: 80 },
        ]]
    });

    //加载状态combobox下拉
    $('#formGoods #txtst1_state').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_state,
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    ////加载分割线ST1_Attr01combobox下拉
    //$('#formGoods #txtst1_attr01').combobox({
    //    url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "STYLE" + "'",
    //    panelHeight: 'auto',
    //    editable: false,
    //    valueField: 'id',
    //    textField: 'text',
    //    required: true
    //});

    //初始化div关闭
    $('#DivGoods').window({
    })
    .window('close');

    //初始化上传按钮隐藏
    $("#btnUp").hide();

    //初始化加载商品数据
    var url = GetWSRRURL('bef763a1-9f65-46b6-abda-2316c6bd6798') + "&XML=" + GetFormJson([], 'GoodsInfoForPageList');
    initGird(url);

})
//加载数据
function initGird(url) {
    $('#tab_list').datagrid(
            {
                title: '商品', //表格标题
                url: url,
                sortName: ' st2_rgdt ', //排序字段
                idField: 'st2_id', //标识字段,主键
                width: '90%', //宽度
                height: $(document).height() - 100, //高度
                nowrap: false, //是否换行，True 就会把数据显示在一行里
                remoteSort: true, //定义是否从服务器给数据排序
                collapsible: false, //可折叠
                sortOrder: 'DESC', //排序类型
                sortable: true,
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                fit: true,
                pagination: true, //是否开启分页
                pageSize: 20, //默认一页数据条数 
                rownumbers: true,//行号
                columns: [[
                    { field: 'st2_imagepath', title: '款图' },
                    { field: 'st1_suppliercode', title: '供应商编号', width: 60, search: true, sortable: true },
                    { field: 'br1_brandname', title: '品牌名称', width: 50, search: true, sortable: true },
                    { field: 'st1_commodity', title: '品名', width: 40, search: true, sortable: true },
                    { field: 'st1_supperierstyle', title: '供应商款号', width: 70, search: true, sortable: true },
                    { field: 'st2_supperiercolor', title: '供应商颜色/简', width: 80, search: true, sortable: true },
                    { field: 'st2_supperierskc', title: '供应商SKC', width: 80, search: true, sortable: true },
                    { field: 'st2_st1_stylecode', title: '款号', width: 80, search: true, sortable: true },
                    { field: 'st2_color', title: '颜色/简', width: 40, search: true, sortable: true },
                    { field: 'st2_skccode', title: 'SKC', width: 90, search: true, sortable: true },
                    { field: 'st1_unitname', title: '单位', width: 30, search: true, sortable: true },
                    { field: 'st2_purchaseprice', title: '采购价', width: 40, search: true, sortable: true, formatter: Formater.Account },
                    { field: 'st2_saleprice', title: '吊牌价', width: 40, search: true, sortable: true, formatter: Formater.Account },
                    { field: 'st1_years', title: '年份', width: 40, search: true, sortable: true },
                    { field: 'st1_season', title: '季节', width: 40, search: true, sortable: true },
                    { field: 'st1_category', title: '款式种类', width: 40, search: true, sortable: true },
                    { field: 'st1_largeclass', title: '款式大类', width: 40, search: true, sortable: true },
                    { field: 'st1_smallclass', title: '款式小类', width: 40, search: true, sortable: true },
                    { field: 'st1_provenance', title: '产地', width: 40, search: true, sortable: true },
                    { field: 'st2_ingredients', title: '成分', width: 40, search: true, sortable: true },
                    { field: 'st1_attr01', title: '系列', width: 40, search: true, sortable: true },
                    { field: 'st1_attr02', title: '风格线', width: 40, search: true, sortable: true },
                    //{ field: 'st1_attr03', title: '规格', width: 40, search: true, sortable: true },
                    { field: 'st1_attr04', title: '织法', width: 60, search: true, sortable: true },
                    { field: 'st1_grade', title: '等级', width: 40, search: true, sortable: true },
                    { field: 'st1_standard', title: '执行标准', width: 50, search: true, sortable: true },
                    { field: 'st1_safetechnology', title: '安全技术类别', width: 50, search: true, sortable: true },
                    { field: 'st2_state', title: '状态', width: 40, search: true, sortable: true },
                    { field: 'st2_rgdt', title: 'SKC创建时间', width: 80, search: true, sortable: true, formatter: Formater.Date },
                    { field: 'st2_rguser', title: '创建人', width: 60, search: true, sortable: true },
                    { field: 'st2_upload', title: '导入状态', width: 60, search: true, sortable: true }
                ]],
                toolbar: [
                {
                    id: 'btn_Add',
                    text: '新增',
                    iconCls: 'icon-add',
                    handler: function () {
                        addGoods();
                    }
                },
                '-',
                {
                    id: 'btn_Edit',
                    text: '修改',
                    iconCls: 'icon-edit',
                    handler: function () {
                        editGoods();
                    }
                }
                ]
            });
    var $dg = $('#tab_list');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'st2_imagepath');
    if (col != null) {
        col.formatter = function (value) {
            var strs = new Array(); //定义一数组 
            strs = value.split(","); //字符分割 
            var date = "<a href='" + strs[0] + "' target='_blank'><img  src='" + strs[0] + "' style='height:60px'/></a>";
            this.formatDataType = "Pic";
            return date;
        }
    }
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'st2_state');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(m_state, value);
        }
    }
    $dg.datagrid();
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
    $('#formGoods #txtst2_sizegroup').combobox('enable');
    $('#formGoods').form('clear');
    $('#formGoods #txtst1_state').combobox('setValue', "20");
    $('#formGoods #txtst1_grade').combobox('setValue', "合格品");
    $('#formGoods #txtst1_unit').combogrid('setValue', "PCS");
    $('#formGoods #txtst1_season').combobox('enable');
    $('#formGoods #txtst1_years').combobox('enable');
    $('#formGoods #txtst1_category').combobox('enable');
    //$('#formGoods #txtst2_color').combobox('enable');
    $('#formGoods #txtst1_largeclass').combobox('enable');
    $('#formGoods #txtst1_smallclass').combobox('enable');
    $('#formGoods #txtst2_sizegroup').combobox('enable');
    $('#txtst2_saleprice').val('0');
    $('#txtst2_purchaseprice').val('0');
    $('#txtst2_refsaleprice').val('0');
    $("#btnUp").hide();
    $("#Select").empty();//清空Select
    $('#txtimgupload').html("");
}

//修改
function editGoods() {
    var selectGoods = $('#tab_list').datagrid('getSelected')
    if (!selectGoods) {
        alert('请选择一行');
        return;
    }
    $('#DivGoods').window({
        title: "商品修改",
        top: 20,
        width: 1100,
        height: 800,
        modal: true,
        maximized: true

    });

    $("#Select").empty();//清空Select
    var selectSt2_Imagepath = selectGoods.st2_imagepath
    var strs = new Array(); //定义一数组 
    strs = selectSt2_Imagepath.split(","); //字符分割 
    //循环数组添加到select
    for (i = 0; i < strs.length ; i++) {
        //if (i != strs.length - 1) {
        if (strs[i] != "") {
            col_add(strs[i]);
            //}
        }
    }

    $('#formGoods #txtst1_smallclass').combobox({ required: false })
    $('#formGoods #txtst2_imagepath').val(selectGoods.st2_imagepath);//图片
    $('#formGoods #txtst2_id').val(selectGoods.st2_id);//SKCGUID
    $('#formGoods #txtst1_id').val(selectGoods.st1_id);//SKCGUID
    $('#formGoods #txtst1_suppliercode').combogrid('setValue', selectGoods.st1_suppliercode);//供应商编号
    //$('#formGoods #txtbr1_brandname').combogrid('setValue', selectGoods.br1_brandname);//品牌名
    $('#formGoods #txtbr1_brandname').combogrid('setValue', selectGoods.st1_br1_brandcode);
    //$('#formGoods #txtst1_br1_brandcode').val(selectGoods.st1_br1_brandcode);//品牌编号
    $('#formGoods #txtst1_supperierstyle').val(selectGoods.st1_supperierstyle);//供应商款号
    $('#formGoods #txtst2_supperiercolor').val(selectGoods.st2_supperiercolor);//供应商颜色
    $('#formGoods #txtst2_supperierskc').val(selectGoods.st2_supperierskc);//供应商SKC
    $('#formGoods #txtst1_years').combobox('setValue', selectGoods.st1_years);//年
    $('#formGoods #txtst1_season').combobox('setValue', selectGoods.st1_season);//季节
    $('#formGoods #txtst1_commodity').val(selectGoods.st1_commodity);//品名
    $('#formGoods #txtst1_unit').combogrid('setValue', selectGoods.st1_unit);//单位
    $('#formGoods #txtst1_category').combobox('setValue', selectGoods.st1_category);//款式品类
    $('#formGoods #txtst1_largeclass').combobox('setValue', selectGoods.st1_largeclass);//款式大类
    $('#formGoods #txtst1_smallclass').combobox('setValue', selectGoods.st1_smallclass);//款式小类
    $('#formGoods #txtst1_attr01').val(selectGoods.st1_attr01);//产品线
    $('#formGoods #txtst1_attr02').val(selectGoods.st1_attr02);//产品线
    $('#formGoods #txtst1_attr04').combobox('setValue', selectGoods.st1_attr04);//织法
    $('#formGoods #txtst2_color').combobox('setValue', selectGoods.st2_color);//颜色/简
    $('#formGoods #txtst2_st1_stylecode').val(selectGoods.st2_st1_stylecode);//款号
    $('#formGoods #txtst2_skccode').val(selectGoods.st2_skccode);//SKC
    $('#formGoods #txtst1_grade').combobox('setValue', selectGoods.st1_grade);//等级
    $('#formGoods #txtst1_currency').combobox('setValue', selectGoods.st1_currency);//币种
    $('#formGoods #txtst2_sizegroup').combobox('setValue', selectGoods.st2_sizegroup);//尺码组
    $('#formGoods #txtst1_provenance').combogrid('setValue', selectGoods.st1_provenance);//产地
    $('#formGoods #txtst2_ingredients').val(selectGoods.st2_ingredients);//成分
    $('#formGoods #txtst1_standard').combobox('setValue', selectGoods.st1_standard);//执行标准修改
    $('#formGoods #txtst1_safetechnology').combobox('setValue', selectGoods.st1_safetechnology);//执行标准修改
    $('#formGoods #txtst2_saleprice').val(selectGoods.st2_saleprice);//吊牌价
    $('#formGoods #txtst2_refsaleprice').val(selectGoods.st2_refsaleprice);//参考价格
    $('#formGoods #txtst2_purchaseprice').val(selectGoods.st2_purchaseprice);//采购价
    $('#formGoods #txtst1_state').combobox('setValue', selectGoods.st1_state);//状态
    $('#formGoods #txtst1_lmuser').val(selectGoods.st1_lmuser);//更新人
    $('#formGoods #txtst1_lmdt').val(selectGoods.st1_lmdt);//更新时间

    $('#formGoods #txtst2_purchaseprice').focus();//定位光标
    $('#formGoods #txtst2_saleprice').focus();//定位光标

    $('#formGoods').form('validate')
    $('#formGoods #txtst1_season').combobox('disable');
    $('#formGoods #txtst1_years').combobox('disable');
    $('#formGoods #txtst1_category').combobox('disable');
    //$('#formGoods #txtst2_color').combobox('');
    $('#formGoods #txtst1_largeclass').combobox('disable');
    $('#formGoods #txtst1_smallclass').combobox('disable');
    $('#formGoods #txtst2_sizegroup').combobox('disable');
    $('#formGoods').form('validate')
    $("#btnUp").show();//上传按钮显示
    var button = $('#btnUp');
    updateFile(button, $('#formGoods').find("#txtst2_skccode").val() + "_" + m_nMaxId);//重写按钮文件名称
    $('#formGoods').find("#txtst2_purchaseprice").focus();//定位光标，未修改，定义价格
}

//关闭新增修改窗口
function cancel(type) {
    if (type == "取消") {
        $('#DivGoods').window('close');
    }
}

//自动生成KSC
function autoSKC() {
    var st1_Years = $('#formGoods').find("#txtst1_years").combobox('getValue')//取年份
    if (st1_Years != "") {
        if (st1_Years.substr(2, 2) == "14") {
            st1_Years = "AD";
        }
        else if (st1_Years.substr(2, 2) == "15") {
            st1_Years = "AE";
        }
        else if (st1_Years.substr(2, 2) == "16") {
            st1_Years = "AF";
        }
        else if (st1_Years.substr(2, 2) == "17") {
            st1_Years = "AG";
        }
        else if (st1_Years.substr(2, 2) == "18") {
            st1_Years = "AH";
        }
        else if (st1_Years.substr(2, 2) == "19") {
            st1_Years = "AF";
        }
    }
    var st1_Season = $('#formGoods').find("#txtst1_season").combobox('getValue')//取季节
    var st1_Category = $('#formGoods').find("#txtst1_category").combobox('getValue')//取品类
    var st1_Largeclass = $('#formGoods').find("#txtst1_largeclass").combobox('getValue')//取大类
    var st2_Color = $('#formGoods').find("#txtst2_color").combobox('getValue')//取SKC颜色
    //如果季节，品类，大类为空返回
    if (st1_Years == "" || st1_Season == "" || st1_Category == "" || st1_Largeclass == "") {
        return;
    }
    else {
        //Ajax取最大值
        var data = [];
        data[data.length] = { "name": "txtst1_years", "value": st1_Years };
        data[data.length] = { "name": "txtst1_season", "value": st1_Season };
        data[data.length] = { "name": "txtst1_category", "value": st1_Category };
        data[data.length] = { "name": "txtst1_largeclass", "value": st1_Largeclass };
        var xmlData = GetFormJson(data, 'GETMAXSKC');
        htmlobj = $.ajax({
            url: GetWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0'),
            data: { "XML": xmlData },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        if (result.rows[0]['maxskc'] == "") {

        }
        else {
            $('#formGoods').find("#txtst2_st1_stylecode").val(result.rows[0]['maxskc'] + "A");
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
    var st1_Years = $('#formGoods').find("#txtst1_years").combobox('getValue')//取年份
    var st1_Season = $('#formGoods').find("#txtst1_season").combobox('getValue')//取季节
    var st1_Category = $('#formGoods').find("#txtst1_category").combobox('getValue')//取品类
    var st1_Largeclass = $('#formGoods').find("#txtst1_largeclass").combobox('getValue')//取大类
    var st2_Color = $('#formGoods').find("#txtst2_color").combobox('getValue')//取SKC颜色
    //如果季节，品类，大类为空返回
    if (st1_Years == "" || st1_Season == "" || st1_Category == "" || st1_Largeclass == "") {
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
            //控制供应商款号长度
            if (getByteLen($('#txtst1_supperierstyle').val()) > 20) {
                $.messager.alert("提示", "供应商款号不能超过20个字符", 'error');
                return false;
            }
            $('#formGoods #txtst2_sizegroup').combobox('enable');
            var data = [];
            //考虑到多种控制，直接每次保存都获取更新或者新增
            data[data.length] = { "name": "txtst1_id", "value": $('#formGoods').find("#txtst1_id").val() };
            data[data.length] = { "name": "txtst2_id", "value": $('#formGoods').find("#txtst2_id").val() };
            data[data.length] = { "name": "txtst1_suppliercode", "value": $('#formGoods').find("#txtst1_suppliercode").combogrid('getValue') };
            data[data.length] = { "name": "txtst1_br1_brandcode", "value": $('#formGoods').find("#txtbr1_brandname").combogrid('getValue') };
            //data[data.length] = { "name": "txtst1_br1_brandcode", "value": $('#formGoods').find("#txtst1_br1_brandcode").val() };
            data[data.length] = { "name": "txtst2_imagepath", "value": $('#formGoods').find("#txtst2_imagepath").val() };
            data[data.length] = { "name": "txtst1_supperierstyle", "value": $('#formGoods').find("#txtst1_supperierstyle").val() };
            data[data.length] = { "name": "txtst2_supperiercolor", "value": $('#formGoods').find("#txtst2_supperiercolor").val() };
            data[data.length] = { "name": "txtst2_supperierskc", "value": $('#formGoods').find("#txtst2_supperierskc").val() };
            data[data.length] = { "name": "txtst1_years", "value": $('#formGoods').find("#txtst1_years").combobox('getValue') };
            data[data.length] = { "name": "txtst1_season", "value": $('#formGoods').find("#txtst1_season").combobox('getValue') };
            data[data.length] = { "name": "txtst1_commodity", "value": $('#formGoods').find("#txtst1_commodity").val() };
            data[data.length] = { "name": "txtst1_unit", "value": $('#formGoods').find("#txtst1_unit").combogrid('getValue') };
            data[data.length] = { "name": "txtst1_category", "value": $('#formGoods').find("#txtst1_category").combobox('getValue') };
            data[data.length] = { "name": "txtst1_largeclass", "value": $('#formGoods').find("#txtst1_largeclass").combobox('getValue') };
            data[data.length] = { "name": "txtst1_smallclass", "value": $('#formGoods').find("#txtst1_smallclass").combobox('getValue') };
            data[data.length] = { "name": "txtst1_attr01", "value": $('#formGoods').find("#txtst1_attr01").val() };
            data[data.length] = { "name": "txtst1_attr02", "value": $('#formGoods').find("#txtst1_attr02").val() };
            //data[data.length] = { "name": "txtst1_attr03", "value": $('#formGoods').find("#txtst1_attr03").val() }; 
            data[data.length] = { "name": "txtst1_attr03", "value": "" };//增加规格2014-11-25
            data[data.length] = { "name": "txtst1_attr04", "value": $('#formGoods').find("#txtst1_attr04").combobox('getText') };
            data[data.length] = { "name": "txtst2_color", "value": $('#formGoods').find("#txtst2_color").combogrid('getValue') };
            data[data.length] = { "name": "txtst2_st1_stylecode", "value": $('#formGoods').find("#txtst2_st1_stylecode").val() };
            data[data.length] = { "name": "txtst2_skccode", "value": $('#formGoods').find("#txtst2_skccode").val() };
            data[data.length] = { "name": "txtst1_grade", "value": $('#formGoods').find("#txtst1_grade").combobox('getText') };
            data[data.length] = { "name": "txtst1_currency", "value": $('#formGoods').find("#txtst1_currency").combobox('getValue') };
            data[data.length] = { "name": "txtst2_sizegroup", "value": $('#formGoods').find("#txtst2_sizegroup").combobox('getValue') };
            data[data.length] = { "name": "txtst1_provenance", "value": $('#formGoods').find("#txtst1_provenance").combobox('getText') };
            data[data.length] = { "name": "txtst2_ingredients", "value": $('#formGoods').find("#txtst2_ingredients").val() };
            data[data.length] = { "name": "txtst1_standard", "value": $('#formGoods').find("#txtst1_standard").combobox('getValue') };
            data[data.length] = { "name": "txtst1_safetechnology", "value": $('#formGoods').find("#txtst1_safetechnology").combobox('getValue') };
            data[data.length] = { "name": "txtst2_saleprice", "value": $('#formGoods').find("#txtst2_saleprice").val() };
            data[data.length] = { "name": "txtst2_refsaleprice", "value": $('#formGoods').find("#txtst2_refsaleprice").val() };
            data[data.length] = { "name": "txtst2_purchaseprice", "value": $('#formGoods').find("#txtst2_purchaseprice").val() };
            data[data.length] = { "name": "txtst1_state", "value": $('#formGoods').find("#txtst1_state").combobox('getValue') };
            //var data = $('#formGoods').serializeArray();
            var xmlData = GetFormJson(data, 'EDITGoods');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('bef763a1-9f65-46b6-abda-2316c6bd6798'),
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
                                $('#formGoods #txtst1_season').combobox('disable');
                                $('#formGoods #txtst1_years').combobox('disable');
                                $('#formGoods #txtst1_category').combobox('disable');
                                //$('#formGoods #txtst2_color').combobox('disable');
                                $('#formGoods #txtst1_largeclass').combobox('disable');
                                $('#formGoods #txtst1_smallclass').combobox('disable');
                                $("#btnUp").show();
                                $.messager.alert("提示", result[0].rows[0].message);
                                $('#formGoods #txtst1_id').val(result[0].rows[1].message);
                                $('#formGoods #txtst2_id').val(result[0].rows[2].message);
                                $('#DivGoods').window('close');
                            }
                            $('#tab_list').datagrid("unselectAll");
                            $('#tab_list').datagrid("reload");

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

//增加选择
function col_add(text) {
    var selObj = $("#Select");
    //var value = "value";
    //var text = "text";
    selObj.append("<option>" + text + "</option>");
    //selObj.append("<option value='" + value + "'>" + text + "</option>");
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
        action: '/Handler_Upload.ashx?filePath=GL_ERPGoods&fileName=' + fileName,
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
                    //$("#txtimg").val(result[0].rows[0].message);
                    $('#txtimgupload').html("");
                    var value = result[0].rows[0].message;
                    //var strSmallImg = value.substr(0, value.length - 4) + "small" + value.substr(value.length - 4);
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

//主页查询
function initGird_GoodsSelect() {
    var st1_Years = $('#formselect #txtst1_years').val().trim();
    var st1_Season = $('#formselect #txtst1_season').val().trim();
    var st2_St1_Stylecode = $('#formselect #txtst2_st1_stylecode').val().trim();
    var st1_Supperierstyle = $('#formselect #txtst1_supperierstyle').val().trim();
    var br1_Brandname = $('#formselect #txtbr1_brandname').val().trim();
    var sp1_Bame = $('#formselect #txtsp1_name').val().trim();
    var st2_upload = $('#formselect #txtst2_upload').combobox('getValue').trim()

    var url = "1=1";
    if (st1_Years != "") {
        url += " and st1_years like '%" + st1_Years + "%'";
    }
    if (st1_Season != "") {
        url += " and st1_season like '%" + st1_Season + "%'";
    }
    if (sp1_Bame != "") {
        url += " and sp1_name like '%" + sp1_Bame + "%'";
    }
    if (br1_Brandname != "") {
        url += " and br1_brandname like '%" + br1_Brandname + "%'";
    }
    if (st2_St1_Stylecode != "") {
        url += " and st2_st1_stylecode like '%" + st2_St1_Stylecode + "%'";
    }
    if (st1_Supperierstyle != "") {
        url += " and st1_supperierstyle like '%" + st1_Supperierstyle + "%'";
    }
    if (st2_upload == "全部" || st2_upload == "") {
        url = url;
    } else {
        url += " and st2_upload like '%" + st2_upload + "%'";
    }
    url = GetWSRRURL('bef763a1-9f65-46b6-abda-2316c6bd6798') + "&XML=" + GetFormJson([], 'GoodsInfoForPageList') + "&WHERE=" + escape(url);
    initGird(url);
}

//取消首页筛选
function cancelSelectParam() {
    $('#formselect #txtst1_years').val("");
    $('#formselect #txtst1_season').val("");
    $('#formselect #txtst2_st1_stylecode').val("");
    $('#formselect #txtst1_supperierstyle').val("");
    $('#formselect #txtbr1_brandname').val("");
    $('#formselect #txtsp1_name').val("");
}

//取字符串长度
function getByteLen(val) {    //传入一个字符串
    var len = 0;
    for (var i = 0; i < val.length; i++) {
        if (val[i].match(/[^\x00-\xff]/ig) != null) //全角 
            len += 2; //如果是全角，占用两个字节
        else
            len += 1; //半角占用一个字节
    }
    return len;
}
