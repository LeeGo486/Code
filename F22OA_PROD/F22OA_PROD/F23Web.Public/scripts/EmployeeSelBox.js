$(function() {

    $('#btnsubmit').removeAttr('disabled');

});
// submit
function e_submit() {

    var ids = [], names = [], majors = [];

    // 选中的营业员
    $.each(GridControl1.fnGetNodes(), function() {
        var row = this;
        if ($(row).hasClass('row_selected')) {
            var id = $('td', this).eq(0).text();
            ids.push(id);
            names.push($('td', this).eq(2).text());
        }
    });

    // 主要的营业员
    var v = $('input:radio[name="isMajor"]:checked').val();
    majors.push(v);

    // 
    var obj = { ids: ids.toString(), names: names.toString(), majors: majors.toString() }

    //alert($.toJSON(obj)); return;

    window.returnValue = obj;
    window.close();
}
// cancel
function e_cancel() {
    window.returnValue = null;
    window.close();
}

// major render
function majorRender(obj) {
    var v = obj.aData[0];
    return '<input type="radio" name="isMajor" class="edit" value="' + v + '" />';
}

// rowselected
function rowselected(row) {
    var rd = $('input:radio', row);
    if ($(row).hasClass('row_selected')) {
        if ($('input:radio[name="isMajor"]:checked').size() == 0) {
            rd.attr('checked', 'checked');
        }
    } else {
        rd.removeAttr('checked');
        //if ($('input:radio[name="isMajor"]:checked').size() == 0) {
        //  $('input:radio', 'tr.row_selected:first').attr('checked', 'checked');
        //}
    }
}