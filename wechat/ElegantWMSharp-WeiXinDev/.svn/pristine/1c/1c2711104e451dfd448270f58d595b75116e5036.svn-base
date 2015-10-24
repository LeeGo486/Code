Ext.define("WMC.store.WXAccount", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WXAccount',
    autoLoad: true,
    autoSync: false,
    pageSize: 30,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update: 'PUT',
            create: 'POST',
            destroy: 'DELETE'
        },
        api: {
            read: '/Admin/WXAccount/Get',
            update: '/Admin/WXAccount/Put',
            create: '/Admin/WXAccount/Post',
            destroy: '/Admin/WXAccount/Delete'
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'total'
        },
        writer: {
            type: 'json'
        }
    }
});