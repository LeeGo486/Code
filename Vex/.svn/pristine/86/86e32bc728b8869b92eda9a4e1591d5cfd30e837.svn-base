

//初始化
$(function () {
    $("#txtKeyWord").focus();
});



function SearchHighlight(idVal,keyword) 
{ 
    var pucl = document.getElementById(idVal); 
    if("" == keyword) return; 
    var temp=pucl.innerHTML; 
    var htmlReg = new RegExp("\<.*?\>","i"); 
    var arrA = new Array(); 
    //替换HTML标签 
    for(var i=0;true;i++) 
    { 
        var m=htmlReg.exec(temp); 
        if(m) 
        { 
            arrA[i]=m; 
        } 
        else 
        { 
            break; 
        } 
        temp=temp.replace(m,"{[("+i+")]}"); 
    } 
    words = unescape(keyword.replace(/\+/g,' ')).split(/\s+/); 
    //替换关键字 
    for (w=0;w<words.length;w++) 
    { 
        var r = new RegExp("("+words[w].replace(/[(){}.+*?^$|\\\[\]]/g, "\\$&")+")","ig"); 
        temp = temp.replace(r,"<b style='color:Red;'>$1</b>"); 
    } 
    //恢复HTML标签 
    for(var i=0;i<arrA.length;i++) 
    { 
        temp=temp.replace("{[("+i+")]}",arrA[i]); 
    } 
    pucl.innerHTML=temp; 
} 

////初始化表格
//function btn_Search_Click1() {
//    SearchHighlight("result", "dd fdddde");
//}

//初始化表格
function btn_Search_Click() {
    var strKeyWord = $("#txtKeyWord").val();

    $('#tab_list').datagrid(
        {
            title: 'WS列表', //表格标题
            url: GetWSRRURL('6243efdc-1bef-42da-b28f-c673e8bd7e7c'),
            queryParams: { "XML": GetGetJson([{ "KeyWord": strKeyWord }]), "HeihgRightKeyWord": strKeyWord },

            idField: 'ws_id', //标识字段,主键
            iconCls: '', //标题左边的图标
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            sortOrder: 'asc', //排序类型
            remoteSort: false, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            columns: [[
                 { field: 'function_name', title: '方法名称', width: 160, search: true, sortable: true },
                 { field: 'ws_sp_server', title: 'SP部署', width: 160, search: true, sortable: true },
                 { field: 'ws_spname', title: 'SP名称', width: 180, search: true, sortable: true },
                 { field: 'ws_deployserver', title: '服务部署', width: 130, search: true, sortable: true },
                 { field: 'state', title: '状态', width: 50, search: true, sortable: true },
                 { field: 'appliay_user', title: '申请人', width: 60, search: true, sortable: true },
                 { field: 'applay_time', title: '申请时间', width: 120, search: true, sortable: true },

                 { field: 'input_format', title: '输入格式', width: 130, search: true, hidden: false },
                 { field: 'return_format', title: '返回格式', width: 130, search: true, hidden: false }
            ]],
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	            { field: 'ws_applay_id', title: '服务编号', width: 180, hidden: true },
	            {
	                field: 'service_path', title: '服务路径', width: 190, search: true, sortable: true,
	                formatter: function (value, row, index) {
	                    var content = '<div title="' + row.ws_content + '">' + value + '</div>';
	                    return content;
	                }
	            },
                {
                    field: 'ws_name', title: '服务名称', width: 100, search: true, sortable: true,
                    formatter: function (value, row, index) {
                        var content = '<div title="' + row.ws_content + '">' + value + '</div>';
                        return content;
                    }
                }
            ]],
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 50, //默认一页数据条数
            rownumbers: true//行号

        }
        );
}
