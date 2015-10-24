Ext.define("WMC.store.NPaiaVipUser", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.NPaiaVipUser',
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
            read: '/Admin/NPaiaVipUser/Get',
            update: '/Admin/NPaiaVipUser/Put',
            create: '/Admin/NPaiaVipUser/Post',
            destroy: '/Admin/NPaiaVipUser/Delete'
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