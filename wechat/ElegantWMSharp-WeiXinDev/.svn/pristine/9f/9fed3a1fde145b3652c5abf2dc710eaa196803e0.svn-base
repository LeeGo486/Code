Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['HRQuestion'],
    stores: ['HRQuestion'],
    views: ['MainGrid', 'EditWin'],
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
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("HRQuestion", this.getMainGrid(), false);
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
                //record = Ext.create('WMC.model.HRQuestion', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
				model["Id"] = Ext.data.IdGenerator.get('uuid').generate();
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
