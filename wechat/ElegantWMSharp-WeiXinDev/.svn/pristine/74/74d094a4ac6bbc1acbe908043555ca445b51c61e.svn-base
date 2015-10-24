Ext.define("WMC.store.ITSMEvent", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.ITSMEvent',
    autoLoad: true,
    autoSync: false,
    pageSize: 30,
    sorters: [{
        property: 'CreateTime',
        direction: 'DESC'
    }],
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update: 'PUT',
            create: 'POST',
            destroy: 'DELETE'
        },
        api: {
            read: '/Admin/ITSMEvent/Get',
            update: '/Admin/ITSMEvent/Put',
            create: '/Admin/ITSMEvent/Post',
            destroy: '/Admin/ITSMEvent/Delete'
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