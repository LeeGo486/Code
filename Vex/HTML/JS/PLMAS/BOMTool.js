/// JS名：BOMTool.js
/// 说明：BOMTool
/// 创建人：郭琦琦 
/// 创建日期：2014-06-28
//郭琦琦2014年7月21修改
//物料特性做成下拉

var m_DDHComboxData = null;//定义订货会季节下拉
var m_Username = "";//定义登入名
var m_Nowdate;//定义当前时间
var m_data1;//订货会季节
var m_SearchData = [];//查询款式的查询参数
var m_num = "";//权限值
var m_RowIndex = 1000;//行号默认1000
var m_cz = [{ opno: '0010', mtno: '11CJ', itcl: "工序", itds: "裁剪工序" }, { opno: '0020', mtno: '12FR', itcl: "工序", itds: "缝纫工序" }, { opno: '0030', mtno: '13HD', itcl: "工序", itds: "后道工序" },
    { opno: '0040', mtno: 'WB-ZY', itcl: "工序", itds: "外包-整衣" }]//默认新增的时候4道工序
var editIndex;//定义编辑索引//easyui 框架
var m_editIndex;//定义编辑索引样衣价格
var m_opno = "50";//BOM工序初始
var m_searchBOMDOrderseason = "";//一层选择的季节
var m_searchBOMMeasurementsidJ = "";//一层选择的样板号
var m_GetGX = "";//工序
var m_flag = "1";//判断验证是否通过
var m_sampleData = [];//样衣信息
var selectRow = "";//二层加载的时候,一层选中的数据//easyui 框架
var m_ince = [{ "id": "1", "text": '是' }, { "id": "0", "text": "否" }]//三层限定包含
var m_Optn;//特性组下拉
var m_limitedMtno;//定义三层限定保存用物料编号
var m_replaceMtno;//定义三层替代物料
var selectedBOM = "";//二层选中过的东西
var selectedReplace;//取三层替代主选中的数据
var m_flag_xdandtd = "1";//1代表可以做替代和限定
var m_flag_mtno = "1";//1代表M3编号不能修改
var samplehao;//五层样衣号
var m_flaf_tdzb = "1";//替代主表没有保存的情况下是不能查看替代子表
var m_hp1_mfti;//物料特性
var m_strt;//采购来源序数
var m_zt;//帐套
//初始化数据
//-----------------------------------------------------------------------------------------------------------初始化数据--
$(function () {


    document.onkeydown = check;
    function check(e) {
        var code;
        if (!e) var e = window.event;
        if (e.keyCode) code = e.keyCode;
        else if (e.which) code = e.which;
        else return;

        if (code == 8) {
            if (
                (event.srcElement.type != "text" &&
                event.srcElement.type != "textarea" &&
                event.srcElement.type != "password") ||
                event.srcElement.readOnly == true) {
                event.keyCode = 0;
                event.returnValue = false;
                return false;
            };
            return true;
        };
    }








    m_zt = $.cookie('m_zt');
    m_flag = "1";//1代表不能保存
    m_flag_xdandtd = "1";//1代表可以做替代和限定
    m_flag_mtno = "1";//1代表M3编号不能修改
    m_flaf_tdzb = "1";//替代主表没有保存的情况下是不能查看替代子表

    //默认附上时间今天往前面推3个月，开始时间和结束时间
    m_Username = window.m_UserID;//取登入姓名
    m_Nowdate = (new Date()).DateAdd('d', -0).format("yyyy-MM-dd");//今天时间
    //$("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('m', -3).format("yyyy-MM-dd"));
    //$("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('d', -15).format("yyyy-MM-dd"));
    //$("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('d', -1).format("yyyy-MM-dd"));
    //$("#txtEndDate").datebox("setValue", (new Date()).DateAdd('d', 0).format("yyyy-MM-dd"));

    $("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('d', -15).format("yyyy-MM-dd"));
    $("#txtEndDate").datebox("setValue", (new Date()).format("yyyy-MM-dd"));

    //查询方式
    $('#cmbSelectType').combobox({
        data: [{ "id": "date", text: "日期", selected: true }, { "id": "orderPlacing", text: "订货会季节" }, { "id": "design", text: "编号" }],
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        onSelect: function (record) {
            slectTypeChange(record);
        }
    });

    $('#txtcmbBrand').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbstky", "cbstky") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true,
        onSelect: function (record) {
            ChangeDHHJJ();
        }
    });

    //品牌
    $.ajax({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "ownedbrand", "ownedbrand") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand'),
        panelHeight: '200',
        editable: false,
        required: true,
        async: true, //异步
        success: function (data) {
            m_OwnedBrand = eval(data);
            if (m_OwnedBrand.length > 0 && m_OwnedBrand[0].id) {
                $('#txtcmbBrand').combobox('setValue', m_OwnedBrand[0].id);
                ChangeDHHJJ()
            }
        }
    });

    ////取该人的品牌USERINFO表OwnedBrand字段判断品牌
    //var xmlData = GetFormJson([], 'GetOwnedBrand');
    //htmlobj = $.ajax({
    //    url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
    //    data: { "XML": xmlData },
    //    type: 'post',
    //    async: false
    //});
    //var result = $.parseJSON(htmlobj.responseText);
    //$("#txtbrand").val(result.rows[0]['ownedbrand'])//把品牌赋值给HTML品牌

    //初始化订货会下拉数据
    $('#txtcmbdhhjj').combobox({
        url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        async: true, //异步
        onLoadSuccess: function (data) {
            if (m_DDHComboxData == null) {
                m_DDHComboxData = data;
                ChangeDHHJJ();//按照品牌控制季节下拉
            }
            m_data1 = $('#txtcmbdhhjj').combobox('getData');
            $('#txtcmbdhhjj').combobox('setValue', m_data1[m_data1.length - 1].text);
        }
    });

    //加载工序名称下拉
    $('#formGX #txtmtno').combobox({
        url: GetComboxALLColumnWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetGX'),
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function (date) {
            $('#formGX #txtitds').val(date.cbtx40);//选择工序的时候,把工序名称赋值
        }
    });
    $("#DivGX").hide();//默认隐藏新建工序DIV
    $("#divlimited").hide();//默认隐藏限定
    $("#divReplace").hide();//默认隐藏替代
    $("#DivAddLimited").hide();//默认隐藏限定新增
    $("#DivAddReplace").hide();//默认隐藏替代新增
    $("#divReplaceSub").hide();//默认隐藏替代子表
    $("#DivAddReplaceSub").hide();//默认隐藏替代子表新增
    $("#divSamplePrice").hide();//默认隐藏样衣价格
    $("#divselectbombasic").hide();//默认隐藏选择BOM信息

});

//查询条件改变
function slectTypeChange(type) {
    $("#date")[0].style.display = "none";
    $("#orderPlacing")[0].style.display = "none";
    $("#design")[0].style.display = "none";
    $("#" + type.id)[0].style.display = "inline-block";
}

//按照品牌控制季节下拉数据
function ChangeDHHJJ() {
    var brandType = $('#txtcmbBrand').combobox("getText");
    if (brandType.substr(0, 2) == "EP") {
        brandType = "EP"
    }
    else if (brandType.substr(0, 2) == "E.P") {
        brandType = "E.Prosper"
    }
    else if (brandType.substr(0, 2) == "Do") {
        brandType = "Do"
    }
    else if (brandType.substr(0, 2) == "Ki") {
        brandType = "Kids"
    }

    if (m_DDHComboxData == null) {
        return;
    }
    var data = m_DDHComboxData;
    var data1 = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].id.toString().indexOf(brandType) > 0) {
            data1.push(data[i]);
        }
    }
    $('#txtcmbdhhjj').combobox({ url: "" });
    $('#txtcmbdhhjj').combobox("loadData", data1);//重加载季节下拉数据
}
//
//-----------------------------------------------------------------------------------------------------------一层主信息--
//一层查询按钮
//查询事件
function SearchClick() {

    var brand = $("#txtcmbBrand").combobox("getValue");
    m_Brand = brand;
    var start = "";
    var end = "";
    var designId = "";
    var username = window.m_UserID;
    var season = "";

    if (brand == "") {
        $.messager.alert("提示", "请先选择品牌！", 'error');
        return;
    }

    var selectType = $('#cmbSelectType').combobox("getValue");
    //根据日期
    if (selectType == "date") {
        $("#txtBeginDate").datebox("setValue", $("#txtBeginDate").datebox("getText"));
        $("#txtEndDate").datebox("setValue", $("#txtEndDate").datebox("getText"));

        start = $("#txtBeginDate").datebox("getValue");
        end = $("#txtEndDate").datebox("getValue");

        if (start == "") {
            $.messager.alert("提示", "开始时间不能为空！", 'error');
            return;
        }

        if (end == "") {
            $.messager.alert("提示", "结束时间不能为空！", 'error');
            return;
        }
    }
    else if (selectType == "orderPlacing") {//订货会
        season = $('#txtcmbdhhjj').combobox("getValue");

        if (season == "") {
            $.messager.alert("提示", "订货会季节不能为空！", 'error');
            return;
        }
    }
    else if (selectType == "design") {//设计号
        designId = $('#txtDesignerId').val();
        if (designId == "") {
            $.messager.alert("提示", "设计号不能为空！", 'error');
            return;
        }
    }
    m_SearchData = "";
    m_SearchData += "&brand=" + brand;
    m_SearchData += "&start=" + start;
    m_SearchData += "&end=" + end;
    m_SearchData += "&designId=" + designId;
    m_SearchData += "&username=" + username;
    m_SearchData += "&season=" + escape(season);
    m_SearchData += "&DIVI=" + m_zt;
    initGird();
}
//一层BOM信息
function initGird() {
    $('#tabList').datagrid(
        {
            //title: '服务申请：1、系统提交申请后，与总监当面确认；2、打印申请单给研发；3、研发完成后，录入SP代码；4、与总监确认定稿；',
            url: GetWSRRURL('dfaf0456-4114-4d51-8fce-7f71beb526e2') + m_SearchData,
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择 
            columns: [[
                {
                    field: 'designimagesmall', title: '款图', width: 100, formatter: function (value, row, index) {
                        var data = "<a href='http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?DT=true&IMG=" + escape(row.designimagebig) + "' target='_blank'><img  src='" + value + "' style='height:70px' border='0'/></a>";
                        return data;
                    }
                },
                { field: 'designerid', title: '设计号', width: 80 },
                { field: 'splitnumber', title: '驳样号', width: 80, hidden: true },
                { field: 'measurementsid', title: '样板号', width: 80 },
                { field: 'productname', title: '款号', width: 80 },
                { field: 'orderseason', title: '订货会季节', width: 120 },
                { field: 'designer', title: '设计师', width: 60 },
                { field: 'muser', title: '版师', width: 80 },
                { field: 'recdate', title: '接版日期', width: 80 },
                { field: 'mcount', title: '版型创建', width: 80, hidden: true },
                { field: 'changecount', title: '调板次数', width: 80 },
                { field: 'changedesc', title: '调板原因', width: 80, hidden: true },
                { field: 'deliverdate', title: '交版日期', width: 80 },
                { field: 'derwpe', title: '图稿评审人', width: 80 },
                { field: 'rectype', title: '接收品类型', width: 80, hidden: true },
                { field: 'dyfactory', title: '打样工厂', width: 80, hidden: true },
                { field: 'cgsource', title: '采购来源', width: 80, hidden: true },
                { field: 'boduanseries', title: '系列', width: 80 },
                { field: 'category', title: '品类', width: 80 },
                { field: 'producttype', title: '产品类型', width: 80 },
                { field: 'stat', title: '状态', width: 80 },
                { field: 'curwfname', title: '款式生命周期', width: 120 }
            ]],
            rownumbers: true, //行号
            toolbar: [
            {
                id: 'btnSearch',
                text: '查看BOM',
                iconCls: 'icon-search',
                handler: function () {
                    searchBOM();
                }
            }]
        }
        );
}

//一层查询BOM
function searchBOM() {
    selectRow = $("#tabList").datagrid('getSelected')//一层点击或者一层选择数据

    if (!selectRow) {
        alert("请选择一条数据"); return;
    }

    $('#divselectbombasic').show().window({
        title: "BOM采购来源",
        top: 100,
        width: 595,
        height: 313,
        modal: true
    });
    var brandTypeBom = $('#txtcmbBrand').combobox("getText");
    m_searchBOMDOrderseason = selectRow.orderseason;//选择行的订货会季节
    m_searchBOMMeasurementsidJ = selectRow.measurementsid;//选择行的样板号为加载BOM提供参数
    initGirdProductCGSource(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, brandTypeBom); //获取1.5层来源
}
//
//-----------------------------------------------------------------------------------------------------------一层二层添加1.5层--
//
//郭琦琦20140725增加 1层和2层中间新增一层选择BOM基础
//
//加载1.5层数据
function initGirdProductCGSource(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, brandTypeBom) {
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetProductCGSource" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txt品牌", "value": brandTypeBom };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#selectbombasiclist').datagrid(
        {
            //title: 'BOM信息', //表格标题
            url: url,
            async: false,
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
            rownumbers: true,//行号
            //onDblClickRow: onDblClickRowLimitedlist,//双击事件
            //onClickRow: onClickRowLimitedlist,//单击事件
            onLoadSuccess: function (data) {
                if ((data.rows.length == 1 && data.rows[0].measurementsid == undefined) || (data.rows.length == 1 && data.rows[0].measurementsid == "")) {
                    ClearGrid("#selectbombasiclist");
                }
            },
            columns: [[
                { field: 'measurementsid', title: '样板号', width: 70 },
                { field: 'strt', title: '序号', width: 40 },
                { field: 'dytype', title: '打样类型', width: 70 },
                { field: 'dyfactory', title: '打样工厂', width: 150 },
                { field: 'cgsource', title: '采购来源', width: 100 },
                { field: 'muser', title: '负责人', width: 60 },
            ]]
        });
}

//一层和2层BOM选择层
function selectBOMbasic() {
    var selectBomBasic = $("#selectbombasiclist").datagrid('getSelected')//1.5层点击
    if (!selectBomBasic) {
        alert("请选择采购来源"); return;
    } else {
        $('#divsearch').window({
            title: "查看BOM",
            top: 20,
            maximized: true,
            modal: true
        });
        //m_searchBOMDOrderseason = selectRow.orderseason;//选择行的订货会季节
        //m_searchBOMMeasurementsidJ = selectRow.measurementsid;//选择行的样板号/为加载BOM提供参数
        m_strt = selectBomBasic.strt;//m_strt采购来源序数
        ClearGrid("#samplelist")//清空样衣和BOM信息
        ClearGrid("#searchbomlist")//清空BOM信息表
        $('#divselectbombasic').window('close');
        initGirdSample(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ); //获取查看BOM二层样衣信息
        initGirdBOM(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ); //获取查看二层BOM信息
    }
}



//
//-----------------------------------------------------------------------------------------------------------二层--
//二层样衣信息加载
function initGirdSample(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ) {
    //创建获取数据XML
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
    $('#samplelist').datagrid(
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
            //onRowContextMenu: onRowContextMenu,
            fit: true,//自适应
            //onClickRow: onClickRow,//单击事件
            //onDblClickRow: onDblClickRow,
            onLoadSuccess: function (data) {
                //如果只有一行并且样衣号给空,清楚样衣信息,如果有,把所有的信息信息,存在全局变量m_sampleData共后面重加载,加快速度
                if (data.rows.length == 1 && data.rows[0].measurementsid == "") {
                    ClearGrid("#samplelist");
                }
                else {
                    m_sampleData = data;
                }
            },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'measurementsid', title: '样版号', width: 80 },
                { field: 'dyyyno', title: '样衣号', width: 80 },
                { field: 'dycolorname', title: '颜色', width: 140 },
                { field: 'dyovdt', title: '完成时间'}
            ]],
            toolbar: [
          {
              id: 'btnSamplePrice',
              text: '样衣物料清单',
              iconCls: 'icon-search',
              handler: function () {
                  samplePriceList();
              }
          }]
        });
}

//加载二层BOM
function initGirdBOM() {
    //创建获取数据XML
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateBOM" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#searchbomlist').datagrid(
        {
            //title: 'BOM信息', //表格标题
            url: url,
            async: false,
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
            rownumbers: true,//行号
            onRowContextMenu: onRowContextMenu,
            onDblClickRow: onDblClickRow,//双击事件
            onClickRow: onClickRow,//单击事件
            onLoadSuccess: function (data) {
                if ((data.rows.length == 1 && data.rows[0].mseq == "") || (data.rows.length == 1 && data.rows[0].mseq == undefined)) {
                    ClearGrid("#searchbomlist");
                }
                m_flag_xdandtd = "1";
                m_flag = "2";
                //获取权限.控制按钮显示

                var data = [];
                data[data.length] = { "name": "txtzt", "value": m_zt };//帐套

                var xmlData = GetFormJson(data, 'GetBOM');
                htmlobj = $.ajax({
                    url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
                    data: { "XML": xmlData },
                    type: 'post',
                    async: false
                });
                var result = $.parseJSON(htmlobj.responseText);
                m_num = result.rows[0]['num']//获取是否有权限
                if (m_num > 0) {
                    $("#btnReload").show();
                    $("#btnVerification").show();
                    $("#btnSave").show();
                    $("#btnLimited").show();
                    $("#btnReplace").show();
                    $("#btnCancel").show();
                    //$('#mm').menu('hide');
                }
                else {
                    $("#btnReload").hide();
                    $("#btnVerification").hide();
                    $("#btnSave").hide();
                    $("#btnLimited").hide();
                    $("#btnReplace").hide();
                    $("#btnCancel").hide();
                }
            },
            columns: [[
                { field: 'mseq', title: '序号', width: 60 },
                //{ field: 'opno', title: '工序代号', width: 70, editor: { type: 'numberbox', options: { required: false } } },
                { field: 'opno', title: '工序代号', width: 70 },
                { field: 'mtno', title: 'M3编号', width: 130 },
                {
                    field: 'cnqt', title: '用量', width: 70, editor: { type: 'numberbox', options: { precision: '2', required: false } },
                    formatter: function (value) { if (value == undefined || value == '0.000000') { return ""; } else { return Formater.Account1(value); } }
                },
                { field: 'itcl', title: '分类', width: 100 },
                { field: 'itds', title: '描述', width: 150 },
                { field: 'unms', title: '单位', width: 50 },
                { field: 'lmdt', title: '最后保存时间', width: 90, formatter: Formater.Date },
                { field: 'lmuser', title: '最后保存人', width: 70 }
            ]],
            toolbar: [
           {
               id: 'btnReload',
               text: '重置',
               iconCls: 'icon-undo',
               hidden: true,
               handler: function () {
                   reloadBOM();
               }
           },
           {
               id: 'btnVerification',
               text: '验证',
               iconCls: 'icon-ok',
               hidden: true,
               handler: function () {
                   verificationBOM();
               }
           },
           {
               id: 'btnSave',
               text: '保存',
               iconCls: 'icon-save',
               hidden: true,
               handler: function () {
                   saveBOM();
               }
           },
           {
               id: 'btnLimited',
               text: '限定',
               iconCls: 'icon-online',
               hidden: true,
               handler: function () {
                   limitedBOM();
               }
           },
           {
               id: 'btnReplace',
               text: '替代',
               iconCls: 'icon-deploy',
               hidden: true,
               handler: function () {
                   replaceBOM();
               }
           },
           {
               id: 'btnCancel',
               text: '退出',
               iconCls: 'icon-back',
               hidden: true,
               handler: function () {
                   calcelBOM("二层BOM");
               }
           }]
        });
}

//二层重置事件
function reloadBOM() {
    var selectedReloadDelete = $("#searchbomlist").datagrid('getRows'); //获取当前所有行的数据

    //如果前台没有数据,就提示是否要加载默认工序,如果有数据 是否要清空BOM并重置
    if (selectedReloadDelete.length == 0 || selectedReloadDelete.length == undefined) {
        var message = "是否要加载默认工序";
    }
    else {
        var message = "是否要清空BOM并重置";
    }
    $.messager.confirm('提示框', message, function (r) {
        if (r) {
            //循环删除重序号最大的开始删除
            for (var i = selectedReloadDelete.length - 1; i >= 0; i--) {
                var index = $('#searchbomlist').datagrid('getRowIndex', selectedReloadDelete[i])
                $('#searchbomlist').datagrid('deleteRow', index)
            }
            //默认赋值添加默认值
            for (var i = 0; i < m_cz.length; i++) {
                $('#searchbomlist').datagrid('appendRow',
                                {
                                    rowindex: m_RowIndex++,
                                    mseq: "",//序号
                                    opno: m_cz[i].opno,//工序代号
                                    mtno: m_cz[i].mtno,//M3编号
                                    cnqt: "",//用量
                                    itcl: m_cz[i].itcl,//描述
                                    itds: m_cz[i].itds,//单位
                                    unms: "",//单位
                                    //slpupr: "",//最新价格
                                    lmdt: m_Nowdate,
                                    lmuser: m_Username
                                    //ydbsw: "New"
                                });
            }
        }
        m_opno = "50";//初始化是50
        m_flag = "1";//是否验证重置。1代表需要验证
        m_flag_xdandtd = "2";//重置是否可以替代和限定。2代表不行
    });
}
//
//-----------------------------------------------------------------------------------------------------------二层验证--
//二层验证M3物料
function verificationBOM() {
    endEditing();
    if (endEditing()) {
        var searchBomListRow = $('#searchbomlist').datagrid('getRows');
        //验证的时候判断,物料是否唯一
        if (searchBomListRow.length == 0) {
            alert("无验证物料")
            return;
        }
        //验证前先验证序号和M3编号是否有重复
        for (var i = 0; i < searchBomListRow.length; i++) {
            var a = searchBomListRow[i].mseq;//获取序号
            var b = searchBomListRow[i].mtno;//获取M3编号

            for (var j = 0; j < searchBomListRow.length; j++) {
                var a1 = searchBomListRow[j].mseq;//获取对比序号
                var b1 = searchBomListRow[j].mtno;//获取对比M3编号
                if (i != j && a != "" && a1 != "" && a == a1) {
                    alert("序号有重复  " + a)
                    return;
                }
                if (i != j && b != "" && b1 != "" && b == b1) {
                    alert("M3编码有重复  " + b)
                    return;
                }
            }
        }
        //重组验证M3物料字段.只留序号和物料编号
        var selectedM3 = $("#searchbomlist").datagrid('getRows'); //获取BOM数据
        var data1 = [];
        for (var i = 0; i < selectedM3.length; i++) {
            var obj = new Object();
            obj.mseq = selectedM3[i].mseq == undefined ? "" : selectedM3[i].mseq;
            obj.mmitno = selectedM3[i].mtno;
            data1.push(obj)
        }
        var data1 = GetExcelXML(data1);
        var data = [];
        data[data.length] = { "name": "txt操作类型", "value": "GET" };
        data[data.length] = { "name": "txt返回内容", "value": "必填" };
        data[data.length] = { "name": "txtCONO", "value": "HFYG" };
        data[data.length] = { "name": "txtDIVI", "value": m_zt };
        data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
        data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
        data[data.length] = { "name": "txt操作人", "value": m_Username };
        data[data.length] = { "name": "txt实体", "value": "BOMMaterialValidation" };
        data[data.length] = { "name": "txtXML", "value": data1, specialCharset: true };
        //return;
        var xmlData = GetDBFrameAML(data);//组成调用APIxml
        var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
        htmlobj = $.ajax({
            url: url,
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);//
        if (result.rows[0].mmunms == "") {
            alert("验证不通过,有可能M3编码错误");
            return;
        } else {
            var searchBomListRow = $('#searchbomlist').datagrid('getRows');
            for (var j = 0; j < result.rows.length; j++) {
                var a = result.rows[j].mmitno;//获取返回的M3编号
                for (var i = 0; i < searchBomListRow.length; i++) {
                    var a1 = searchBomListRow[i].mtno;//
                    if (a.trim() == a1.trim()) {
                        $('#searchbomlist').datagrid('updateRow', {
                            index: $('#searchbomlist').datagrid('getRowIndex', searchBomListRow[i]),
                            row:
                                 {
                                     mseq: result.rows[j].mseq != "" ? result.rows[j].mseq.trim() : result.rows[j].mseq,//序号
                                     mtno: result.rows[j].mmitno != "" ? result.rows[j].mmitno.trim() : result.rows[j].mmitno,//M3编号
                                     itcl: result.rows[j].cbtx40 != "" ? result.rows[j].cbtx40.trim() : result.rows[j].cbtx40,//分类
                                     itds: result.rows[j].mmitds != "" ? result.rows[j].mmitds.trim() : result.rows[j].mmitds,//描述
                                     unms: result.rows[j].mmunms != "" ? result.rows[j].mmunms.trim() : result.rows[j].mmunms//单位
                                 }
                        });
                    }
                }
            }
            m_flag = "2";//验证通过
            m_flag_mtno = "1";//1代表M3编号不能修改
            alert("验证通过");
        }
    }
};

//二层保存数据
function saveBOM() {
    var selected = $("#searchbomlist").datagrid('getRows'); //获取所有行集合对象
    if ($("#searchbomlist").datagrid('getChanges').length) {
        //if (m_flag == "2") {
        for (var i = 0; i < selected.length; i++) {
            if (selected[i].itcl == "" || selected[i].itcl == undefined) {
                $.messager.alert("提示", "分类不能为空,请检查数据,再进行M3物料验证！", 'error');
                return;
            }
        }
        //验证M3编号是否有重复
        for (var i = 0; i < selected.length; i++) {
            var e = selected[i].mtno;//获取M3编号
            for (var j = 0; j < selected.length; j++) {
                var e1 = selected[j].mtno;//获取对比M3编号
                if (i != j && e != "" && e1 != "" && e == e1) {
                    alert("M3编号有重复" + e)
                    return;
                }
            }
        }
        //判断是否验证,1.不通过,2通过
        if (endEditing()) {
            $dg = $("#searchbomlist");
            if ($dg.datagrid('getChanges').length) {

                var dateUpdate = [];
                var inserted = $dg.datagrid('getChanges', "inserted");
                var deleted = $dg.datagrid('getChanges', "deleted");
                var updated = $dg.datagrid('getChanges', "updated");

                for (var i = 0; i < deleted.length; i++) {
                    deleted[i].transflag = "Delete";
                    delete deleted[i].rowindex;
                    dateUpdate.push(deleted[i]);
                }
                for (var i = 0; i < inserted.length; i++) {
                    inserted[i].transflag = "NEW";
                    delete inserted[i].rowindex;
                    dateUpdate.push(inserted[i]);

                }
                for (var i = 0; i < updated.length; i++) {
                    updated[i].transflag = "Alter";
                    delete updated[i].rowindex;
                    dateUpdate.push(updated[i]);
                }
                var dateUpdate = GetExcelXML(dateUpdate);
                //return;
                var data = [];
                data[data.length] = { "name": "txt返回内容", "value": "必填" };
                data[data.length] = { "name": "txt实体", "value": "GetUpdateBOM" };
                data[data.length] = { "name": "txt操作类型", "value": "Update" };
                //data[data.length] = { "name": "txtColorGroup", "value": "CN01" };
                //data[data.length] = { "name": "txtSizeGroup", "value": "S-A" };
                data[data.length] = { "name": "txtCONO", "value": "HFYG" };
                data[data.length] = { "name": "txtDIVI", "value": m_zt };
                data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
                data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
                data[data.length] = { "name": "txt操作人", "value": m_Username };
                data[data.length] = { "name": "txtXML", "value": dateUpdate, specialCharset: true };
                data[data.length] = { "name": "txtSTRT", "value": m_strt };

                var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8'),
                    data: xmlData,
                    type: 'POST',
                    async: true,
                    success: function (result) {
                        try {
                            $.messager.progress("close");
                            var result = eval("[" + result + "]");

                            if (result[0].Error) {
                                $.messager.progress('close');

                                $.messager.alert("系统错误", result[0].Error, 'error');
                            }
                            else if (result[0].rows[0].result == "False") {
                                $.messager.alert("提示", result[0].rows[0].message, 'error');
                            }
                            else {
                                $.messager.progress('close');
                                $('#searchbomlist').datagrid("reload");
                                m_flag_xdandtd = "1";
                                //$.messager.alert("提示", result[0].rows[0].tablename);
                                $.messager.alert("提示", result[0].rows[0].msg);
                            }
                        } catch (ex) {
                            $.messager.alert("提示", ex, 'error');
                        }
                    },
                    error: function (result) {

                        $.messager.alert("提示", "提交错误了！", 'error');
                        $.messager.progress('close');
                    }
                });
            }
            m_flag_xdandtd = "1";
        }
            //}
        else {
            alert("请先验证")
            return;
        }
    }
    else {
        alert("无数据需要保存")
        return;
    }
}
//
//-----------------------------------------------------------------------------------------------------------二层基本信息操作,右击,右击新增物料,新增工序,双击编辑--
//二层右击事件
function onRowContextMenu(e, rowIndex, rowData) {
    e.preventDefault();
    var selected = $("#searchbomlist").datagrid('getRows'); //获取所有行集合对象
    selected[rowIndex].id; //index为当前右键行的索引，指向当前行对象

    //控制权限，如果没有权限，那就右击没有权限
    if (m_num > 0) {
        $('#mm').menu('show', {
            left: e.pageX,
            top: e.pageY
        });
    } else {
        //return false;
        $('#mm').menu('hide', {
            left: e.pageX,
            top: e.pageY
        });
    }
}

//二层右击新增物料事件
function addwl() {
    var selected = $("#searchbomlist").datagrid('getSelected'); //获取当前行的数据
    if (!selected) {
        alert('请选择一行');
        return;
    }
    if (!endEditing1()) {
        return;
    }
    var nIndex = $('#searchbomlist').datagrid('getRowIndex', selected);
    $('#searchbomlist').datagrid('insertRow', {
        index: nIndex,
        row: {
            rowindex: m_RowIndex++,
            mseq: "",//序号
            opno: selected.opno,//工序代号
            mtno: "",//M3编号
            cnqt: "",//用量
            itcl: "",//描述
            itds: "",//单位
            unms: "",//单位
            //slpupr: "",//最新价格
            lmdt: m_Nowdate,
            lmuser: m_Username
            //ydbsw: "New"
        }
    });
    //设置可编辑字段
    var col = $('#searchbomlist').datagrid('getColumnOption', 'mtno');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    var col = $('#searchbomlist').datagrid('getColumnOption', 'mseq');
    col.editor = {
        type: 'numberbox', options: { required: true, textField: 'text' }
    }
    //var col = $('#searchbomlist').datagrid('getColumnOption', 'opno');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    $('#searchbomlist').datagrid('selectRow', nIndex).datagrid('beginEdit', nIndex);
    editIndex = nIndex;

    m_flag_xdandtd = "2";
    m_flag = "1";
}

//二层右击新增工序事件
function addgx() {
    if (!endEditing1()) {
        return;
    }
    var col = $('#searchbomlist').datagrid('getColumnOption', 'mtno');
    col.editor = {}
    var col = $('#searchbomlist').datagrid('getColumnOption', 'mseq');
    col.editor = {}
    var col = $('#searchbomlist').datagrid('getColumnOption', 'opno');
    col.editor = {}

    $('#DivGX').show().window({
        title: "新建工序",
        top: 40,
        width: 370,
        height: 125,
        modal: true
    });
    $('#txtmtno').combobox('setValue', "")
    $('#txtitds').val("");
}

//二层新建工序保存M3物料信息
function saveGX() {
    var selected = $("#searchbomlist").datagrid('getSelected'); //获取当前行的数据
    var selectedRow = $("#searchbomlist").datagrid('getData'); //获取datagird数据
    //默认工序ID给40
    var nMaxId = "40";
    for (var i = 0; i < selectedRow.rows.length; i++) {
        if (parseInt(selectedRow.rows[i].opno) > nMaxId) {
            nMaxId = parseInt(selectedRow.rows[i].opno);
        }
    }
    nMaxId = nMaxId * 1 + 10;
    m_opno = nMaxId
    //如果结束编辑之后,在界面新增加一行数据
    if (endEditing()) {
        $('#searchbomlist').datagrid('appendRow', {
            opno: "00" + m_opno, rowindex: m_RowIndex++, mseq: "", itcl: "工序", mtno: $('#txtmtno').combobox('getValue'),
            itds: $('#txtitds').val(), lmdt: m_Nowdate, lmuser: m_Username, cnqt: "", unms: ""
        });
        editIndex = $('#searchbomlist').datagrid('getRows').length - 1;
        $('#searchbomlist').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
        m_opno = m_opno * 1 + 10;
    }
    $('#DivGX').window('close');
}

//二层右击删除事件
function del() {
    var selected = $("#searchbomlist").datagrid('getSelected'); //获取当前行的数据
    var selectedRowsDelete = $("#searchbomlist").datagrid('getRows'); //获取当前的数据
    if (!selected) {
        alert('请选择一行');
        return;
    }

    if (selected.itcl == "工序") {
        var f = selected.opno;//获取工序代号
        for (var n = 0; n < selectedRowsDelete.length; n++) {
            var f1 = selectedRowsDelete[n].opno;//获取工序代号
            if (f != "" && f1 != "" && f == f1) {
                if (selectedRowsDelete[n].itcl == "工序") {
                    continue;
                } else {
                    alert("该工序下面已经有物料不能删除!");
                    return;
                }
            }
        }
    }
    var index = $('#searchbomlist').datagrid('getRowIndex', selected)
    $('#searchbomlist').datagrid('deleteRow', index)
}

//二层双击事件编辑BOM
function onDblClickRow(index, rowData) {
    BeginEdit(index, rowData);
}

//二层开始编辑
function BeginEdit(index, rowData) {
    //如果编辑的行不等于行号的话，执行，开始编辑
    if (editIndex != index) {
        if (endEditing()) {
            editIndex = index;
            //开始编辑的时候做判断如果是工序就不给他修改M3编码
            if (rowData.itcl == "工序" || m_flag_mtno == "1") {
                var col = $('#searchbomlist').datagrid('getColumnOption', 'mtno');
                col.editor = {}
            } else {
                var col = $('#searchbomlist').datagrid('getColumnOption', 'mtno');
                col.editor = {
                    type: 'validatebox', options: { required: true, textField: 'text' }
                }
            }
            if ((rowData.itcl == "" || rowData.itcl == undefined) && (rowData.itds == "" || rowData.itds == undefined)) {
                var col = $('#searchbomlist').datagrid('getColumnOption', 'mseq');
                col.editor = {
                    type: 'numberbox', options: { required: true, textField: 'text' }
                }
            } else {
                var col = $('#searchbomlist').datagrid('getColumnOption', 'mseq');
                col.editor = {}
            }
            $('#searchbomlist').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
            m_flag = "1";//开始编辑之后,验证标识改为1.未验证状态
            m_flag_xdandtd = "2";//编辑过了,就不允许做限定和替代
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return true;
    }
}

//二层判断改行是否可以结束编辑
function endEditing() {
    if (editIndex != undefined) {
        if ($('#searchbomlist').datagrid('validateRow', editIndex)) {
            $('#searchbomlist').datagrid('endEdit', editIndex);
            //if ($('#searchbomlist').datagrid('selectRow', editIndex).ydbsw != "NEW") {

            //}
            editIndex = undefined;
        }
        else {
            alert('M3编码和序号必须填写');
            return;
        }
    }
    return true;
}

function endEditing1() {
    if (editIndex != undefined) {
        if ($('#searchbomlist').datagrid('validateRow', editIndex)) {
            $('#searchbomlist').datagrid('endEdit', editIndex);
            editIndex = undefined;
        }
        else {
            alert('请先把之前的行填写完整之后再新增');
            return;
        }
    }
    return true;
}

//二层单击事件
function onClickRow(rowIndex, RowData) {
    if (rowIndex != editIndex) {
        if (!endEditing()) {
            return;
        }
    }
}
//
//-----------------------------------------------------------------------------------------------------------三层限定--
//三层限定点击
function limitedBOM() {

    if (m_flag_xdandtd == "2") {
        alert("请先保存.只有保存在数据库才能做限定");
        return;
    }
    selectedBOM = $('#searchbomlist').datagrid('getSelected');
    if (!selectedBOM) {
        alert("请选择一行数据");
        return;
    }
    if (endEditing()) {

        m_searchBOMDOrderseason = selectRow.orderseason;//一层行的订货会季节
        m_searchBOMMeasurementsidJ = selectRow.measurementsid;//一层行的样板号/为加载三层限定提供参数
        var M_productname = selectRow.productname;//一层款号
        m_limitedMtno = selectedBOM.mtno;//物料编号

        var data = [];
        data[data.length] = { "name": "txtMM1_ITNO", "value": m_limitedMtno }; //m_limitedMtno
        data[data.length] = { "name": "txtPM1_PRNO", "value": M_productname };//款号号
        data[data.length] = { "name": "txtzt", "value": m_zt };//帐套

        //判断M3编号是否有权限
        var xmlData = GetFormJson(data, 'GetVerification');
        htmlobj = $.ajax({
            url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
            data: { "XML": xmlData },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        var isoron = result.rows[0]['isoron']//判断是否有权限
        //如果权限有,就可以新增,如果没有弹窗
        if (isoron == 1) {
            $('#divlimited').show().window({
                title: "限定",
                top: 20,
                maximized: true,
                modal: true
            });

            ClearGrid("#stylesdefinelist")
            ClearGrid("#threesamplelist")
            initGirdLimited(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, m_limitedMtno); //获取加载三层限定数据
            initGirdLimitedThreeSample(); //获取加载三层限定数据
        }
        else {
            alert("此物料不能做限定")
            return;
        }
    }
}

//三层限定数据加载
function initGirdLimited(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, m_limitedMtno) {
    //创建获取数据XML
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateBOMLimitedInfo" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt物料编号", "value": m_limitedMtno };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#limitedlist').datagrid(
        {
            //title: 'BOM信息', //表格标题
            url: url,
            async: false,
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
            rownumbers: true,//行号
            //onDblClickRow: onDblClickRowLimitedlist,//双击事件
            //onClickRow: onClickRowLimitedlist,//单击事件
            onLoadSuccess: function (data) {
                if ((data.rows.length == 1 && data.rows[0].pm1_mseq == undefined) || (data.rows.length == 1 && data.rows[0].pm1_mseq == "")) {
                    ClearGrid("#limitedlist");
                }
            },
            columns: [[
                { field: 'pm1_mseq', title: '序号', width: 60 },
                { field: 'pm1_mtno', title: '材料M3编号', width: 130 },
                { field: 'pn1_otyp', title: '选择型', width: 70 },
                { field: 'pn1_ftid', title: '特性组', width: 100 },
                { field: 'pn1_optn', title: '特性选项', width: 150 },
                { field: 'pn1_yyno', title: '样衣编号', width: 100 },
                { field: 'pn1_ince', title: '包含', width: 70 },
                { field: 'pn1_lmdt', title: '最后保存时间', width: 90, formatter: Formater.Date },
                { field: 'pn1_lmuser', title: '最后保存人', width: 70 }
            ]],
            toolbar: [
           {
               id: 'btnAddLimited',
               text: '新增',
               iconCls: 'icon-add',
               handler: function () {
                   addLimited();
               }
           },
           {
               id: 'btnDeleteLimited',
               text: '删除',
               iconCls: 'icon-cancel',
               handler: function () {
                   deleteLimited();
               }
           },
          {
              id: 'btnSaveLimited',
              text: '保存',
              iconCls: 'icon-save',
              handler: function () {
                  saveLimited();
              }
          },
          {
              id: 'btnCancelLimited',
              text: '退出',
              iconCls: 'icon-back',
              handler: function () {
                  calcelBOM("三层限定");
              }
          }]
        });

    col = $('#limitedlist').datagrid('getColumnOption', 'pn1_ince');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(m_ince, value);

        }
    }


}

//三层限定样衣信息重加载
function initGirdLimitedThreeSample() {
    $('#threesamplelist').datagrid(
        {
            //title: '样衣信息', //表格标题
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
            //onRowContextMenu: onRowContextMenu,
            fit: true,//自适应
            //onClickRow: onClickRow,//单击事件
            //onDblClickRow: onDblClickRow,
            //onLoadSuccess: function (data) {
            //},
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'measurementsid', title: '样版号', width: 80 },
                { field: 'dyyyno', title: '样衣号', width: 80 },
                { field: 'dycolorname', title: '颜色', width: 140 },
                { field: 'dyovdt', title: '完成时间', width: 100, formatter: Formater.Date }
            ]]
        });

    ClearGrid("#threesamplelist");//清除三层样衣信息
    $('#threesamplelist').datagrid("loadData", m_sampleData);//重加载限定数据
    comboboxForLimitedMeasurementsId(m_sampleData);//按照全局变量里面的值重组下拉.样衣和特性
}

//三层把样衣信息里面的2个字段转成josn 传到combobox的值dyyyno dycolorname
function comboboxForLimitedMeasurementsId(m_sampleData) {
    var comboboxData = [];
    for (var i = 0; i < m_sampleData.rows.length; i++) {
        var obj = new Object();
        obj.optn = m_sampleData.rows[i].dycolorname;
        obj.measurementsId = m_sampleData.rows[i].dyyyno;
        comboboxData.push(obj)
    }

    //初始化样衣下拉
    $('#formAddLimited #txtmeasurementsid').combobox({
        data: comboboxData,
        valueField: 'measurementsId',
        textField: 'measurementsId',
        panelHeight: '200',
        editable: false,
        required: true,
        onSelect: function (date5) {
            $('#formAddLimited #txtoptn').val(date5.optn);
        }
    });

    //初始化包含下拉
    $('#formAddLimited #txtince').combobox({
        data: m_ince,
        valueField: 'id',
        textField: 'text',
        panelHeight: '50',
        editable: false,
        required: true
    });
}

//-----------------------------------------------------------------------------------------------------------三层限定新增,保存,删除--
//三层限定新增
function addLimited() {
    //if (endEditingLimited) {
    //selectedBOM = $('#searchbomlist').datagrid('getSelected');//取二层选中的数据
    var selectedLimitedListData = $("#limitedlist").datagrid('getRows'); //获取限定所有行集合对象
    var selectedThreeSampleListData = $("#threesamplelist").datagrid('getRows'); //获取样衣所有行集合对象

    if (selectedThreeSampleListData.length == "1" || selectedThreeSampleListData.length == "0") {
        alert("不允许此操作.")
        return;
    }
    else if (selectedThreeSampleListData.length - 1 == selectedLimitedListData.length) {
        alert("不允许此操作.")
        return;
    }
    $('#DivAddLimited').show().window({
        title: "限定添加",
        top: 20,
        width: 615,
        height: 190,
        modal: true
    });



    var dataFtid = [];
    dataFtid[dataFtid.length] = { "name": "txtMeasurementsidJ", "value": m_searchBOMMeasurementsidJ };//样板号
    dataFtid[dataFtid.length] = { "name": "txtzt", "value": m_zt };//帐套

    //判断M3编号是否有权限
    var xmlData = GetFormJson(dataFtid, 'limitedftid');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    var ftidLimited = result.rows[0]['plmkey']//获取特性组


    $('#formAddLimited #txtmseq').val(selectedBOM.mseq);//序号
    $('#formAddLimited  #txtmtnolimited').val(selectedBOM.mtno);//材料M3编号
    $('#formAddLimited #txtopty').val("3");//选择型
    $('#formAddLimited #txtftid').val(ftidLimited);//特性组
    $('#formAddLimited #txtmeasurementsid').combobox('setValue', "");//样衣编号pn1_yyno
    $('#formAddLimited #txtoptn').val("");//特性选项
    $('#formAddLimited #txtince').val("");//包含
    $('#formAddLimited #txtlmdt').val(m_Nowdate);//最后保存时
    $('#formAddLimited #txtlmuser').val(m_Username);//最后保存人
    //}
}

//三层限定新增保存
function addSaveLimited() {
    if ($('#formAddLimited').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;
    } else {
        var selectedLimitedListASave = $("#limitedlist").datagrid('getRows'); //获取所有行集合对象

        if (selectedLimitedListASave.length != 0) {
            for (var i = 0; i < selectedLimitedListASave.length; i++) {
                var q = selectedLimitedListASave[i].pn1_yyno;//获取样衣编号
                var q1 = $('#formAddLimited #txtmeasurementsid').combobox('getText')
                if (q == q1) {
                    alert("样衣号已经有了!" + q);
                    return;
                }
            }
        }

        $('#limitedlist').datagrid('appendRow',
             {
                 rowindex: m_RowIndex++,
                 pm1_mseq: $('#formAddLimited #txtmseq').val(),//序号
                 pm1_mtno: $('#formAddLimited  #txtmtnolimited').val(),//材料M3编号
                 pn1_ftid: $('#formAddLimited #txtftid').val(),//特性组
                 pn1_otyp: $('#formAddLimited #txtopty').val(),//选择型
                 pn1_optn: $('#formAddLimited #txtoptn').val(),//特性选项
                 pn1_yyno: $('#formAddLimited #txtmeasurementsid').combobox('getText'),//样衣编号
                 pn1_ince: $('#formAddLimited #txtince').combobox('getValue'),//包含
                 pn1_lmdt: $('#formAddLimited #txtlmdt').val(),//最后保存时
                 pn1_lmuser: $('#formAddLimited #txtlmuser').val()//最后保存人
             });
        $('#DivAddLimited').window('close');
    }
}

//三层限定保存
function saveLimited() {
    var selectedLimitedList = $("#limitedlist").datagrid('getRows'); //获取所有行集合对象
    if (selectedLimitedList.length != 0) {
        for (var i = 0; i < selectedLimitedList.length; i++) {
            var c = selectedLimitedList[i].pn1_ince;//获取包含
            var f = selectedLimitedList[i].pn1_yyno;//获取样衣编号
            for (var j = 0; j < selectedLimitedList.length; j++) {
                var c1 = selectedLimitedList[j].pn1_ince;//获取对比包含
                var f1 = selectedLimitedList[j].pn1_yyno;//获取样衣编号
                if (i != j && c != "" && c1 != "" && c != c1) {
                    alert("包含必须全部同意,必须全部为是或者全部为否!");
                    return;
                }
                if (i != j && f != "" && f1 != "" && f == f1) {
                    alert("样衣号不能重复!" + f);
                    return;
                }
            }
        }
    }
    //if (endEditing()) {
    $dg = $("#limitedlist");
    if ($dg.datagrid('getChanges').length) {

        var dateUpdateLimited = [];
        var inserted = $dg.datagrid('getChanges', "inserted");
        var deleted = $dg.datagrid('getChanges', "deleted");
        var updated = $dg.datagrid('getChanges', "updated");

        for (var i = 0; i < inserted.length; i++) {
            inserted[i].transflag = "NEW";
            delete inserted[i].rowindex;
            dateUpdateLimited.push(inserted[i]);

        }
        for (var i = 0; i < deleted.length; i++) {
            deleted[i].transflag = "Delete";
            delete deleted[i].rowindex;
            dateUpdateLimited.push(deleted[i]);

        }
        for (var i = 0; i < updated.length; i++) {
            updated[i].transflag = "Alter";
            delete updated[i].rowindex;
            dateUpdateLimited.push(updated[i]);
        }
        var dateUpdateLimited = GetExcelXML(dateUpdateLimited);
        //return;
        var data = [];
        data[data.length] = { "name": "txt返回内容", "value": "必填" };
        data[data.length] = { "name": "txt实体", "value": "GetUpdateBOMLimitedInfo" };
        data[data.length] = { "name": "txt操作类型", "value": "Update" };
        data[data.length] = { "name": "txtCONO", "value": "HFYG" };
        data[data.length] = { "name": "txtDIVI", "value": m_zt };
        data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
        data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
        data[data.length] = { "name": "txt物料编号", "value": m_limitedMtno };//m_limitedMtno
        data[data.length] = { "name": "txt操作人", "value": m_Username };
        data[data.length] = { "name": "txtXML", "value": dateUpdateLimited, specialCharset: true };
        data[data.length] = { "name": "txtSTRT", "value": m_strt };
        var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8'),
            data: xmlData,
            type: 'POST',
            async: true,
            success: function (result) {
                try {
                    $.messager.progress("close");
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
                        $('#limitedlist').datagrid("reload");
                        //$('#searchbomlist').datagrid("reload");
                        $.messager.alert("提示", result[0].rows[0].msg);
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function (result) {
                $.messager.progress('close');
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
        //}
    }
    else {
        return;
    }

}

//三层限定删除
function deleteLimited() {
    var selected = $("#limitedlist").datagrid('getSelected'); //获取当前行的数据
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var index = $('#limitedlist').datagrid('getRowIndex', selected)
    $('#limitedlist').datagrid('deleteRow', index)
}
//
//-----------------------------------------------------------------------------------------------------------三层替代--
//三层替代点击
function replaceBOM() {

    if (m_flag_xdandtd == "2") {
        alert("请先保存.只有保存在数据库才能做替代");
        return;
    }

    selectedBOM = $('#searchbomlist').datagrid('getSelected');
    if (!selectedBOM) {
        alert("请选择一行数据");
        return;
    }
    if (endEditing()) {

        m_searchBOMDOrderseason = selectRow.orderseason;//一层行的订货会季节
        m_searchBOMMeasurementsidJ = selectRow.measurementsid;//一层行的样板号/为加载三层限定替代提供参数
        var M_productname = selectRow.productname;//一层款号
        m_replaceMtno = selectedBOM.mtno;//物料编号

        var data = [];
        data[data.length] = { "name": "txtMM1_ITNO", "value": m_replaceMtno }; //物料编号
        data[data.length] = { "name": "txtPM1_PRNO", "value": M_productname };//款号号
        data[data.length] = { "name": "txtzt", "value": m_zt };//帐套

        //判断M3编号是否有权限
        var xmlData = GetFormJson(data, 'GetVerificationReplace');
        htmlobj = $.ajax({
            url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
            data: { "XML": xmlData },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        var isoron = result.rows[0]['isoron']//判断是否有权限
        //如果权限有,就可以新增,如果没有弹窗
        if (isoron == 1) {
            $('#divReplace').show().window({
                title: "替代",
                top: 20,
                maximized: true,
                modal: true
            });

            ClearGrid("#replacelist")
            ClearGrid("#threesample_replacelist")
            initGirdReplace(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, m_replaceMtno); //获取加载三层限定数据
            initGirdReplaceThreeSample(); //获取加载三层替代数据
        } else {
            alert("此物料不能替代");
            return;
        }
    }
}

//三层替代数据加载
function initGirdReplace(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, m_replaceMtno) {
    //创建获取数据XML
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateBOMReplaceInfo" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt物料编号", "value": m_replaceMtno };//物料编号
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#replacelist').datagrid(
        {
            url: url,
            async: false,
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            collapsible: false, //可折叠
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            rownumbers: true,//行号
            //onRowContextMenu: onRowContextMenu,
            //onDblClickRow: onDblClickRow,//双击事件
            //onClickRow: onClickRow,//单击事件
            onLoadSuccess: function (data) {
                if ((data.rows.length == 1 && data.rows[0].hp1_mseq == undefined) || (data.rows.length == 1 && data.rows[0].hp1_mseq == "")) {
                    ClearGrid("#replacelist");
                }
            },
            columns: [[
                { field: 'hp1_mseq', title: '序号', width: 60 },
                { field: 'hp1_pfti', title: '成衣特性', width: 130 },//不可编辑
                { field: 'hp1_mfti', title: '物料特性', width: 70 },//CN02
                { field: 'hp1_xsbt', title: '替代类型', width: 100 },//都是1
                { field: 'hp1_lmdt', title: '最后保存时间', width: 90, formatter: Formater.Date },
                { field: 'hp1_lmuser', title: '最后保存人', width: 70 }//validatebox
            ]],
            toolbar: [
           {
               id: 'btnAddReplace',
               text: '新增',
               iconCls: 'icon-add',
               handler: function () {
                   addReplace();
               }
           },
           {
               id: 'btnDeleteReplace',
               text: '删除',
               iconCls: 'icon-cancel',
               handler: function () {
                   deleteReplace();
               }
           },
           {
               id: 'btnSaveReplace',
               text: '保存',
               iconCls: 'icon-save',
               handler: function () {
                   saveReplace();
               }
           },
           {
               id: 'btnSearchReplaceSub',
               text: '查看替代明细',
               iconCls: 'icon-search',
               handler: function () {
                   searchReplaceSub();
               }
           },
           {
               id: 'btnCancelReplace',
               text: '退出',
               iconCls: 'icon-back',
               handler: function () {
                   calcelBOM("三层替代");
               }
           }]
        });
}

//三层替代样衣信息重加载
function initGirdReplaceThreeSample() {
    $('#threesample_replacelist').datagrid(
        {
            //title: '样衣信息', //表格标题
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
            //onRowContextMenu: onRowContextMenu,
            fit: true,//自适应
            //onClickRow: onClickRow,//单击事件
            //onDblClickRow: onDblClickRow,
            //onLoadSuccess: function (data) {
            //},
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'measurementsid', title: '样版号', width: 80 },
                { field: 'dyyyno', title: '样衣号', width: 80 },
                { field: 'dycolorname', title: '颜色', width: 140 },
                { field: 'dyovdt', title: '完成时间', width: 100, formatter: Formater.Date }
            ]]
        });

    ClearGrid("#threesample_replacelist");
    $('#threesample_replacelist').datagrid("loadData", m_sampleData);//重加载限定数据
}

//-----------------------------------------------------------------------------------------------------------三层替代新增,保存,删除--
//三层替代新增
function addReplace() {
    var selectedReplace = $("#replacelist").datagrid('getRows'); //获取替代所有行集合对象
    if (selectedReplace.length == "2") {
        alert("不允许此操作!");
        return;
    }
    //if (endEditingLimited) {
    //var selectedBOM = $('#searchbomlist').datagrid('getSelected');//取二层选中的数据
    $('#DivAddReplace').show().window({
        title: "替代新增添加",
        top: 20,
        width: 415,
        height: 185,
        modal: true
    });


    //郭琦琦2014年7月21修改
    //物料特性做成下拉
    //物料特性AJAX

    var dataWL = [];
    dataWL[dataWL.length] = { "name": "txtHUSTYN", "value": m_replaceMtno };//物料
    dataWL[dataWL.length] = { "name": "txtzt", "value": m_zt };//帐套

    //物料特性
    $('#formAddReplace #txthp_mfti').combobox({
        url: GetComboxALLColumnWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson(dataWL, 'GetVerificationReplaceForWLTX'),
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function (data) {
            var selectThp_pfti = $('#formAddReplace #txthp_mfti').combobox('getValue');//获取物料特性为加载成衣特性做参数

            //成衣特性AJAX
            var data = [];
            data[data.length] = { "name": "txtOrderSeason", "value": m_searchBOMDOrderseason }; //季节
            data[data.length] = { "name": "txtMeasurementsId", "value": m_searchBOMMeasurementsidJ };//样板号
            data[data.length] = { "name": "txtCBSTKY", "value": selectThp_pfti };//XY判断物料特性和成衣特性
            data[data.length] = { "name": "txtzt", "value": m_zt };//帐套
            var xmlData = GetFormJson(data, 'GetVerificationReplaceForTX');
            htmlobj = $.ajax({
                url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
                data: { "XML": xmlData },
                type: 'post',
                async: false
            });
            var hp_pfti = $.parseJSON(htmlobj.responseText).rows[0].plmkey;//成衣特性
            $('#formAddReplace #txthp_pfti').val(hp_pfti);//成衣特性
        }
    });

    $('#formAddReplace #txthp_mfti').combobox('setValue', "");//物料特性//
    $('#formAddReplace #txthp_pfti').val("");//成衣特性
    $('#formAddReplace #txthp_mseq').val(selectedBOM.mseq);//序号
    $('#formAddReplace #txthp_xsbt').val("1");//替代类型
    $('#formAddReplace #txthp_lmdt').val(m_Nowdate);//最后保存时
    $('#formAddReplace #txthp_lmuser').val(m_Username);//最后保存人
}

//三层替代删除
function deleteReplace() {
    var selected = $("#replacelist").datagrid('getSelected'); //获取当前行的数据
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var index = $('#replacelist').datagrid('getRowIndex', selected)
    $('#replacelist').datagrid('deleteRow', index)
}

//三层替代新增保存
function addSaveReplace() {
    if ($('#formAddReplace').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;
    } else {

        var selectedreplacelistData = $("#replacelist").datagrid('getRows'); //获取3层替代主表所有行集合对象
        //验证的时候判断,样衣号是否唯一
        if (selectedreplacelistData.length != 0) {
            for (var i = 0; i < selectedreplacelistData.length; i++) {
                var g = selectedreplacelistData[i].hp1_mfti;//获取物料特性
                var g1 = $('#formAddReplace #txthp_mfti').combobox('getText').trim();
                if (g == g1) {
                    alert("物料特性已经有了!" + g);
                    return;
                }
            }
        }
        $('#replacelist').datagrid('appendRow',
             {
                 rowindex: m_RowIndex++,
                 hp1_mseq: $('#formAddReplace #txthp_mseq').val(),//序号
                 hp1_pfti: $('#formAddReplace  #txthp_pfti').val(),//成衣特性
                 hp1_mfti: $('#formAddReplace #txthp_mfti').combobox('getText'),//物料特性
                 hp1_xsbt: $('#formAddReplace #txthp_xsbt').val(),//替代类型
                 hp1_lmdt: $('#formAddReplace #txthp_lmdt').val(),//最后保存时间
                 hp1_lmuser: $('#formAddReplace #txthp_lmuser').val()//最后保存人
             });
        $('#DivAddReplace').window('close');
        m_flaf_tdzb = "2";
    }
}

//三层替代保存
function saveReplace() {
    var selectedLimitedList = $("#replacelist").datagrid('getRows'); //获取所有行集合对象
    if (selectedLimitedList.length < 3) {
        $dg = $("#replacelist");
        if ($dg.datagrid('getChanges').length) {
            var dateUpdateReplace = [];
            var inserted = $dg.datagrid('getChanges', "inserted");
            var deleted = $dg.datagrid('getChanges', "deleted");
            //var updated = $dg.datagrid('getChanges', "updated");

            for (var i = 0; i < deleted.length; i++) {
                deleted[i].transflag = "Delete";
                delete deleted[i].rowindex;
                dateUpdateReplace.push(deleted[i]);

            }

            for (var i = 0; i < inserted.length; i++) {
                inserted[i].transflag = "NEW";
                delete inserted[i].rowindex;
                dateUpdateReplace.push(inserted[i]);

            }

            //for (var i = 0; i < updated.length; i++) {
            //    updated[i].transflag = "Alter";
            //    delete updated[i].rowindex;
            //    dateUpdateReplace.push(updated[i]);
            //}
            var dateUpdateReplace = GetExcelXML(dateUpdateReplace);
            //return;
            var data = [];
            data[data.length] = { "name": "txt返回内容", "value": "必填" };
            data[data.length] = { "name": "txt实体", "value": "GetUpdateBOMReplaceInfo" };
            data[data.length] = { "name": "txt操作类型", "value": "Update" };
            data[data.length] = { "name": "txtCONO", "value": "HFYG" };
            data[data.length] = { "name": "txtDIVI", "value": m_zt };
            data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
            data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
            data[data.length] = { "name": "txt物料编号", "value": m_replaceMtno };
            data[data.length] = { "name": "txt操作人", "value": m_Username };
            data[data.length] = { "name": "txtXML", "value": dateUpdateReplace, specialCharset: true };
            data[data.length] = { "name": "txtSTRT", "value": m_strt };
            var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8'),
                data: xmlData,
                type: 'POST',
                async: true,
                success: function (result) {
                    try {
                        $.messager.progress("close");
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
                            $('#replacelist').datagrid("reload");
                            m_flaf_tdzb = "1";//变更替代子表权限标识
                            //$('#searchbomlist').datagrid("reload");
                            $.messager.alert("提示", result[0].rows[0].msg);
                        }
                    } catch (ex) {
                        $.messager.progress('close');
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function (result) {
                    $.messager.progress('close');
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    }
    else {
        alert("不能超过3条替代");
        return;
    }
}

//-----------------------------------------------------------------------------------------------------------四层替代子加载--
//四层替代子界面的主要操作
function searchReplaceSub() {

    selectedReplace = $('#replacelist').datagrid('getSelected');//取三层替代主选中的数据
    m_hp1_mfti = selectedReplace.hp1_mfti;
    if (m_flaf_tdzb == "2") {
        alert("请先保存!");
        return;
    }

    if (!selectedReplace) {
        alert("请选择一条替代数据"); return;
    } else {

        $('#divReplaceSub').show().window({
            title: "替代子表",
            maximized: true,
            modal: true
        });
        $('#formReplaceSub #txtreplacemeasurementsid').val(m_searchBOMMeasurementsidJ);
        $('#formReplaceSub #txtreplacemtno').val(m_replaceMtno);
        $('#formReplaceSub #txtreplacewltx').val(selectedReplace.hp1_mfti);
        ClearGrid("#replaceSubList")
        initGirdReplaceSub(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, m_replaceMtno, selectedReplace.m_hp1_mfti); //获取加载四层替代数据
    }
}

//四层替代子界面数据加载
function initGirdReplaceSub(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, m_replaceMtno, hp1_mfti) {
    //创建获取数据XML
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateBOMSubReplaceInfo" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt物料编号", "value": m_replaceMtno };
    data[data.length] = { "name": "txt物料特性", "value": m_hp1_mfti };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#replaceSubList').datagrid(
        {
            //title: 'BOM信息', //表格标题
            url: url,
            async: false,
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
            rownumbers: true,//行号
            //onDblClickRow: onDblClickRowLimitedlist,//双击事件
            //onClickRow: onClickRowLimitedlist,//单击事件
            onLoadSuccess: function (data) {
                if ((data.rows.length == 1 && data.rows[0].hm1_mseq == undefined) || (data.rows.length == 1 && data.rows[0].hm1_mseq == "")) {
                    ClearGrid("#replaceSubList");
                }
            },
            columns: [[
                { field: 'hm1_mseq', title: '序号', width: 60 },
                { field: 'hm1_popt', title: '成衣特性', width: 130 },
                { field: 'hm1_mopt', title: '物料特性明细', width: 90 },
                { field: 'hm1_yyno', title: '对应样衣号', width: 100 },
                { field: 'hm1_lmuser', title: '最后保存人', width: 150 },
                { field: 'hm1_lmdt', title: '最后修改时间', width: 100, formatter: Formater.Date }
            ]],
            toolbar: [
           {
               id: 'btnAddReplaceSub',
               text: '新增',
               iconCls: 'icon-add',
               handler: function () {
                   addReplaceSub();
               }
           },
           {
               id: 'btnDeleteReplaceSub',
               text: '删除',
               iconCls: 'icon-cancel',
               handler: function () {
                   deleteReplaceSub();
               }
           },
          {
              id: 'btnSaveReplaceSub',
              text: '保存',
              iconCls: 'icon-save',
              handler: function () {
                  saveReplaceSub();
              }
          },
          {
              id: 'btnCancelReplaceSub',
              text: '退出',
              iconCls: 'icon-back',
              handler: function () {
                  calcelBOM("四层替代子表");
              }
          }]
        });
}

//-----------------------------------------------------------------------------------------------------------四层替代子新增,保存,删除--
////四层替代子新增
function addReplaceSub() {

    var selectedThreesample_replacelistData = $("#threesample_replacelist").datagrid('getRows'); //获取3层替代表里面的样衣信息
    var selectedReplaceSubList = $('#replaceSubList').datagrid('getRows');//获取四层替代子表里面的信息

    //无样衣信息不给新增
    if (selectedThreesample_replacelistData.length == "0") {
        alert("不能进行此操作");
        return;
    }

    //如果不能超过样衣信息的样衣数量
    if (selectedReplaceSubList.length == selectedThreesample_replacelistData.length) {
        alert("不能进行此操作");
        return;
    }

    $('#DivAddReplaceSub').show().window({
        title: "替代新增添加",
        top: 20,
        width: 615,
        height: 155,
        modal: true
    });

    var comboboxDataReplace = [];
    for (var i = 0; i < m_sampleData.rows.length; i++) {
        var obj = new Object();
        obj.optn = m_sampleData.rows[i].dycolorname;
        obj.measurementsId = m_sampleData.rows[i].dyyyno;
        comboboxDataReplace.push(obj)
    }

    $('#formAddReplaceSub #txthm1_mopt').combobox({});

    //初始化样衣下拉
    $('#formAddReplaceSub #txthm1_yyno').combobox({
        data: comboboxDataReplace,
        valueField: 'measurementsId',
        textField: 'measurementsId',
        panelHeight: '200',
        editable: false,
        required: true,
        onSelect: function (data) {
            var ynnooReplace = $('#formAddReplaceSub #txthm1_yyno').combobox('getValue');

            //郭琦琦20140722修改按照类型,判断成衣特性
            if (selectedReplace.hp1_mfti.substr(0, 1).toUpperCase() == "S") {
                $('#formAddReplaceSub #txthm1_popt').val("AM020")
            } else {
                var dataCYTXSub = [];
                dataCYTXSub[dataCYTXSub.length] = { "name": "txtdyyyno", "value": ynnooReplace }; //样衣号
                dataCYTXSub[dataCYTXSub.length] = { "name": "txtzt", "value": m_zt }; //帐套
                //判断M3编号是否有权限
                var xmlData = GetFormJson(dataCYTXSub, 'GetVerificationReplaceForCYTXSub');
                htmlobj = $.ajax({
                    url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
                    data: { "XML": xmlData },
                    type: 'post',
                    async: false
                });
                var result = $.parseJSON(htmlobj.responseText);
                $('#formAddReplaceSub #txthm1_popt').val(result.rows[0]['dycolorname'])
            }

            //郭琦琦修改物料特性也按照样衣联动
            //物料特性SubAJAX
            var dataWLSub = [];
            dataWLSub[dataWLSub.length] = { "name": "txthmftiy", "value": selectedReplace.hp1_mfti };//三层选中替代主表成衣特性
            dataWLSub[dataWLSub.length] = { "name": "txthm1_mseq", "value": selectedReplace.hp1_mseq };//三层选中替代主表序号
            dataWLSub[dataWLSub.length] = { "name": "txthmitno", "value": m_replaceMtno };//物料编号
            dataWLSub[dataWLSub.length] = { "name": "txtdyyyno", "value": ynnooReplace };//样衣编号
            dataWLSub[dataWLSub.length] = { "name": "txtzt", "value": m_zt };//m_zt

            $('#formAddReplaceSub #txthm1_mopt').combobox({
                url: GetComboxALLColumnWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson(dataWLSub, 'GetVerificationReplaceForWLTXSub'),
                panelHeight: '200',
                editable: false,
                valueField: 'id',
                textField: 'text',
                required: true
            });
        }
    });

    $('#formAddReplaceSub #txthm1_mseq').val(selectedBOM.mseq);//二层BOM信息里面的序号
    $('#formAddReplaceSub #txthm1_popt').val("");//成衣特性
    $('#formAddReplaceSub #txthm1_mopt').combobox('setValue', "");//物料特性//
    $('#formAddReplaceSub #txthm1_yyno').combobox('setValue', "");//对应样衣号
    $('#formAddReplaceSub #txthm1_lmuser').val(m_Username);//最后保存人
    $('#formAddReplaceSub #txthm1_lmdt').val(m_Nowdate);//最后保存时
}

//四层替代子新增保存
function addSaveReplaceSub() {
    if ($('#formAddReplaceSub').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;
    } else {
        var selectedReplaceSubList = $("#replaceSubList").datagrid('getRows'); //获取所有行集合对象
        //验证的时候判断,样衣号是否唯一
        if (selectedReplaceSubList.length != 0) {
            for (var i = 0; i < selectedReplaceSubList.length; i++) {
                var u = selectedReplaceSubList[i].hm1_yyno;//获取样衣编号
                var u1 = $('#formAddReplaceSub #txthm1_yyno').combobox('getText')
                if (u == u1) {
                    alert("样衣号已经有了!" + u);
                    return;
                }
            }
        }
        $('#replaceSubList').datagrid('appendRow',
             {
                 rowindex: m_RowIndex++,
                 hm1_mseq: $('#formAddReplaceSub #txthm1_mseq').val(),//序号
                 hm1_popt: $('#formAddReplaceSub  #txthm1_popt').val(),//成衣特性
                 hm1_mopt: $('#formAddReplaceSub #txthm1_mopt').combobox('getValue'),//物料特性
                 hm1_yyno: $('#formAddReplaceSub #txthm1_yyno').combobox('getValue'),//对应样衣号
                 hm1_lmdt: $('#formAddReplaceSub #txthm1_lmdt').val(),//最后保存时间
                 hm1_lmuser: $('#formAddReplaceSub #txthm1_lmuser').val()//最后保存人
             });
        $('#DivAddReplaceSub').window('close');
    }
}

//四层替代子删除
function deleteReplaceSub() {
    var selectedReplace = $("#replaceSubList").datagrid('getSelected'); //获取当前行的数据
    if (!selectedReplace) {
        alert('请选择一行');
        return;
    }
    var indexReplace = $('#replaceSubList').datagrid('getRowIndex', selectedReplace)
    $('#replaceSubList').datagrid('deleteRow', indexReplace)
}

//四层替代子保存
function saveReplaceSub() {
    var selectedReplaceSubList = $("#replaceSubList").datagrid('getRows'); //获取所有行集合对象

    //验证的时候判断,样衣号是否唯一
    for (var i = 0; i < selectedReplaceSubList.length; i++) {
        var d = selectedReplaceSubList[i].hm1_yyno;//获取样衣

        for (var j = 0; j < selectedReplaceSubList.length; j++) {
            var d1 = selectedReplaceSubList[j].hm1_yyno;//获取对比序号
            if (i != j && d != "" && d1 != "" && d == d1) {
                alert("样衣号不能重复，请删除重新新建 " + d)
                return;
            }
        }
    }
    $dg = $("#replaceSubList");
    //if ($dg.datagrid('getChanges').length) {
    var dateUpdateReplaceSub = [];
    var inserted = $dg.datagrid('getChanges', "inserted");
    var deleted = $dg.datagrid('getChanges', "deleted");
    //var updated = $dg.datagrid('getChanges', "updated");

    for (var i = 0; i < deleted.length; i++) {
        deleted[i].transflag = "Delete";
        delete deleted[i].rowindex;
        dateUpdateReplaceSub.push(deleted[i]);
    }

    for (var i = 0; i < inserted.length; i++) {
        inserted[i].transflag = "NEW";
        delete inserted[i].rowindex;
        dateUpdateReplaceSub.push(inserted[i]);

    }

    //for (var i = 0; i < updated.length; i++) {
    //    updated[i].transflag = "Alter";
    //    delete updated[i].rowindex;
    //    dateUpdateReplace.push(updated[i]);
    //}
    dateUpdateReplaceSub = GetExcelXML(dateUpdateReplaceSub);
    //return;
    var data = [];
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateBOMSubReplaceInfo" };
    data[data.length] = { "name": "txt操作类型", "value": "Update" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt物料编号", "value": m_replaceMtno };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txt物料特性", "value": m_hp1_mfti };
    data[data.length] = { "name": "txtXML", "value": dateUpdateReplaceSub, specialCharset: true };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8'),
        data: xmlData,
        type: 'POST',
        async: true,
        success: function (result) {
            try {
                $.messager.progress("close");
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
                    $('#replaceSubList').datagrid("reload");
                    //$('#searchbomlist').datagrid("reload");
                    $.messager.alert("提示", result[0].rows[0].msg);
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function (result) {
            $.messager.progress('close');
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
    //}
}

//取消
function calcelBOM(type) {
    if (type == "二层BOM") {
        $('#divsearch').window('close');
    }
    else if (type == "新建工序") {
        $('#DivGX').window('close');
    }
    else if (type == "三层限定") {
        $('#divlimited').window('close');
    }
    else if (type == "限定新增") {
        $('#DivAddLimited').window('close');
    }
    else if (type == "三层替代") {
        $('#divReplace').window('close');
    }
    else if (type == "替代新增") {
        $('#DivAddReplace').window('close');
    }
    else if (type == "四层替代子表") {
        $('#divReplaceSub').window('close');
    }
    else if (type == "替代子表新增") {
        $('#DivAddReplaceSub').window('close');
    }
    else if (type == "样衣价格") {
        $('#divSamplePrice').window('close');
    }
    else if (type == "选择BOM基础") {
        $('#divselectbombasic').window('close');
    }
};

//-----------------------------------------------------------------------------------------------------------五层样衣价格--
//五层样衣价格界面的主要操作
function samplePriceList() {

    selectedSamplelist = $('#samplelist').datagrid('getSelected');//取二层样衣信息
    if (!selectedSamplelist) {
        alert("请选择一条样衣"); return;
    } else {

        samplehao = selectedSamplelist.dyyyno;

        $('#divSamplePrice').show().window({
            title: "样衣价格",
            maximized: true,
            modal: true
        });
        ClearGrid("#samplepricelist")
        initGirdSampleprice(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, samplehao); //五层样衣价格
    }
}

//五层样衣价格界面数据加载
function initGirdSampleprice(m_searchBOMDOrderseason, m_searchBOMMeasurementsidJ, samplehao) {
    //创建获取数据XML
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateSampleBOMList" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
    data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
    data[data.length] = { "name": "txt样衣号", "value": samplehao };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txtSTRT", "value": m_strt };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8') + xmlData
    $('#samplepricelist').datagrid(
        {
            //title: 'BOM信息', //表格标题
            url: url,
            async: false,
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
            rownumbers: true,//行号
            showFooter: true,
            onClickCell: onClickCell,//单元格操作
            onLoadSuccess: function (data) {
                if ((data.rows.length == 1 && data.rows[0].mseq == undefined) || (data.rows.length == 1 && data.rows[0].mseq == "")) {
                    ClearGrid("#samplepricelist");
                };
                if (m_num > 0) { $("#btnSaveSampleprice").show(); }
                else { $("#btnSaveSampleprice").hide(); };
                autoCostPrice();//自动计算合计
                footer();
            },
            onError: function (data) { alert("加载出错,请联系管理员") },
            columns: [[
                { field: 'mseq', title: '序号', width: 60 },
                { field: 'mtno', title: 'M3编号', width: 130, align: 'right' },
                { field: 'cnqt', title: '用量', width: 70, align: 'right', formatter: Formater.Account1 },
                { field: 'itds', title: '描述', width: 150 },
                { field: 'unms', title: '单位', width: 60, align: 'right' },
                {
                    field: 'price', title: '价格', width: 70, align: 'right', editor: { type: 'numberbox', options: { precision: '2', required: false } },
                    formatter: function (value) { if (value == undefined || value == '0.000000') { return ""; } else { return Formater.Account(value); } }
                },
                { field: 'cost', title: '合计', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'remark', title: '备注', width: 150, editor: { type: 'validatebox', options: { required: false } } }
            ]],
            toolbar: [
          {
              id: 'btnSaveSampleprice',
              text: '保存',
              iconCls: 'icon-save',
              hidden: true,
              handler: function () {
                  saveSamplePrice();
              }
          },
            {
                id: 'btnCancelSampleprice',
                text: '退出',
                iconCls: 'icon-back',
                handler: function () {
                    calcelBOM("样衣价格");
                }
            }]
        });
}

//合计算法
function footer() {
    var data = $('#samplepricelist').datagrid("getData");
    var sumNumber = "";//定义一个数量求和

    //循环数量和结算金额累加
    for (var i = 0; i < data.rows.length; i++) {
        sumNumber = sumNumber * 1 + data.rows[i]["cost"] * 1;
    }
    //C重组JOSN.添加FOOTER
    var footer = [{ "unms": "<font color='red' size='2'>合计</font>", "cost": sumNumber }];
    //data.footer = footer;
    //重加载数据
    $('#samplepricelist').datagrid('reloadFooter', footer)
}


//单元格修改
function onClickCell(index, field) {
    if (endEditingsampleprice()) {

        var selecttotalPriceRowsgx = $('#samplepricelist').datagrid('getRows');
        if (index == selecttotalPriceRowsgx.length - 1) {
            return;
        }

        $('#samplepricelist').datagrid('selectRow', index)
                .datagrid('editCell', { index: index, field: field });
        m_editIndex = index;
    }
}

//编辑样衣物料清单结束编辑
function endEditingsampleprice() {
    if (m_editIndex == undefined) {
        footer();
        return true;
    }
    if ($('#samplepricelist').datagrid('validateRow', m_editIndex)) {
        $('#samplepricelist').datagrid('endEdit', m_editIndex);
        totalPrice(m_editIndex);
        m_editIndex = undefined;
        footer();
        return true;
    } else {
        return false;
    }
}

//自动汇总单价*数量
function totalPrice(m_editIndex) {

    var selecttotalPriceRows = $('#samplepricelist').datagrid('getRows')[m_editIndex];

    var cnqt = selecttotalPriceRows.cnqt; //数量
    var price = selecttotalPriceRows.price; //单价
    var totalcost = (cnqt * 1) * (price * 1);

    $('#samplepricelist').datagrid('updateRow', {
        index: m_editIndex,
        row:
        {
            cost: totalcost
        }
    });

}

//自动计算合计
function autoCostPrice() {
    var selecttotalPriceRows = $('#samplepricelist').datagrid('getRows');

    if (selecttotalPriceRows.length != 0) {
        for (var i = 0; i < selecttotalPriceRows.length ; i++) {
            var cnqt = selecttotalPriceRows[i].cnqt; //数量
            var price = selecttotalPriceRows[i].price; //单价
            var totalcost = (cnqt * 1) * (price * 1);
            $('#samplepricelist').datagrid('updateRow', {
                index: i,
                row:
                {
                    cost: totalcost
                }
            });
        }
        var costSum = $('#samplepricelist').datagrid('getRows')[selecttotalPriceRows.length - 1].price
        $('#samplepricelist').datagrid('updateRow', {
            index: selecttotalPriceRows.length - 1,
            row:
            {
                cost: costSum
            }
        });
    }
}

function sumTotal() {

    var selecttotalPriceRows1 = $('#samplepricelist').datagrid('getRows');

    if (selecttotalPriceRows1.length != 0) {
        var sumTotal = "";
        for (var c = 0; c < selecttotalPriceRows1.length - 1 ; c++) {
            sumTotal = sumTotal * 1 + selecttotalPriceRows1[c].cost * 1
        }
        //var index = selecttotalPriceRows1.length;
        $('#samplepricelist').datagrid('updateRow', {
            index: selecttotalPriceRows1.length - 1,
            row:
            {
                cost: sumTotal
            }
        });
    }
}


//保存样衣物料清单价格
function saveSamplePrice() {
    var saveSamplePrice = $("#samplepricelist").datagrid('getRows'); //获取所有行集合对象
    if (endEditingsampleprice()) {
        $dg = $("#samplepricelist");
        //if ($dg.datagrid('getChanges').length) {

        var dateUpdatedSamplePrice = [];
        //var updated = $dg.datagrid('getChanges', "updated");
        //修改全保存
        for (var i = 0; i < saveSamplePrice.length; i++) {
            saveSamplePrice[i].transflag = "Alter";
            delete saveSamplePrice[i].rowindex;
            dateUpdatedSamplePrice.push(saveSamplePrice[i]);
        }
        var dateUpdatedSamplePrice = GetExcelXML(dateUpdatedSamplePrice);
        //return;
        var data = [];
        data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
        data[data.length] = { "name": "txt实体", "value": "GetUpdateSampleBOMList" };
        data[data.length] = { "name": "txt返回内容", "value": "必填" };
        data[data.length] = { "name": "txtCONO", "value": "HFYG" };
        data[data.length] = { "name": "txtDIVI", "value": m_zt };
        data[data.length] = { "name": "txt样衣号", "value": samplehao };
        data[data.length] = { "name": "txt订货会季节", "value": m_searchBOMDOrderseason };
        data[data.length] = { "name": "txt样板号", "value": m_searchBOMMeasurementsidJ };
        data[data.length] = { "name": "txt操作人", "value": m_Username };
        data[data.length] = { "name": "txtXML", "value": dateUpdatedSamplePrice, specialCharset: true };
        data[data.length] = { "name": "txtSTRT", "value": m_strt };
        var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('adeb3eda-43df-4c82-a5b3-38f18c216ed8'),
            data: xmlData,
            type: 'POST',
            async: true,
            success: function (result) {
                try {
                    $.messager.progress("close");
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
                        $('#samplepricelist').datagrid("reload");
                        //$('#searchbomlist').datagrid("reload");
                        $.messager.alert("提示", result[0].rows[0].msg);
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function (result) {
                $.messager.progress('close');
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
        //}
    }
}
