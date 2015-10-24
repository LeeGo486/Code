Ext.define("WMC.store.OO_MenuTemplate", {
    extend: 'Ext.data.TreeStore',
    model: 'WMC.model.OO_MenuTemplate',
    autoLoad: false,
    autoSync: false,
    root: {
        text: '模板菜单',
        id: '00000000-0000-0000-0000-000000000000'
    },
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update: 'PUT',
            create: 'POST',
            destroy: 'DELETE'
        },
        api: {
            read: '/Admin/OO_MenuTemplate/Get',
            update: '/Admin/OO_MenuTemplate/Put',
            create: '/Admin/OO_MenuTemplate/Post',
            destroy: '/Admin/OO_MenuTemplate/Delete'
        },
        reader: {
            type: 'json'
        },
        writer: {
            type: 'json'
        }
    },
    sorters: [{
        property: 'OrderIndex',
        direction: 'ASC'
    }],
    constructor: function (config) {
        this.callParent([config]);
        this.proxy.on('exception', this.onProxyException, this);
    },
    onProxyException: function (proxy, response, operation, eOpts) {
        rst = Ext.JSON.decode(response.responseText);
        Ext.Tools.Msg(rst.msg, rst.result);
    },
    listeners: {
        write: function (store, operation) {
            var record = operation.getRecords()[0];
            rst = Ext.JSON.decode(operation.response.responseText);
            Ext.Tools.Msg(rst.msg, rst.result);
        }
    },
    onUpdateRecords: function (records, operation, success) {
        records = operation.records;
        if (success) {
            Ext.each(records, function (record) {
                record.commit();
            });
        }
        this.callParent(arguments);
    }
});