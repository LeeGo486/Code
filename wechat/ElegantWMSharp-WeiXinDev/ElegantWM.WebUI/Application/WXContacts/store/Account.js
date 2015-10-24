
Ext.define('WMC.store.Account', {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.Account',
    autoLoad: true,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/WXAccount/GetTntAccount'
        },
        reader: {
            type: 'json'
        }
    }
});