Ext.define('WMC.common.store.Base', {
    extend: 'Ext.data.Store',
    constructor: function (config) {
        this.callParent([config]);
        this.proxy.on('exception', this.onProxyException, this);
    },
    onProxyException: function (proxy, response, operation, eOpts) {
        rst = Ext.JSON.decode(response.responseText);
        this.rejectChanges();
        Ext.Tools.Msg(rst.msg, rst.result);
    },
    config: {
        listeners: {
            write: function (store, operation) {
                var record = operation.getRecords()[0];
                rst = Ext.JSON.decode(operation.response.responseText);
                Ext.Tools.Msg(rst.msg, rst.result);
            }
        }
    }
});