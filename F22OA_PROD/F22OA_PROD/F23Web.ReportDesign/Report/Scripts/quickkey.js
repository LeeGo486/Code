$(function () {
    $(document).bind('keydown', 'ctrl+1', sale);
    $(document).bind('keydown', 'ctrl+2', customotherstock);
    $(document).bind('keydown', 'ctrl+3', otherstock);
    $(".field").bind('keydown', 'ctrl+1', sale);
   
});

function sale() {
    activatetab("docs-b28web");
}

function customotherstock() {
    activatetab("docs-other-custom")
}

function otherstock() {
    activatetab("docs-other")
}

function activatetab(id) {//刷新当前标签    
    try {
        var mainPanel = parent.parent.Ext.getCmp("doc-body");
        var fid = id.replace("docs-", "iframe-");
        var frm = top.frames[fid];
        var title = id.replace("docs-", "");
        //方法一:关闭当前标签,再生成一个
        //mainPanel.remove(id);
        if (id == "docs-b28web") {
            mainPanel.loadClass("../b28web/retail/default.aspx", "收银")
        }
        if (id == "docs-other-custom") {
            mainPanel.loadClass("../reportdesign/report/preview.aspx?menusubid=3999001", "其它店铺库存查询")
        }
        if (id == "docs-other") {
            mainPanel.loadClass("../pos/pos/f22/report/f22qry_otherkcsub.asp", "其它店铺库存查询")
        }
    } catch (e) {
    }
}
