Ext.define('HRJobs.view.JobDetail', {
    extend: 'Ext.Container',
    xtype: 'jobdetail',
    config: {
        layout: 'vbox',
        title: '职位介绍',
        items: [
            {
                id:'jobDetailHeader',
                tpl: [
                     '<div class="kbInfo">',
                         '<div class="head">',
                         '<h3>{JobName}</h3>',
                         '<span>招聘人数：{NeedNum} &nbsp;&nbsp;&nbsp;&nbsp;发布时间：{CreateTime}<br />',
                         '应聘邮箱：<a href="mailto:{Email}" target="_blank">{Email}</a></span>',
                         '</div>',
                     '</div>'
                ].join('')
            },
            {
                flex: 1,
                layout: 'vbox',
                scrollable: {
                    direction: 'vertical',
                    directionLock: true
                },
                items: [
                        {
                            id: 'jobDetailContent',
                            tpl: [
                                 '<div class="kbInfo">',
                                     '<div class="content"><h4 class="title">岗位职责<h4>{Responsibilities}<br /><br />',
                                     '<h4 class="title">任职要求</h4>{Skills}</div>',
                                 '</div>'
                            ].join('')
                        }
                ]
            }, {
                xtype: 'button',
                action:'btnApply',
                ui: 'action',
                margin: '10 20 10 20',
                text: '申请该职位'
            }
        ]
    }
});