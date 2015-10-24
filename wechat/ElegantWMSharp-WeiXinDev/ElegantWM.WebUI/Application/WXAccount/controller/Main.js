Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['WXAccount'],
    stores: ['WXAccount'],
    views: ['MainGrid', 'EditWin','EditMenuWin'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [
        {
            ref: 'mainGrid',
            selector: 'maingrid'
        },
        {
            ref: 'editWin',
            selector: 'editwin',
            autoCreate: true,
            xtype: 'editwin'
        },
        {
            ref: 'editMenuWin',
            selector: 'editmenuwin',
            autoCreate: true,
            xtype: 'editmenuwin'
        }
    ],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                itemdblclick: this.editRecord
            },
            'editwin button[action=btnSave]': {
                click: this.saveRecord
            },
            'maingrid button[action=btnAdd]': {
                click: this.addRecord
            },
            'maingrid button[action=btnDelete]': {
                click: this.deleteRecord
            },
            'maingrid button[action=btnMenu]': {
                click: this.updateMenu
            },
            'editmenuwin button[action=btnUploadMenu]': {
                click: this.saveMenu
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("WXAccount", this.getMainGrid(), false);
    },
    //新增
    addRecord: function () {
        this.getEditWin().show();
    },
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getEditWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
    },
    //编辑微信菜单
    updateMenu:function(){
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的微信账号！", 1);
            return;
        }
        var records = selModel.getSelection();
        if (records.length != 1) {
            Ext.Tools.Msg("只能对一个微信账号操作！", 1);
            return;
        }
        var win = this.getEditMenuWin();
        win.show();

        var myMask = new Ext.LoadMask(win, { msg: "菜单获取中..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXAccount/GetMenu',
            method: 'GET',
            params: {
                sid: records[0].get("Id")
            },
            scope: this,
            success: function (response) {
                myMask.hide();
                win.down("form [name=wxmenu]").setValue(response.responseText);
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //编辑微信菜单
    saveMenu: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的微信账号！", 1);
            return;
        }
        var records = selModel.getSelection();
        if (records.length != 1) {
            Ext.Tools.Msg("只能对一个微信账号操作！", 1);
            return;
        }
        var win = this.getEditMenuWin();
        var myMask = new Ext.LoadMask(win, { msg: "菜单上传中..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXAccount/SaveMenu',
            method: 'POST',
            params: {
                sid: records[0].get("Id"),
                menuJson: win.down("form [name=wxmenu]").getValue()
            },
            scope: this,
            success: function (response) {
                myMask.hide();
                Ext.Tools.Alert("结果", response.responseText, "I");
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //保存
    saveRecord: function () {
        var win = this.getEditWin();
        var form = win.down("form");
        var model = form.getValues();
        if (form.isValid()) {
            record = form.getRecord();
            var store = this.getMainGrid().getStore();
            if (record) {//如果是修改
                record.set(model);
            }
            else {
                //record = Ext.create('WMC.model.WXAccount', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
                store.add(model);
            }
            //Date类型的需要重新赋值才起作用，很奇怪
            //record.data.Birthday = model.Birthday;
            win.close();
            store.sync();
        }
    },
    //删除
    deleteRecord: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的行！", 1);
            return;
        }
        var records = selModel.getSelection();
        Ext.MessageBox.confirm("警告", "是否要彻底删除这些信息吗？", function (button, text) {
            if (button == "yes") {
                grid.getStore().remove(records);
                grid.getStore().sync();//保存
            }
        });
    }
});
