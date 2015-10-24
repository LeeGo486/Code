 
/***********************************************************************
  * 
  *  菜单单击事件
  *  参数： type 控制有没有超链接，
  *         type1控制超链接在第二级还是第三极，以及第四级的显示
  *  返回值：  
  */
function page_pTopDisplay(type, type1, l1, l2, l3) { 
    //设置页面顶部标签  
    $('#pTopLabel1').text(dataUtil_undefinedOrNull(l1, $('#pTopLabel1').text()));
    if (type == 'new' || type == 'N') {
        $('#pTopLabel2').text(dataUtil_undefinedOrNull(l2, $('#pTopLabel2').text()));
        $('#pTopLabel3').text(dataUtil_undefinedOrNull(l3, $('#pTopLabel3').text()));
    } else {
        if (type1 == 'task') {
            $('#pTopLabel2_a').text(dataUtil_undefinedOrNull(l2, $('#pTopLabel2_a').text()));
            $('#pTopLabel3').text(dataUtil_undefinedOrNull(l3, $('#pTopLabel3').text()));
        } else {
            $('#pTopLabel2').text(dataUtil_undefinedOrNull(l2, $('#pTopLabel2').text()));
            $('#pTopLabel3_a').text(dataUtil_undefinedOrNull(l3, $('#pTopLabel3_a').text()));
            $('#pTopSpan').show();
        }
    } 
}