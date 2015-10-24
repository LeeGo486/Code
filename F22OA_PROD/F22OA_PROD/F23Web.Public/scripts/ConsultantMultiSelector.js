$(function () {
    $('#btnsubmit').removeAttr('disabled');
});

function e_save(obj) {

}

function e_submit() { 
    var d = [];
    var t = [];
    d = MultiSelector1.fnGetSelected();  
    //t = MultiSelector1.fnGetSelectedText();
    //var data = { consultantid: d, names: t };  
    window.returnValue = $.toJSON(d);   
    window.close();
}

function e_cancel() {
    window.returnValue = false;
    window.close();
}