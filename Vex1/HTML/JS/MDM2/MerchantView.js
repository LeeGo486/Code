var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0006";
var m_ComBodyID = null;

//初始化
$(function () {

    var htmlobj = $.ajax({ url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') ,
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName)}]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    //txtCom
    $('#txtCom').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0001&PropertyName=" + escape("公司中文简称"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: function (newValue, oldValue) { InitGird(newValue, oldValue) }
    });
})

//初始化表格
function InitGird(newValue, oldValue) {
    ClearGrid("#tab_list");

    m_ComBodyID = newValue;
    $('#tab_list').datagrid(
        {
            title: '加盟商信息', //表格标题
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&where=body_id_0001='" + m_ComBodyID + "'",
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName}]) },

            columns: eval(m_columns),
            width:'100%',
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20 //默认一页数据条数
        }
        );


        var $dg = $('#tab_list');
        $dg.datagrid("hideColumn", "timestamps");
        $dg.datagrid("hideColumn", "rowindex");
        $dg.datagrid("hideColumn", "body_id_0010");
        $dg.datagrid("hideColumn", "公司中文简称");
        $dg.datagrid("hideColumn", "body_id_0001");

        var col = $dg.datagrid('getColumnOption', '加盟商编码');
        col.editor = {};

        $dg.datagrid();
}

