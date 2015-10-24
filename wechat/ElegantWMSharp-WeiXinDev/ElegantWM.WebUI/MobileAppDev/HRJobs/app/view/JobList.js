Ext.define('HRJobs.view.JobList', {
    extend: 'Ext.List',
    xtype: 'joblist',
    requires: [
       'HRJobs.store.Jobs'
    ],
    config: {
        cls: 'hrItem',
        store: 'Jobs',
        masked: false,
        emptyText: '没有数据！',
        padding: 5,
        plugins: [
            {
                xclass: 'Ext.plugin.ListPaging',
                noMoreRecordsText: '-End-',
                loadMoreText: 'Loading',
                autoPaging: true
            }
        ],
        itemTpl: '<div><div class="badge">招聘人数:{NeedNum}</div>'
                + '<h2>{JobName}</h2>'
                + '<span>发布时间：{CreateTime}</span>'
                + '</div>'
    }
});