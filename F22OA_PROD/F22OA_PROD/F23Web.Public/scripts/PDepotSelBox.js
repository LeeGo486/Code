$(function() {
    $('button[name="save"]').click(e_submit);
    $('button[name="cancel"]').click(e_cancel);
    $(document).bind('keydown', 'esc', e_cancel);
    $(document).bind('keydown', 'return', e_submit);
    $('#btnsubmit').removeAttr('disabled');
});

function e_submit() {
    if ($('button[name="save"]').is('[disabled]')) return;
    var rows = GridControl1.fnGetSelected();
    if (rows.length != 1) { alert("请选择一条记录!"); return ''; };
    var columns = GridControl1.fnSettings().aoColumns;
    var data = GridControl1.fnGetData(rows[0]);
    var obj = new Object();
    $.each(columns, function(i, o) {
        obj[o.sName] = data[i];
    });


    //alert($.toJSON(obj));  return;    
    window.returnValue = obj;
    window.close();
}

function e_cancel() {
    window.close();
}
