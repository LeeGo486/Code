Ext.define("HRJobs.store.Jobs", {
    extend: 'HRJobs.store.Base',    
    config: {
        model: 'HRJobs.model.Jobs',
        proxy: {
            type: "rest",
            url:'/Admin/HRJobs/Get',
            reader: {
                type: "json",
                rootProperty: "data"
            }
        },
        pageSize: 30,
        autoLoad: true
    }
});