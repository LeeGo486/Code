Ext.define("WMC.store.HRQuestion", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRQuestion',
    autoLoad: true,
    autoSync: false,
    pageSize: 30,
    groupField: 'QsnCategory',
    sorters: [{
        property: 'QsnCategory',
        direction: 'ASC'
    }, { 
        property: 'QsnName',
        direction: 'ASC'
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
            read: '/Admin/HRQuestion/Get',
            update: '/Admin/HRQuestion/Put',
            create: '/Admin/HRQuestion/Post',
            destroy: '/Admin/HRQuestion/Delete'
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