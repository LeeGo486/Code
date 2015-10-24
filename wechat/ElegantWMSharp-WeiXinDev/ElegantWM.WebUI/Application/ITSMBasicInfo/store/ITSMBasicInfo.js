Ext.define("WMC.store.ITSMBasicInfo", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.ITSMBasicInfo',
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
            read: '/Admin/ITSMBasicInfo/Get',
            update: '/Admin/ITSMBasicInfo/Put',
            create: '/Admin/ITSMBasicInfo/Post',
            destroy: '/Admin/ITSMBasicInfo/Delete'
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