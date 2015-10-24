Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['WX_QR_Code', 'Account'],
    stores: ['WX_QR_Code', 'Account'],
    views: ['MainGrid', 'EditWin'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [{
        ref: 'mainGrid',
        selector: 'maingrid'
    },
        {
            ref: 'editWin',
            selector: 'editwin',
            autoCreate: true,
            xtype: 'editwin'
        }],
    //声明监控事件
    init: function () {
        this.control({
            //'maingrid': {
            //    itemdblclick: this.editRecord
            //},
            'editwin button[action=btnSave]': {
                click: this.saveRecord
            },
            'maingrid button[action=btnAdd]': {
                click: this.addRecord
            },
            'maingrid combobox[name=cbAccount]': {
                select: this.loadCodeScan
            }
        });
    },

    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("WX_QR_Code", this.getMainGrid(), false);
    },
    //新增
    addRecord: function () {
        var accountInfo = this.getAccountId();
        if (accountInfo == null || accountInfo == "") {
            Ext.Tools.Msg("请先选择公众号！", 1);
        } else {
            var win = this.getEditWin();
            //var form = win.down("form");
            //form.findField(AccountId).setValue("1")

            //form.loadRecord(record);
            win.show();
            //Ext.get('AccountId').setValue("1");
            //Ext.get(AccountId).setValue(accountInfo)
            //var form = this.getEditWin().win.down("form");
            //model.AccountId="11"
        }
    },
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getEditWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
    },
    getAccountId: function () {
        var accountInfo = this.getMainGrid().down("combobox[name=cbAccount]");
        return accountInfo.getValue();
    },
    loadCodeScan: function () {
        var mainStore = this.getMainGrid().getStore();
        mainStore.getProxy().setExtraParam("accountId", this.getAccountId());
        mainStore.load();
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
                var accountInfo = this.getAccountId();
                model.AccountId = accountInfo;
                store.add(model);
            }
            win.close();
            store.sync();
        }
    },
});
