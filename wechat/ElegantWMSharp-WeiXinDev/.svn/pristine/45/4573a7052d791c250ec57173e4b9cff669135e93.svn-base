Ext.define("WMC.store.WXMenu", {
    extend: 'Ext.data.TreeStore',
    model: 'WMC.model.WXMenu',
    autoLoad: false,
    autoSync: false,
    root: {
        text: '微信菜单',
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
            read: '/Admin/WXMenu/Get',
            update: '/Admin/WXMenu/Put',
            create: '/Admin/WXMenu/Post',
            destroy: '/Admin/WXMenu/Delete'
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