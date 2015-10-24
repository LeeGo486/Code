Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['HRQARst'],
    stores: ['HRQARst'],
    views: ['MainGrid'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [{
        ref: 'mainGrid',
        selector: 'maingrid'
    }],
    //声明监控事件
    init: function () {
        this.control({
            'maingrid': {
                //编辑
                edit: function (editor, e) {
                    this.getMainGrid().getStore().sync();//保存 
                },
                itemclick: this.rowEditorUpdateBtnDisable,
                itemdblclick: this.rowEditorUpdateBtnDisable
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
        //Ext.Tools.CtrlButtonsByPermession("HRQARst", this.getMainGrid(), false);
    },
    //解决rowEditor插件的按钮bug
    rowEditorUpdateBtnDisable: function (me, record, item, index, e, eOpts) {
        if (this.getMainGrid().getPlugin("rowEditor").editor) {
            this.getMainGrid().getPlugin("rowEditor").editor.floatingButtons.child('#update').setDisabled(false);
        }
    },
    //新增
    addRecord: function () {
        rowEditing = this.getMainGrid().getPlugin("rowEditor");
        rowEditing.cancelEdit();
        var r = Ext.create('WMC.model.HRQARst', {
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
