Ext.define("WMC.store.ITSMBasicInfoYY", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.ITSMBasicInfo',
    autoLoad: true,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/ITSMBasicInfo/GetBasicInfo?type=应用'
        },
        reader: {
            type: 'json'
        }
    }
});