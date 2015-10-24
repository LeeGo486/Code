Ext.define('HRJobs.view.Jobs', {
    extend: 'Ext.NavigationView',
    xtype: 'jobs',
    config: {
        fullscreen: true,
        defaultBackButtonText: '返回',
        navigationBar: {
            items: [
                {
                    xtype: 'button',
                    text: '分享',
                    align: 'right',
                    ui: 'plain',
                    handler: function () {
                        Ext.Msg.alert('提示', "单击右上角“微信分享按钮”");
                    }
                }
            ]
        },
        items: [
            {
                id: 'jobList',
				title: '招聘职位',
                xtype: 'joblist'
            }
        ]
    }
});
