Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['WX_QR_CodeScanFans', 'Account'],
    stores: ['WX_QR_CodeScanFans', 'Account'],
    views: ['MainGrid'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [{
        ref: 'mainGrid',
        selector: 'maingrid'
    }],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid combobox[name=cbAccount]': {
                select: this.loadCodeScanFans
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("WX_QR_CodeScanFans", this.getMainGrid(), false);
    },
    getAccountId: function () {
        var accountInfo = this.getMainGrid().down("combobox[name=cbAccount]");
        return accountInfo.getValue();
    },
    loadCodeScanFans: function () {
        var mainStore = this.getMainGrid().getStore();
        mainStore.getProxy().setExtraParam("accountId", this.getAccountId());
        mainStore.load();
    },

    //新增
    addRecord: function () {
        rowEditing = this.getMainGrid().getPlugin("rowEditor");
        rowEditing.cancelEdit();
        var r = Ext.create('WMC.model.WX_QR_CodeScanFans', {
            Id: Ext.data.IdGenerator.get('uuid').generate()
        });
        this.getMainGrid().getStore().insert(0, r);
        rowEditing.startEdit(0, 0);
        rowEditing.enable();
        rowEditing.editor.floatingButtons.child('#update').setDisabled(false);
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
