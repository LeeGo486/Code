
var m_username = ""; //定义登入名
var htmlobj = "";
var m_zt = ""; //定义帐套
var m_DDHComboxData = null; //定义订货会季节下拉
var m_columns = ""; //定义动态列
var dataPie = [];

//初始化
$(function () {
    m_username = $.cookie('m_UserNameC'); //取登入姓名
    m_zt = $.cookie('m_zt');

    //获取品牌
    initBrand();
    //var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt}], 'GetOwnedBrand');
    //htmlobj = $.ajax({
    //    url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
    //    data: { "XML": xmlData },
    //    type: 'post',
    //    async: false //异步
    //});
    //var result = $.parseJSON(htmlobj.responseText);
    //新定义一个数组,从URL获取的数据拼接成品牌combobox数据
    //var dataBrand = [];
    //dataBrand[0] = { "text": result.rows[0]["ownedbrand"], "value": result.rows[0]["ownedbrand"], "selected": true };
    //for (var i = 1; i < result.rows.length; i++) {
    //    dataBrand[i] = { "text": result.rows[i]["ownedbrand"], "value": result.rows[i]["ownedbrand"] };
    //}
    //$("#txtbrand").combobox('loadData', dataBrand);

    //获取订货会季节
    $('#txtcmbdhhjj').combobox({
        url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        async: false, //异步
        onLoadSuccess: function (data) {
            if (m_DDHComboxData == null) {
                m_DDHComboxData = data;
                ChangeDHHJJ(); //按照品牌控制季节下拉
            }
            data1 = $('#txtcmbdhhjj').combobox('getData');
            $('#txtcmbdhhjj').combobox('setValue', data1[data1.length - 1].text);
        }
    });
    //初始统计方式下拉数据
    $("#txtcmdtjfs").combobox({
        data: [{ "text": "品类", "value": "category" }, { "text": "系列", "value": "boduanseries" }, { "text": "设计师", "value": "Designer"}],
        valueField: 'value',
        textField: 'text',
        panelHeight: 'auto',
        onLoadSuccess: function (data) {
            $('#txtcmdtjfs').combobox('setValue', data[0].text);
        }
    });

});

//Brand
//初始化品牌
function initBrand() {
    //品牌
    $("#txtbrand").combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbstky", "cbstky") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        valueField: 'id',
        textField: 'text',
        width: '100',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false,//同步
        onSelect: function (record) {
            ChangeDHHJJ();
        }
    });

    //取该人的品牌USERINFO表OwnedBrand字段判断品牌
    var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText),
        ownedBrand = result.rows[0].message,
        ownedType = typeof ownedBrand;
    $("#txtbrand").combobox('setValue', ownedBrand);//把品牌赋值给HTML品牌

    //if (ownedType != "undefined") {
    //    getSampleWorker(ownedBrand);
    //};
}

//按照品牌控制季节下拉数据
function ChangeDHHJJ() {
    var brand = $('#txtbrand').combobox('getValue');
    if (brand.substr(0, 2) == "EP") {
        brand = "EP"
    }
    else if (brand.substr(0, 2) == "E.P") {
        brand = "E.Prospe"
    }
    else if (brand.substr(0, 2) == "Do") {
        brand = "Do"
    }
    else if (brand.substr(0, 2) == "Ki") {
        brand = "Kids"
    }
    if (m_DDHComboxData == null) {
        return;
    }
    var data = m_DDHComboxData;
    var data1 = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].id.toString().indexOf(brand) > 0) {
            data1.push(data[i]);
        }
    }
    $('#txtcmbdhhjj').combobox({ url: "" });
    $('#txtcmbdhhjj').combobox("loadData", data1); //重加载季节下拉数据
}

//查询按钮
function SearchClick() {
    var tjfs = $('#txtcmdtjfs').combobox('getText').toString();
    var dhhjj = $('#txtcmbdhhjj').combobox('getValue').toString();
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetAlterMeasurementSuccessRate" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txt数据标识", "value": 1 }; //标识符
    data[data.length] = { "name": "txtDIVI", "value": "EP" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txt订货会季节", "value": dhhjj }; //"2015 - EP - 春夏"
    data[data.length] = { "name": "txt品牌", "value": $('#txtbrand').combobox('getValue') }; //"EP"
    data[data.length] = { "name": "txt统计方式", "value": tjfs }; //"系列"

    //获取动态列
    var colData = [];
    colData[colData.length] = { "name": "txt操作类型", "value": "GET" };
    colData[colData.length] = { "name": "txt实体", "value": "GetAlterMeasurementSuccessRate" };
    colData[colData.length] = { "name": "txt返回内容", "value": "必填" };
    colData[colData.length] = { "name": "txt数据标识", "value": 0 }; //标识符
    colData[colData.length] = { "name": "txtDIVI", "value": "EP" };
    colData[colData.length] = { "name": "txtCONO", "value": "HFYG" };
    colData[colData.length] = { "name": "txt订货会季节", "value": dhhjj }; //"2015 - EP - 春夏"
    colData[colData.length] = { "name": "txt品牌", "value": $('#txtbrand').combobox('getValue') }; //"EP"
    colData[colData.length] = { "name": "txt统计方式", "value": tjfs }; //"系列"
    initGird(colData, data);
    InitPie();
}


//datagrid绑定数据
function initGird(colData, data) {
    var xmlColData = GetDBFrameAML(colData);
    var xmlData = GetDBFrameAML(data);
    var colobj = $.ajax({
        url: GetGridColumnsWSRRURL('208357ed-8ff9-4cb6-9cfc-7fa343fc6210', "", "false", "false") + xmlColData,
        async: false
    });
    //定义列名跟列数据格式
    var colText = $.parseJSON(colobj.responseText);
    m_columns = colText.Col;
    m_columns = eval(m_columns);
    m_columns[0][m_columns[0].length - 8].title = "AAA版次总数";
    m_columns[0][m_columns[0].length - 7].title = "AAA版次总数/总款数";
    m_columns[0][m_columns[0].length - 7].formatter = function (field) { return parseFloat(field).toFixed(4); };
    m_columns[0][m_columns[0].length - 6].title = "AAA当次版成功数";
    m_columns[0][m_columns[0].length - 5].title = "AAA当次版失败数";
    m_columns[0][m_columns[0].length - 4].title = "AAA成功数在当次版占比";
    m_columns[0][m_columns[0].length - 4].formatter = toRound;
    m_columns[0][m_columns[0].length - 3].title = "AAA失败数在当次版占比";
    m_columns[0][m_columns[0].length - 3].formatter = toRound;
    m_columns[0][m_columns[0].length - 2].title = "AAA成功数在总数中占比";
    m_columns[0][m_columns[0].length - 2].formatter = toRound;
    m_columns[0][m_columns[0].length - 1].title = "AAA失败数在总数中占比";
    m_columns[0][m_columns[0].length - 1].formatter = toRound;
    m_columns[0][0].title = "AAAN次调版";
    //截掉列名前面的3个字母
    for (var x = 0; x < m_columns[0].length; x++) {
        m_columns[0][x].title = m_columns[0][x].title.substring(3).toUpperCase();
    }
    //获取数据,用以loadData方法加载到datagrid中
    var dataObj = $.ajax({
        url: GetWSRRURL('208357ed-8ff9-4cb6-9cfc-7fa343fc6210') + xmlData,
        async: false
    });
    var datagridData = $.parseJSON(dataObj.responseText);

    $('#tabList').datagrid({
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true,
        async: false,
        fit: true,
        columns: m_columns,
        rowStyler: function (index, row) {
            if (row.num == "Z合计") {
                return 'background-color:#d44864;color:#000000;font-weight:bold;';
            }
        },
        onLoadSuccess: function (data) {
            dataPie = [];
            if (data.rows.length - 1 > 0) {
                for (var y = 0; y < data.rows.length - 1; y++) {
                    dataPie[dataPie.length] = { "name": data.rows[y].num + '次调版', "y": parseFloat(data.rows[y].rate1).toFixed(4) * 10 };
                }
                dataPie[0].sliced = true;
                dataPie[0].selected = true;
            }
        }
    });

    $('#tabList').datagrid('loadData', datagridData); //loadData

}

//保留两位小数
function toRound(value) {
    if (value) {
        return parseFloat(value).toFixed(2);
    }
}

function InitPie() {
    $('#container').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '各次调版的款式数在总数量所占比例',
            style: { fontSize: '20px' }
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: { fontSize: '15px' }
                }
            }
        },
        series: [{
            type: 'pie',
            name: '版次总数/总款数',
            data: dataPie
        }],
        credits: {
            enabled: false // 禁用版权信息
        },
        colors: [ '#CCCCCC','#d44864', '#434343', '#CC9999','666666','CC3333']
    });
}

