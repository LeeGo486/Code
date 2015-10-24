Ext.define("WMC.store.ITSMBasicInfoSB", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.ITSMBasicInfo',
    autoLoad: true,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/ITSMBasicInfo/GetBasicInfo?type=设备'
        },
        reader: {
            type: 'json'
        }
    }
});