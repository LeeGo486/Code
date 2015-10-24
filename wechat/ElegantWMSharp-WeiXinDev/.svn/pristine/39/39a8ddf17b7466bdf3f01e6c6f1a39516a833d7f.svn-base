Ext.define("WMC.store.ITSMEngineer", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.ITSMEngineer',
    autoLoad: true,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/ITSMEngineer/GetAll'
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