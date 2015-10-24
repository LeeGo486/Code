Ext.define('HRJobs.store.Base', {
    extend: 'Ext.data.Store',
    config: {
        proxy: {
            scope: this,
            listeners: {
                exception: function (proxy, response) {
                    console.log(response.responseText);
                    var rst = Ext.decode(response.responseText);
                    Ext.Msg.alert('异常', rst.msg);
                }
            }
        }
    }
});
