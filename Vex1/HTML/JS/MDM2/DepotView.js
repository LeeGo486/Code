var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013";
var m_MerchantBodyID = null;
var m_MerchantData = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_ShopState = [{ "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }];
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }]


//初始化
$(function () {

    var htmlobj = $.ajax({ url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName)}]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    $('#txtfrozenstate').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": 0, "text": "未冻结", "selected": true }, { "id": 1, "text": "冻结" }, { "id": 3, "text": "所有" }],
        panelHeight: 'auto',
        editable: false,
        onChange: InitGird,
        onLoadSuccess: InitGird
        //onBeforeLoad: InitGird

    });


    InitGird();
})

//初始化表格
function InitGird() {
 

    //加盟商
    var htmlobj = $.ajax({ url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0006&PropertyName=" + escape("加盟商简称") ,
        async: false
    });
    m_MerchantData = jQuery.parseJSON(htmlobj.responseText);


    //县级市
    htmlobj = $.ajax({ url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0011&PropertyName=" + escape("名称"),
        async: false
    });
    m_AreaData = jQuery.parseJSON(htmlobj.responseText);


    //销售大区
    htmlobj = $.ajax({ url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0014&PropertyName=" + escape("名称") ,
        async: false
    });
    m_SaleAreaData = jQuery.parseJSON(htmlobj.responseText);




      
    var strFrozenstate = $('#txtfrozenstate').combobox('getValue');

    if (strFrozenstate == "") {
        strFrozenstate = "0";
    }
    var strURL = GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b');
    if (strFrozenstate != "3") {
        strURL += "&Where=" + escape("冻结状态") + " ='" + strFrozenstate + "'";
    }

    $('#tab_list').datagrid(
        {
            title: '店铺信息', //表格标题
            url:strURL,
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName}]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20 
        }
        );
        var $dg = $('#tab_list');


        $dg.datagrid("hideColumn", "timestamps");
        $dg.datagrid("hideColumn", "rowindex");
        $dg.datagrid("hideColumn", "body_id_0006");
        $dg.datagrid("hideColumn", "body_id");
        $dg.datagrid("hideColumn", "加盟商名称");
        $dg.datagrid("hideColumn", "body_id_l0011");
        $dg.datagrid("hideColumn", "body_id_0006");
        $dg.datagrid("hideColumn", "body_id_0001");
        $dg.datagrid("hideColumn", "body_id_0008");
        $dg.datagrid("hideColumn", "所属大区");

        var col = $dg.datagrid('getColumnOption', '店铺id');
        col.editor = {};

        col = $dg.datagrid('getColumnOption', 'body_id_l0006');
        col.title = "加盟商";
        col.searchfield = "加盟商名称";
        //col.editor = {};
        col.editor = { type: 'combobox', options: { data: m_MerchantData, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text'} }
        col.formatter = function (value) {
            return GetCommboboxText(m_MerchantData, value);
        }

        col = $dg.datagrid('getColumnOption', 'body_id_l0011');
        col.title = "县级市";
        col.editor = { type: 'combobox', options: { data: m_AreaData, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text'} }
        col.formatter = function (value) {
            return GetCommboboxText(m_AreaData, value);
        }

        col = $dg.datagrid('getColumnOption', 'body_id_l0014');
        col.title = "所属大区";
        col.searchfield = "所属大区";
        col.editor = { type: 'combobox', options: { data: m_SaleAreaData, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text'} }
        col.formatter = function (value) {
            var date = GetCommboboxText(m_SaleAreaData, value);
            return date;
        }


        col = $dg.datagrid('getColumnOption', '店铺型态');
        if (col != null) {
            col.formatter = function (value) {

                return GetCommboboxText(m_ShopState, value);

            }
        }
        col = $dg.datagrid('getColumnOption', '冻结状态');
        if (col != null) {
            col.formatter = function (value) {

                return GetCommboboxText(FrozenStus, value);

            }
        }


  
        $dg.datagrid();
       
}