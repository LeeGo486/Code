Ext.define('WMC.view.TpltWin', {
    extend: 'Ext.window.Window',
    alias: 'widget.tpltwin',
    title: '使用行业模板',
    modal: true,
    width: 300,
    iconCls:'',
    closeAction: 'hide',
    items: [{
        xtype: 'grid',
        height: 300,
        store: 'OO_Industry',
        border: 0,
        columns: [
            {
                xtype: 'rownumberer',
                sortable: false
            },
            {
                text: 'ID',
                hidden: true,
                menuDisabled: true,
                dataIndex: 'Id'
            }, {
                text: '行业模板名称',
                width: 120,
                flex: 1,
                menuDisabled: true,
                sortable: true,
                dataIndex: 'IndustryName'
            }],
        selModel: Ext.create('Ext.selection.CheckboxModel', { mode: 'SINGLE' }),
        emptyText: '没有找到任何数据'
    }],
    buttons: [{
        text: '取消',
        handler: function () {
            this.up('window').close();
        }
    },
    {
        text: '应用模板',
        iconCls: 'Disk',
        action: 'btnApplyTplt'
    }]
});