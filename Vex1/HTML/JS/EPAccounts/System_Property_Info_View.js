var m_columns = null;
var editIndex;


//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('b0e5fab2-5fb7-48ea-916e-b5be0052c6b9') + "&XML=" + GetGetJson([{}]),

        async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;
    InitGird();
})

//初始化表格
function InitGird() {


    $('#tab_list').datagrid(
        {
            title: '账号管理系统系统列表', //表格标题
            url: GetWSRRURL('b0e5fab2-5fb7-48ea-916e-b5be0052c6b9'),
            queryParams: { "XML": GetGetJson([{}]) },
            sortName: 'system_id', //排序字段
            idField: 'system_id', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: false, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数         
            frozenColumns: [[
               { field: 'system_id', title: '系统ID',   width: 50, search: true, sortable: true },
               { field: 'system_code', title: '系统编号',  width: 60, search: true, sortable: true },
               { field: 'system_name', title: '系统名称',   width: 200, search: true, sortable: true },
               { field: 'system_sn', title: '系统简称', width: 80, search: true, sortable: true }
            ]]
         }
        );

    var $dg = $('#tab_list');
    $dg.datagrid("hideColumn", "rowindex");
    col = $dg.datagrid('getColumnOption', 'system_id');
    col.field = "test";
    $dg.datagrid("hideColumn", "test");
    col = $dg.datagrid('getColumnOption', 'system_code');
    col.field = "test1";
    $dg.datagrid("hideColumn", "test1");
    col = $dg.datagrid('getColumnOption', 'system_name');
    col.field = "test2";
    $dg.datagrid("hideColumn", "test2");
    col = $dg.datagrid('getColumnOption', 'system_sn');
    col.field = "test3";
    $dg.datagrid("hideColumn", "test3");
     
    $dg.datagrid();

}
