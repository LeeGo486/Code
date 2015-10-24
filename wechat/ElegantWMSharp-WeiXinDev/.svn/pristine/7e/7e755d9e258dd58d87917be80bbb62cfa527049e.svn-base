Ext.define("WMC.store.WXLKRegMemberFans", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WXLKRegMemberFans',
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
            read: '/Admin/WXLKRegMemberFans/Get',
            update: '/Admin/WXLKRegMemberFans/Put',
            create: '/Admin/WXLKRegMemberFans/Post',
            destroy: '/Admin/WXLKRegMemberFans/Delete'
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