//初始化
$(function () {

    $('#tabList').datagrid(
       {
           title: 'WS列表', //表格标题
           url: GetWSRRURL('026dab94-eb33-4dd4-b57f-2cb06de57aea'),
           queryParams: { "XML": GetGetJson([{ "entity": "entity" }]) },
           width: 1200,
           height: 220,
           nowrap: false, //是否换行，True 就会把数据显示在一行里
           striped: true, //True 奇偶行使用不同背景色
           collapsible: false, //可折叠
           sortOrder: 'asc', //排序类型
           remoteSort: false, //定义是否从服务器给数据排序
           singleSelect: true, //单行选择

           columns: [[
               { field: 'colvalue11', title: '测试库服务器', width: 150 } ,
               { field: 'id', title: '编号', search: true, sortable: true },               
               {
                   field: 'picurl', title: '款图', width: 100, formatter: function (value, row, index) {
                       var data = "<a href='" + value + "' target='_blank'><img  src='" + value + "' style='height:70px' border='0'/></a>";
                       
                       this.formatDataType = "Pic";
                       return data;
                   }
               },

               { field: 'col1', title: '测试列1', width: 100, search: true, sortable: true },
               { field: 'col2', title: '类型', width: 60, search: true, sortable: true },
               { field: 'colint', title: '说明', width: 160, sortable: true, align: 'right', halign: 'right', formatter: Formater.Nums },
               { field: 'coldecimal', title: '状态', width: 50, sortable: true, align: 'right', formatter: Formater.Account },
               { field: 'coldatetime', title: '正式库服务器', width: 150, sortable: true, formatter: Formater.DateTime } 
           ]],
           pagination: true, //是否开启分页
           pageNumber: 1, //默认索引页
           pageSize: 3, //默认一页数据条数
           rownumbers: true,
           exportExcel:true,
           toolbar: [
           {
               id: 'btnAddReplaceSub',
               text: '新增',
               iconCls: 'icon-add',
               handler: function () {
                   //addReplaceSub();
               }
           }]
       }
       );

    //var pager = $('#tabList').datagrid().datagrid('getPager');    // get the pager of datagrid
    //pager.pagination({
    //    buttons: [{
    //        iconCls: 'icon-excel',
    //        handler: function () {
    //            ExcelExport('#tabList');
    //        }
    //    }]
    //});

})
//$(function () {

    
//    $('#dd').tooltip({
//        hideEvent: 'none',
//        content: function () {
//            return $('#toolbar');
//        },
//        onShow: function () {
//            var t = $(this);
//            t.tooltip('tip').focus().unbind().bind('blur', function () {
//                t.tooltip('hide');
//            });
//        }
//    });

//    $('#pg').pagination().find('a.l-btn').tooltip({
//        content: function () {
//            var cc = $(this).find('span.l-btn-icon').attr('class').split(' ');
//            var icon = cc[1].split('-')[1];
//            return icon + ' page';
//        }
//    });
//    $('#tabList').pagination().find('a.l-btn').tooltip({
//        content: function () {
//            var cc = $(this).find('span.l-btn-icon').attr('class').split(' ');
//            var icon = cc[1].split('-')[1];
//            return icon + ' page';
//        }
//    });
//});

